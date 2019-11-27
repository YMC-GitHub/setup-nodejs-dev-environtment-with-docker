#!/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
# 搭建
# 启动
source ${THIS_FILE_PATH}/pro-start.sh
# 执行任务
source ${THIS_FILE_PATH}/pro-task.sh
# 停止
# 退出
# 删除
source ${THIS_FILE_PATH}/pro-delete.sh
