#!/usr/bin/sh

basepath=$(cd `dirname $0`; pwd)
# 读取配置
source ${basepath}/conf.sh
# 打印配置
source ${basepath}/print_conf.sh

# 搭建
# 启动
source ${basepath}/start.sh
# 查看
source ${basepath}/info.sh
# 执行任务
source ${basepath}/task.sh
# 停止
# 退出
# 删除
source ${basepath}/delete.sh
