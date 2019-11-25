#!/usr/bin/sh

THIS_FILE_PATH=$(cd `dirname $0`; pwd)
source ${THIS_FILE_PATH}/init/build_and_run_deps_image.sh
source ${THIS_FILE_PATH}/init/build_and_run_code_image.sh
source ${THIS_FILE_PATH}/init/copy_from_host_to_vm.sh

