#!/usr/bin/sh

#source ./conf.sh
THIS_FILE_PATH=$(cd `dirname $0`; pwd)
source ${THIS_FILE_PATH}/conf.sh

# 删除容器+删数据卷
docker container rm --force --volumes $codes_container_name
#docker container rm --force --volumes $deps_container_name
docker volume rm --force $deps_volume_name
