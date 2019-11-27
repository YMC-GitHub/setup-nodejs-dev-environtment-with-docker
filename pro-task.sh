THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/pro-image.func.sh

# 列出模块文件
echo "list file in CM node_modules ..."
docker exec -it --workdir $project_path_in_vm $codes_container_name ls node_modules

#列出项目文件
echo "list file in CM ..."
docker exec -it --workdir $project_path_in_vm $codes_container_name ls

# 执行某一命令
#2 生成部署源码文件
echo "gennerate build cmd ..."
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run build
#2 拷贝部署源码文件
#src="${project_path_in_vm}/dist"
#des="${project_path_in_pm}"
#echo "copy file from CM:${src} to PM:${des}  ..."
#docker cp "$src" "$des"

#2 运行开发源码文件
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run start
#2 运行测试源码文件
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run test
#2 运行部署源码文件
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run dist
