#!/bin/sh
THIS_FILE_PATH=$(cd `dirname $0`; pwd)
source $THIS_FILE_PATH/read-config-file.func.sh

conf=conf.txt
if [ -n "$arg_conf" ]
then
    conf="$arg_arg_conf"
fi

RUN_SCRIPT_PATH=$(pwd)
file=$RUN_SCRIPT_PATH/$conf
if [ -n "$arg_project_path_in_phsyics" ]
then
    file=$(path_resovle "$RUN_SCRIPT_PATH" "$arg_project_path_in_phsyics")
    file="$file/$conf"
fi

if [[ -n "$file" && -e "$file" && -f "$file" ]]
then
    read_config_file "$file"
fi


swap_cache="$temp"
temp="${dic[source_dist_path_in_vm]}"
if [ -n "$temp" ]
then
    source_dist_path_in_vm="$temp"
fi
temp="${dic[source_dist_path_in_phsyics]}"
if [ -n "$temp" ]
then
    source_dist_path_in_phsyics="$temp"
fi
temp="${dic[source_test_path_in_vm]}"
if [ -n "$temp" ]
then
    source_test_path_in_vm="$temp"
fi
temp="${dic[source_test_path_in_phsyics]}"
if [ -n "$temp" ]
then
    source_test_path_in_phsyics="$temp"
fi
temp="${dic[source_dev_path_in_vm]}"
if [ -n "$temp" ]
then
    source_dev_path_in_vm="$temp"
fi
temp="${dic[source_dev_path_in_phsyics]}"
if [ -n "$temp" ]
then
    source_dev_path_in_phsyics="$temp"
fi
temp="${dic[package_path]}"
if [ -n "$temp" ]
then
    package_path="$temp"
fi
temp="${dic[nodejs_project_path_in_phsyics]}"
if [ -n "$temp" ]
then
    nodejs_project_path_in_phsyics="$temp"
fi
temp="${dic[codes_container_name]}"
if [ -n "$temp" ]
then
    codes_container_name="$temp"
fi
temp="${dic[codes_container_image_name]}"
if [ -n "$temp" ]
then
    codes_container_image_name="$temp"
fi
temp="${dic[os_version]}"
if [ -n "$temp" ]
then
    os_version="$temp"
fi
temp="${dic[os_name]}"
if [ -n "$temp" ]
then
    os_name="$temp"
fi
temp="${dic[program_languague_version]}"
if [ -n "$temp" ]
then
    program_languague_version="$temp"
fi
temp="${dic[program_languague_name]}"
if [ -n "$temp" ]
then
    program_languague_name="$temp"
fi
temp="${dic[deps_container_name]}"
if [ -n "$temp" ]
then
    deps_container_name="$temp"
fi
temp="${dic[project_path_in_vm]}"
if [ -n "$temp" ]
then
    project_path_in_vm="$temp"
fi
temp="${dic[project_path_in_phsyics]}"
if [ -n "$temp" ]
then
    project_path_in_phsyics="$temp"
fi
temp="$swap_cache"
swap_cache=