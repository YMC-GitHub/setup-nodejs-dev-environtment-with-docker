#!/usr/bin/sh

#source ../conf.sh
basepath=$(cd `dirname $0`; pwd)
source ${basepath}/conf.sh

#2 nodejs工程包的描述
docker cp ${package_path} ${codes_container_name}:${project_path_in_vm}
#2 nodejs开发源码文件
docker cp ${source_dev_path_in_phsyics} ${codes_container_name}:${project_path_in_vm}
#2 nodejs测试源码文件
docker cp ${source_test_path_in_phsyics} ${codes_container_name}:${project_path_in_vm}
#2 nodejs部署源码文件
docker cp ${source_dist_path_in_phsyics} ${codes_container_name}:${project_path_in_vm}