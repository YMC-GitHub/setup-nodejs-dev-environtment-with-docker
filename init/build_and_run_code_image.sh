#!/usr/bin/sh

#source ../conf.sh
basepath=$(cd `dirname $0`; pwd)
source ${basepath}/conf.sh
#echo $basepath

# 注意：win10-于命令行-bash-运行失败
# 注意：win10-于命令行-exe-运行成功
#docker run -itd -v g:\code-store\nodejs\building-docker-nodejs-develop-environtment:/project --volumes-from node_modules --name project node:8.16.0-alpine
# 注意：win10-于命令行-bash-运行失败
#docker run -itd --volume /g/code-store/nodejs/building-docker-nodejs-develop-environtment:/project --volumes-from node_modules --name project node:8.16.0-alpine
# 注意：win10-于命令行-bash-命令执行成功，但是 没有看到挂载文件
docker run -itd --volume ${project_path_in_phsyics}:${project_path_in_vm} --volumes-from ${deps_container_name} --name ${codes_container_name} ${codes_container_image_name}

