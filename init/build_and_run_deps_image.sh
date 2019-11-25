#!/usr/bin/sh

#source ../conf.sh
THIS_FILE_PATH=$(cd `dirname $0`; pwd)
source ${THIS_FILE_PATH}/conf.sh

# 创建一个数据卷来缓存依赖目录node_modules
# 并暴露 deps_volume_path 作为挂载路径
# 其他容器通过-v node_modules7:$deps_volume_path方式使用

#docker run --detach --volume ${deps_volume_path} --name ${deps_container_name} ${os_image_name}
#uses deps volume replacing with deps container
docker volume create "$deps_volume_name"