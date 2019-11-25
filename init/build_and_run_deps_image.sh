#!/usr/bin/sh

#source ../conf.sh
basepath=$(cd `dirname $0`; pwd)
source ${basepath}/conf.sh
# 创建一个容器用来缓存依赖目录node_modules
# 并暴露 deps_volume_path 作为挂载路径
# 其他容器通过--volumes-from实现与其通信

docker run --detach --volume ${deps_volume_path} --name ${deps_container_name} ${os_image_name}
