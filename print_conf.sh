#!/usr/bin/sh

#source ./conf.sh
THIS_FILE_PATH=$(cd `dirname $0`; pwd)
source ${THIS_FILE_PATH}/conf.sh

config=$(cat <<EOF
output config value:

#project_path_in_phsyics
$project_path_in_phsyics

#nodejs_project_path_in_phsyics
$nodejs_project_path_in_phsyics
#package_path
$package_path
#source_dev_path_in_phsyics
$source_dev_path_in_phsyics
#source_dev_path_in_vm
$source_dev_path_in_vm
#source_test_path_in_phsyics
$source_test_path_in_phsyics
#source_test_path_in_vm
$source_test_path_in_vm
#source_dist_path_in_phsyics
$source_dist_path_in_phsyics
#source_dist_path_in_vm
$source_dist_path_in_vm
EOF
)
echo "$config"
