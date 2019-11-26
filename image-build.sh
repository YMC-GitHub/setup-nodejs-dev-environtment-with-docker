#!/bin/sh

THIS_FILE_PATH=$(cd `dirname $0`; pwd)
source ${THIS_FILE_PATH}/conf.sh

###
# 构建镜像
###
#nodejs_app_path="./nodejs_app"
nodejs_app_path="$nodejs_project_path_in_phsyics"
nodejs_app_name="test"
nodejs_app_tag=1.0.0
nodejs_app_namespace=yemiancheng
#nodejs_app_version=1.0.0
nodejs_app_name_prefix=$(echo "$nodejs_app_path"|sed "s#/#_#g")
nodejs_app_image_repo="$nodejs_app_namespace/${nodejs_app_name_prefix}_${nodejs_app_name}:${nodejs_app_tag}"
image_repo="$nodejs_app_namespace/${nodejs_app_name_prefix}_${nodejs_app_name}:"

#构建所有阶段
docker build --tag "$nodejs_app_image_repo" "$nodejs_app_path"

#docker build --tag "${image_repo}stage-all" "$nodejs_app_path"
#只构建某一阶段的镜像
#2 stage-base
#docker build --target base --tag "${image_repo}stage-base" "$nodejs_app_path"
#2 stage-deps
#docker build --target dependencies --tag "${image_repo}stage-deps" "$nodejs_app_path"
#2 stage-build
#docker build --target build --tag "${image_repo}stage-build" "$nodejs_app_path"
#2 stage-pro
#docker build --target pro --tag "${image_repo}stage-pro" "$nodejs_app_path"


###
# 查看镜像
###
# docker image ls | grep "$nodejs_app_namespace/${nodejs_app_name_prefix}_${nodejs_app_name}"

###
# 运行镜像(测试)
###
# docker run --rm -it -p 7001:7001 "${image_repo}stage-pro"

###
# 进入容器
###
# docker run --rm -it "${image_repo}stage-pro" /bin/sh
# exit

###
# 删除镜像
###
# 删除虚悬镜像
# docker rmi $(docker images -q -f dangling=true)
# 删除练习镜像
list=$(docker image ls --format " {{.ID}}={{.Repository}}" | grep "$nodejs_app_namespace/${nodejs_app_name_prefix}_test")
REG_SHELL_COMMOMENT_PATTERN="^#"
list_ARR=(${list//,/ })
for var in ${list_ARR[@]}; do
  if [[ "$var" =~ $REG_SHELL_COMMOMENT_PATTERN ]]; then
    echo "$var" >/dev/null 2>&1
  else
    key=$(echo "$var" | cut -d "=" -f1|tr "[:upper:]" "[:lower:]")
    echo "rm pratice image $key"
    docker image rm "$key"
  fi
done