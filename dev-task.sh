#!/usr/bin/sh

#source ./conf.sh
THIS_FILE_PATH=$(cd `dirname $0`; pwd)
source ${THIS_FILE_PATH}/conf.sh

# 安装一个类库
docker exec -it -w $project_path_in_vm $codes_container_name npm install lodash
#docker exec -it -w /project project npm install
#docker exec -it -w $project_path_in_vm $codes_container_name npm install

# 列出模块文件
#docker exec -it project ls /project
#docker exec -it -w /project project ls
echo "list file in CM ..."
docker exec -it --workdir $project_path_in_vm $codes_container_name ls
echo "list file in CM node_modules ..."
docker exec -it --workdir $project_path_in_vm $codes_container_name ls node_modules
# 生成部署源码build
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run build
echo "list file in PM or CM ..."

# 执行某一命令
#2 运行开发源码文件
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run start
#2 运行测试源码文件
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run test
#2 运行部署源码文件
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run dist