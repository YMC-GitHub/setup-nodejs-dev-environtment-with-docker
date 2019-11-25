#!/usr/bin/sh

THIS_FILE_PATH=$(cd `dirname $0`; pwd)

######
# for common
######
# 工程名字
project_name=project

######
# for deps_image_and_container
######
# 容器名字
deps_volume_name=node_modules
deps_image_name=
deps_container_name=node_modules
# 挂数据卷
deps_volume_path=/project/node_modules
# 操作系统
os_image_name=alpine

######
# for codes_image_and_container
######
# 工程目录
# it can be absolute path,if it is relative,relative to RUN_SRCIPT_PATH
project_path_in_phsyics="/mnt/code-store/Shell/setup-nodejs-develop-environtment-with-docker"
#project_path_in_phsyics="./setup-nodejs-develop-environtment-with-docker"
#project_path_in_phsyics="./blog"
project_path_in_vm="/project" #/project
# 数据卷名
deps_container_name=node_modules
# 编程语言
program_languague_name=node
program_languague_version=8.16.0
# 操作系统
os_name=alpine
os_version=3.9
# 容器镜像
codes_container_image_name=${program_languague_name}:${program_languague_version}-${os_name}
# 容器名字
codes_container_name=project
#codes_container_name="project"

######
# for copy_from_host_to_vm.sh
######
# it can be absolute path,if it is relative,relative to RUN_SRCIPT_PATH
nodejs_project_path_in_phsyics="nodejs_app"
#2 nodejs工程包的描述
# it can be absolute path,if it is relative,relative to nodejs_project_path_in_phsyics
package_path="package.json"
#2 nodejs开发源码文件
# it can be absolute path,if it is relative,relative to nodejs_project_path_in_phsyics
source_dev_path_in_phsyics="src"
source_dev_path_in_vm="${project_path_in_vm}"
#2 nodejs测试源码文件
# it can be absolute path,if it is relative,relative to nodejs_project_path_in_phsyics
source_test_path_in_phsyics="test"
source_test_path_in_vm="${project_path_in_vm}"
#2 nodejs部署源码文件
# it can be absolute path,if it is relative,relative to nodejs_project_path_in_phsyics
source_dist_path_in_phsyics="dist"
source_dist_path_in_vm="${project_path_in_vm}"

source ${THIS_FILE_PATH}/passed-cli-arg.sh

source ${THIS_FILE_PATH}/caculate-config.sh