#!/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source $THIS_FILE_PATH/read-config-file.sh

KEY_VAL_LIST=$(
  cat <<EOF
# 工程名字
project_name
######
# for deps_image_and_container
######
# 容器名字
deps_volume_name
deps_image_name
deps_container_names
# 挂数据卷
deps_volume_path
# 操作系统
os_image_name

######
# for codes_image_and_container
######
# 工程目录
project_path_in_phsyics
project_path_in_vm
# 数据卷名
deps_container_name
# 编程语言
program_languague_name
program_languague_version
# 操作系统
os_name
os_version
# 容器镜像
# 容器名字
codes_container_name

######
# for copy_from_host_to_vm.sh
######
nodejs_project_path_in_phsyics
package_path
source_dev_path_in_phsyics
source_test_path_in_phsyics
source_dist_path_in_phsyics
EOF
)
KEY_VAL_TXT=
REG_SHELL_COMMOMENT_PATTERN="^#"
KEY_VAL_LIST_ARR=(${KEY_VAL_LIST//,/ })
for var in ${KEY_VAL_LIST_ARR[@]}; do
  if [[ "$var" =~ $REG_SHELL_COMMOMENT_PATTERN ]]; then
    echo "$var" >/dev/null 2>&1
  else
    key=$(echo "$var" | tr "[:upper:]" "[:lower:]" )
    val="${dic[$key]}"
    if [ -n "$val" ]
    then
      #echo "$val"
      KEY_VAL_TXT=$(
  cat <<EOF
$KEY_VAL_TXT
# $key
$val
EOF
)
    fi
  fi
done

KEY_VAL_TXT=$(
  cat <<EOF
output the config file key value
$KEY_VAL_TXT
EOF
)
echo "$KEY_VAL_TXT"