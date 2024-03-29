#!/usr/bin/sh

#source ../conf.sh
THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source ${THIS_FILE_PATH}/conf.sh

#docker run -itd --volume ${project_path_in_phsyics}:${project_path_in_vm} --volumes-from ${deps_container_name} --name ${codes_container_name} ${codes_container_image_name}
#uses deps volume replacing with deps container
docker run -itd -p 7001:7001 --volume ${project_path_in_phsyics}:${project_path_in_vm} --volume $deps_volume_name:$deps_volume_path --name ${codes_container_name} ${codes_container_image_name}
