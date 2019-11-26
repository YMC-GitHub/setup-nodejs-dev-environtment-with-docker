#!/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/pro-image.func.sh

#构建所有阶段
build_image_all_stage
#构建某一阶段
#build_image_by_stage
