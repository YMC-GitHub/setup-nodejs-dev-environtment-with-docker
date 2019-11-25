#!/usr/bin/sh

######
# for common
######
# 工程名字
project_name=project

######
# for deps_image_and_container
######
# 容器名字
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
# fix some errors ,using "\\" replace "\" on win host
project_path_in_phsyics="g:\\code-store\\nodejs\\building-docker-nodejs-develop-environtment"
# fix some errors ,using "//" replace "/"
project_path_in_vm="//project" #/project
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
nodejs_project_path_in_phsyics="${project_path_in_phsyics}\nodejs_app"
#2 nodejs工程包的描述
package_path="${nodejs_project_path_in_phsyics}\package.json"
#2 nodejs开发源码文件
source_dev_path_in_phsyics="${nodejs_project_path_in_phsyics}\src"
source_dev_path_in_vm="${project_path_in_vm}"
#2 nodejs测试源码文件
source_test_path_in_phsyics="${nodejs_project_path_in_phsyics}\test"
source_test_path_in_vm="${project_path_in_vm}"
#2 nodejs部署源码文件
source_dist_path_in_phsyics="${nodejs_project_path_in_phsyics}\dist"
source_dist_path_in_vm="${project_path_in_vm}"
