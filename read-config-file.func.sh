#!/bin/sh
declare -A dic
dic=()
THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
function read_config_file() {
  local CONFIG_FILE=
  local test=
  local arr=
  local key=
  local value=
  local i=

  CONFIG_FILE=${THIS_FILE_PATH}/from-a-config.txt
  if [ -n "${1}" ]; then
    CONFIG_FILE=$1
  fi
  test=$(sed 's/^ *//g' $CONFIG_FILE |grep --invert-match "^#")
  #字符转为数组
  arr=($test)
  for i in "${arr[@]}"; do
    # 获取键名
    key=$(echo $i | awk -F'=' '{print $1}')
    # 获取键值
    value=$(echo $i | awk -F'=' '{print $2}')
    value=$(echo "$value" | sed "s/^\"//g" |sed "s/\"$//g")
    # 输出该行
    #printf "%s\t\n" "$i"
    dic+=([$key]=$value)
  done
  echo "read config file:$CONFIG_FILE"
}