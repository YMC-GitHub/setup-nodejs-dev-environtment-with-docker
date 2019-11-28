THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/index.func.sh

# 列出项目文件
echo "list file in CM ..."
docker exec -it --workdir $project_path_in_vm $codes_container_name ls

# 安装一个类库
#docker exec -it -w $project_path_in_vm $codes_container_name npm install --save-dev nodemon
#docker exec -it -w $project_path_in_vm $codes_container_name npm install koa
#docker exec -it -w $project_path_in_vm $codes_container_name npm install koa-static
#docker exec -it -w /project project npm install
#docker exec -it -w $project_path_in_vm $codes_container_name npm install

# 列出模块文件
echo "list file in CM node_modules ..."
docker exec -it --workdir $project_path_in_vm $codes_container_name ls node_modules

# 执行某一命令
###
# for 静态代码
###
#2 生成部署文件(静态)
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run static-code:build
#2 运行部署文件(静态)
#docker exec -it --workdir $project_path_in_vm $codes_container_name npm run static-code:serve

###
# for 动态代码
###
#2 运行开发文件(动态)
#docker exec -it --workdir $project_path_in_vm $codes_container_name npm run dynamic:dev
#2 运行测试文件(动态)
#docker exec -it --workdir $project_path_in_vm $codes_container_name npm run dynamic:test
#2 运行部署文件(动态)
#docker exec -it --workdir $project_path_in_vm $codes_container_name npm run dynamic:pro

echo "see CM status ..."
docker ps | grep "$codes_container_name"
