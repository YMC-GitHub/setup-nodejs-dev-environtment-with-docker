#!/usr/bin/sh

#source ../conf.sh
basepath=$(cd `dirname $0`; pwd)
source ${basepath}/conf.sh

docker run --detach --volume ${deps_volume_path} --name ${deps_container_name} ${os_image_name}