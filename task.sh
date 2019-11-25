#!/usr/bin/sh

#source ./conf.sh
basepath=$(cd `dirname $0`; pwd)
source ${basepath}/conf.sh

# 安装一个类库
#docker exec -it -w /project project npm install
#docker exec -it -w $project_path_in_vm $codes_container_name npm install

# 列出模块文件
#docker exec -it project ls /project
#docker exec -it -w /project project ls
####
# 出现问题：docker exec -it -w "/project" project ls
# 需要注意：win10-于命令行-git-bash-运行失败
# 错误提示：OCI runtime exec failed: exec failed: Cwd must be an absolute path: unknown
# 错误修复：docker exec -it -w "//project" project ls
#docker exec -it -w "//project" project ls
####
####
# 出现问题：my_container_name=project
# 需要注意：win10-B-shell中-执行失败
# 错误提示："docker exec" requires at least 2 arguments.
# 错误修复：my_container_name="project"
####
:<<ymc-note-block
project_work_dir_in_vms="//project"
my_container_name="project"
docker exec -it --workdir $project_work_dir_in_vms $my_container_name ls
ymc-note-block
docker exec -it --workdir $project_path_in_vm $codes_container_name ls

# 执行某一命令
#2 运行开发源码文件
docker exec -it -w $project_path_in_vm $codes_container_name npm run start
#2 运行测试源码文件
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run test
#2 运行部署源码文件
docker exec -it --workdir $project_path_in_vm $codes_container_name npm run dist
