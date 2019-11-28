#!/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/conf.sh
source ${THIS_FILE_PATH}/container.func.sh
source ${THIS_FILE_PATH}/image.func.sh

# image.func.sh container.func.sh
pm_nodejs_app_path="${nodejs_project_path_in_phsyics}"
nodejs_app_path="$project_path_in_vm" #"/nodejs/app/name"
nodejs_app_name=$(echo "$nodejs_app_path" | sed "s#/#_#g" | sed "s#-#_#g" | sed "s#^_##g" | tr "[:upper:]" "[:lower:]")
#nodejs_app_xx
nodejs_app_tag="1.0.0"
nodejs_app_namespace="yemiancheng"
nodejs_app_version="1.0.0"
image_repo=$(get_image_repo "pub")
