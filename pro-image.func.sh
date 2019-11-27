#!/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/conf.sh

###
# 计算变量
###
pm_nodejs_app_path="${nodejs_project_path_in_phsyics}"
nodejs_app_path="$project_path_in_vm" #"/nodejs/app/name"
nodejs_app_name=$(echo "$nodejs_app_path" | sed "s#/#_#g" | sed "s#-#_#g" | sed "s#^_##g" | tr "[:upper:]" "[:lower:]")
#nodejs_app_xx
nodejs_app_tag="1.0.0"
nodejs_app_namespace="yemiancheng"
nodejs_app_version="1.0.0"

function get_image_repo() {
  local type="pub"
  local rp_host=
  local res=
  if [ $type = "pub" ]; then
    rp_host="registry.cn-hangzhou.aliyuncs.com"
  elif [ $type = "vpc" ]; then
    rp_host="registry-vpc.cn-hangzhou.aliyuncs.com"
  elif [ $type = "pri" ]; then
    rp_host="registry-internal.cn-hangzhou.aliyuncs.com"
  else
    rp_host="registry.cn-hangzhou.aliyuncs.com"
  fi
  local rp_ns="$nodejs_app_namespace"
  local rp_name="$nodejs_app_name"
  res="${rp_host}/${rp_ns}/${rp_name}"
  echo "$res"
}
image_repo=$(get_image_repo "pub")
###
# 构建镜像
###
#构建所有阶段
function build_image_all_stage() {
  local tag=
  local dockerfile=
  tag="$nodejs_app_name"
  if [ -n "${1}" ]; then
    tag="${1}"
  fi
  dockerfile="$pm_nodejs_app_path"
  if [ -n "${1}" ]; then
    dockerfile="${1}"
  fi

  docker build --tag "${image_repo}:${tag}" "$dockerfile"
}
#构建某一阶段
function build_image_by_stage() {
  local list=
  local REG_SHELL_COMMOMENT_PATTERN=
  local list_ARR=
  local var=
  local key=
  local val=
  list=$(
    cat <<EOF
stage-base=base
stage-deps=dependencies
stage-build=build
stage-pro=pro
EOF
  )
  if [ -n "${1}" ]; then
    list="${1}"
  fi
  REG_SHELL_COMMOMENT_PATTERN="^#"
  list_ARR=(${list//,/ })
  for var in ${list_ARR[@]}; do
    if [[ "$var" =~ $REG_SHELL_COMMOMENT_PATTERN ]]; then
      echo "$var" >/dev/null 2>&1
    else
      key=$(echo "$var" | cut -d "=" -f1 | tr "[:upper:]" "[:lower:]")
      val=$(echo "$var" | cut -d "=" -f2 | tr "[:upper:]" "[:lower:]")
      echo "build image with stage $key"
      docker build --target "$val" --tag "${image_repo}:$key" "$pm_nodejs_app_path"
    fi
  done
}
### func-usage
# build_image_by_stage

###
# 查看镜像
###
function list_image_by_repo() {
  docker image ls | grep "${image_repo}"
}

###
# 运行镜像(测试)
###
function run_pro_image_for_test() {
  docker run --rm -it -p 7001:7001 "${image_repo}:stage-pro"
}
function run_pro_image() {
  local name=
  local tag=
  local list=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi
  tag=stage-pro
  if [ -n "${2}" ]; then
    tag="${2}"
  fi
  #echo "$name=${image_repo}:$tag"
  list=$(docker inspect -f='{{.ID}}={{.Name}}' $(docker ps -aq) | grep "$name")
  if [ $? -eq 0 ]; then
    echo "has been created before"
  else
    #docker run -dit -p 7001:7001 --name "$name" ${image_repo}:$tag
    #fix:exited (0)  after starting and finishing main process
    docker run -dit -p 7001:7001 --name "$name" ${image_repo}:$tag /bin/sh -c "tail -f /dev/null"
  fi
}

###
# 列出容器
###
function list_pro_container_by_name() {
  local list=
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi
  #list=$(docker inspect -f='{{.ID}}={{.Name}}' $(docker ps -aq) | grep "$name")
  list=$(docker inspect -f='{{.ID}}={{.Name}}' $(docker ps -aq) | grep "$name")
  echo "list CM $name"
  echo "$list"
}

function inspect_pro_container_by_name() {
  local list=
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi

  echo "inspect CM $name"
  docker inspect "$name"
}

###
# 启动容器
###
function start_pro_container_by_name() {
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi
  echo "start CM $name"
  docker start "$name"
}

###
# 进入容器
###
function goto_pro_container_for_test() {
  docker run --rm -it "${image_repo}:stage-pro" /bin/sh <<EOF
ls
exit
EOF
}
function goto_pro_container_by_name() {
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi
  echo "goto CM $name"
  echo "docker exec -it --workdir ${project_path_in_vm} ${name} /bin/sh"
  docker exec -it --workdir $project_path_in_vm $name /bin/sh
}

###
# 关闭容器
###
function stop_pro_container_by_name() {
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi
  echo "stop CM $name"
  docker stop "$name"
}

###
# 查看容器日志
###
function log_pro_container_by_name() {
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi
  echo "see CM $name log"
  docker logs "$name"
}

###
# 删除容器
###
function delete_pro_container_by_name() {
  local list=
  local REG_SHELL_COMMOMENT_PATTERN=
  local list_ARR=
  local var=
  local key=
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi

  list=$(docker inspect -f='{{.ID}}={{.Name}}' $(docker ps -aq) | grep "$name")
  REG_SHELL_COMMOMENT_PATTERN="^#"
  list_ARR=(${list//,/ })
  for var in ${list_ARR[@]}; do
    if [[ "$var" =~ $REG_SHELL_COMMOMENT_PATTERN ]]; then
      echo "$var" >/dev/null 2>&1
    else
      key=$(echo "$var" | cut -d "=" -f1 | tr "[:upper:]" "[:lower:]")
      echo "rm pro container $key"
      docker container rm "$key"
    fi
  done
}

###
# 删除镜像
###
# 删除虚悬镜像
# docker rmi $(docker images -q -f dangling=true)
function local_none_image() {
  local list=
  list=$(docker images -q -f dangling=true)
  if [ -n "$list" ]; then
    docker rmi "$list"
  fi
}
# 删除某些镜像
function local_delete_image_by_tag() {
  local list=
  local REG_SHELL_COMMOMENT_PATTERN=
  local list_ARR=
  local var=
  local key=
  local tag=
  tag=test
  if [ -n "${1}" ]; then
    tag="${1}"
  fi
  list=$(docker image ls --format " {{.ID}}={{.Repository}}" | grep "${image_repo}:$tag")
  REG_SHELL_COMMOMENT_PATTERN="^#"
  list_ARR=(${list//,/ })
  for var in ${list_ARR[@]}; do
    if [[ "$var" =~ $REG_SHELL_COMMOMENT_PATTERN ]]; then
      echo "$var" >/dev/null 2>&1
    else
      key=$(echo "$var" | cut -d "=" -f1 | tr "[:upper:]" "[:lower:]")
      echo "rm pratice image $key"
      docker image rm "$key"
    fi
  done
}

###
# 推送镜像
###
function push_image() {
  local tag=
  tag=test
  if [ -n "${1}" ]; then

    tag="${1}"
  fi
  docker push "${image_repo}:$tag"
}
