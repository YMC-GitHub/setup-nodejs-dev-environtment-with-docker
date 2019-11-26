THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/pro-image.func.sh

#构建某一阶段
build_image_by_stage
#查看镜像
list_image_by_repo
#测试镜像
run_pro_image_for_test
#进入容器
#goto_pro_container_for_test
#删除镜像
# todo:fix:"docker rmi" requires at least 1 argument.
local_none_image
#local_delete_image_by_tag
#推送镜像
push_image "stage-pro"
