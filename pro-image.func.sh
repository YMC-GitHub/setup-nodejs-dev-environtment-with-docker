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
  docker build --tag "${image_repo}:${nodejs_app_tag}" "$pm_nodejs_app_path"
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

###
# 进入容器
###
function goto_pro_container_for_test() {
  docker run --rm -it "${image_repo}:stage-pro" /bin/sh <<EOF
ls
exit
EOF
}

###
# 删除镜像
###
# 删除虚悬镜像
# docker rmi $(docker images -q -f dangling=true)
function local_none_image() {
  docker rmi $(docker images -q -f dangling=true)
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
