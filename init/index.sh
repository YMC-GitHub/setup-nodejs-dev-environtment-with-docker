#!/usr/bin/sh

#source ./build_and_run_deps_image.sh
#source ./build_and_run_code_image.sh
#source ./copy_from_host_to_vm.sh

#basepath=$(cd `dirname $0`; pwd)
#echo ${basepath}
source ${basepath}/init/build_and_run_deps_image.sh
source ${basepath}/init/build_and_run_code_image.sh
source ${basepath}/init/copy_from_host_to_vm.sh

