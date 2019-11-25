#!/usr/bin/sh

#source ./conf.sh
THIS_FILE_PATH=$(cd `dirname $0`; pwd)
source ${THIS_FILE_PATH}/conf.sh

# 查看镜像
#2 列出
docker image ls

# 查看容器
#2 列出
docker container ls --all

# 查数据卷
#2 列出
docker volume ls
