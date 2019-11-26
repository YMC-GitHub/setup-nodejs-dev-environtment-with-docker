#!/usr/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
# 读取配置
source ${THIS_FILE_PATH}/conf.sh
# 打印配置
source ${THIS_FILE_PATH}/print_conf.sh

# 搭建
# 启动
source ${THIS_FILE_PATH}/dev-start.sh
# 查看
source ${THIS_FILE_PATH}/info.sh
# 执行任务
source ${THIS_FILE_PATH}/dev-task.sh
# 停止
# 退出
# 删除
source ${THIS_FILE_PATH}/dev-delete.sh
