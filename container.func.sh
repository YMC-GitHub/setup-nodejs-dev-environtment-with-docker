#!/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/conf.sh

###
# 查看容器
###
# 列出容器列表
function list_container_by_name() {
  local list=
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi
  #list=$(docker inspect -f='{{.ID}}={{.Name}}' $(docker ps -aq) | grep "$name")
  list=$(docker inspect -f='{{.ID}}={{.Name}}' $(docker ps -aq) | grep "$name")
  echo "list CM $name"
  echo "$list"
}
# 查看容器详情
function inspect_container_by_name() {
  local list=
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi
  echo "inspect CM $name"
  docker inspect "$name"
}
# 查看容器日志
function log_container_by_name() {
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi
  echo "see CM $name log"
  docker logs "$name"
}

###
# 启动容器
###
function start_container_by_name() {
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi
  echo "start CM $name"
  docker start "$name"
}

###
# 进入容器
###
function goto_container_by_name() {
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi
  echo "goto CM $name"
  echo "docker exec -it --workdir ${project_path_in_vm} ${name} /bin/sh"
  docker exec -it --workdir $project_path_in_vm $name /bin/sh
}

###
# 关闭容器
###
function stop_container_by_name() {
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi
  echo "stop CM $name"
  docker stop "$name"
}

###
# 删除容器
###
function delete_container_by_name() {
  local list=
  local REG_SHELL_COMMOMENT_PATTERN=
  local list_ARR=
  local var=
  local key=
  local name=
  name="$nodejs_app_name"
  if [ -n "${1}" ]; then
    name="${1}"
  fi

  list=$(docker inspect -f='{{.ID}}={{.Name}}' $(docker ps -aq) | grep "$name")
  REG_SHELL_COMMOMENT_PATTERN="^#"
  list_ARR=(${list//,/ })
  for var in ${list_ARR[@]}; do
    if [[ "$var" =~ $REG_SHELL_COMMOMENT_PATTERN ]]; then
      echo "$var" >/dev/null 2>&1
    else
      key=$(echo "$var" | cut -d "=" -f1 | tr "[:upper:]" "[:lower:]")
      echo "rm pro container $key"
      docker container rm "$key"
    fi
  done
}
