#!/usr/bin/sh

#source ./conf.sh
THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/conf.sh

#nowhash=$(date "+%Y-%m-%d %H:%M:%S" | md5sum |cut -d ' ' -f1|cut -b 1-8)
#codes_container_name="${codes_container_name}-dev-${nowhash}"
# 安装一个类库
#docker exec -it -w $project_path_in_vm $codes_container_name npm install --save-dev nodemon
#docker exec -it -w $project_path_in_vm $codes_container_name npm install koa
#docker exec -it -w $project_path_in_vm $codes_container_name npm install koa-static
#docker exec -it -w /project project npm install
#docker exec -it -w $project_path_in_vm $codes_container_name npm install

# 列出项目文件
echo "list file in CM ..."
docker exec -it --workdir $project_path_in_vm $codes_container_name ls
# 列出模块文件
echo "list file in CM node_modules ..."
docker exec -it --workdir $project_path_in_vm $codes_container_name ls node_modules

# 执行某一命令
#2 生成部署源码文件(静态)
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run static-code:build
#2 运行部署源码文件(静态)
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run static-code:serve
#2 运行开发源码文件(动态)
#docker exec -it --workdir $project_path_in_vm $codes_container_name npm run dynamic:dev
#2 运行测试源码文件(动态)
#docker exec -it --workdir $project_path_in_vm $codes_container_name npm run dynamic:test
#2 运行部署源码文件(动态)
#docker exec -it --workdir $project_path_in_vm $codes_container_name npm run dynamic:pro
