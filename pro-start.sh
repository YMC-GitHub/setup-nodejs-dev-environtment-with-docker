THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/pro-image.func.sh

#构建镜像
#build_image_by_stage
build_image_all_stage "$nodejs_app_tag"
#查看镜像
list_image_by_repo
#运行镜像
run_pro_image "$nodejs_app_name" "$nodejs_app_tag"
