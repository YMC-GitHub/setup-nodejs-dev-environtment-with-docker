#!/usr/bin/sh

#source ./conf.sh
basepath=$(cd `dirname $0`; pwd)
source ${basepath}/conf.sh

# 安装一个类库
#docker exec -it -w $project_path_in_vm npm install lodash
#docker exec -it -w /project project npm install
#docker exec -it -w $project_path_in_vm $codes_container_name npm install

# 列出模块文件
#docker exec -it project ls /project
#docker exec -it -w /project project ls
docker exec -it --workdir $project_path_in_vm $codes_container_name ls

# 执行某一命令
#2 运行开发源码文件
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run start
#2 运行测试源码文件
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run test
#2 运行部署源码文件
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run dist
