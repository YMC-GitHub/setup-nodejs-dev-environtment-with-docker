#!/usr/bin/sh

#source ./conf.sh
basepath=$(cd `dirname $0`; pwd)
echo $basepath
source ${basepath}/conf.sh


echo $project_path_in_phsyics
echo $nodejs_project_path_in_phsyics
echo $package_path
#2 nodejs开发源码文件
echo $source_dev_path_in_phsyics
echo $source_dev_path_in_vm
#2 nodejs测试源码文件
echo $source_test_path_in_phsyics
echo $source_test_path_in_vm
#2 nodejs部署源码文件
echo $source_dist_path_in_phsyics
echo $source_dist_path_in_vm