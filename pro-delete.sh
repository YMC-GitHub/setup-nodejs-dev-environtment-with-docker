THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/pro-image.func.sh

#关闭容器
stop_pro_container_by_name "$nodejs_app_name"
#删除容器
delete_pro_container_by_name "$nodejs_app_name"
#删除镜像
local_none_image
local_delete_image_by_tag "$nodejs_app_tag"
