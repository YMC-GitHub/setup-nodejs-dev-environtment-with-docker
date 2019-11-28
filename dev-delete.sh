#!/usr/bin/sh

#source ./conf.sh
THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/conf.sh

# 删除容器
docker container rm --force $codes_container_name
# 删数据卷
#docker volume rm --force $deps_volume_name
