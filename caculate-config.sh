#!/usr/bin/sh

THIS_FILE_PATH=$(cd `dirname $0`; pwd)
source ${THIS_FILE_PATH}/path_resolve.sh

THIS_PROJECT_PATH="$THIS_FILE_PATH"
RUN_SCRIPT_PATH=$(pwd)

#feats:adding supporting relative path
#relative to RUN_SCRIPT_PATH
project_path_in_phsyics=$(path_resolve "$RUN_SCRIPT_PATH" "$project_path_in_phsyics")

#feats:adding supporting relative path
#relative to project_path_in_phsyics
nodejs_project_path_in_phsyics=$(path_resolve "$project_path_in_phsyics" "$nodejs_project_path_in_phsyics")

#feats:adding supporting relative path
#relative to nodejs_project_path_in_phsyics
package_path=$(path_resolve "$nodejs_project_path_in_phsyics" "$package_path")

#feats:adding supporting relative path
#relative to nodejs_project_path_in_phsyics
source_dev_path_in_phsyics=$(path_resolve "$nodejs_project_path_in_phsyics" "$source_dev_path_in_phsyics")

#feats:adding supporting relative path
#relative to nodejs_project_path_in_phsyics
source_test_path_in_phsyics=$(path_resolve "$nodejs_project_path_in_phsyics" "$source_test_path_in_phsyics")

#feats:adding supporting relative path
#relative to nodejs_project_path_in_phsyics
source_dist_path_in_phsyics=$(path_resolve "$nodejs_project_path_in_phsyics" "$source_dist_path_in_phsyics")

codes_container_image_name=${program_languague_name}:${program_languague_version}-${os_name}
source_dev_path_in_vm="${project_path_in_vm}"
source_test_path_in_vm="${project_path_in_vm}"
source_dist_path_in_vm="${project_path_in_vm}"
