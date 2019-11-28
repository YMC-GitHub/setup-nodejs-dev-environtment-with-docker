#!/usr/bin/sh

#!/bin/sh
THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/index.func.sh

#运行镜像
run_image "$nodejs_app_name" "$nodejs_app_tag"
