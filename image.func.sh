#!/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/conf.sh

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
  #fix:unable to prepare context: path "1.0.0" not found
  if [ -n "${2}" ]; then
    dockerfile="${2}"
  fi
  echo "build image ${image_repo}:${tag} with dockerfile $dockerfile"
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
# 运行镜像
###
function run_image() {
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
    #docker run -dit -p 7001:7001 --name "$name" ${image_repo}:$tag /bin/sh -c "tail -f /dev/null"
    docker volume create "$deps_volume_name"
    docker run -itd \
      -p 7001:7001 \
      -p 8080:8080 \
      -p 9229:9229 \
      --volume ${project_path_in_phsyics}:${project_path_in_vm} \
      --volume $deps_volume_name:$deps_volume_path \
      --name "$name" ${image_repo}:$tag /bin/sh -c "tail -f /dev/null"
  fi
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
