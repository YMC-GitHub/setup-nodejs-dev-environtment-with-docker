#!/usr/bin/sh

#source ./conf.sh
basepath=$(cd `dirname $0`; pwd)
source ${basepath}/conf.sh

# 删除测试容器及数据卷
docker container rm --force --volumes $codes_container_name
docker container rm --force --volumes $deps_container_name