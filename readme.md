### **利用Docker搭建高效的Node.js开发环境**

**step01-目录结构介绍**
```md
# 工程说明文件
|--readme.md 
# nodejs工程文件
|--nodejs_app

nodejs_app
# nodejs工程说明文件
|--readme.md 
# nodejs工程包的描述 for npm/yarn
|--package.json 
# nodejs开发源码文件
|--src
  |--server.js
# nodejs测试源码文件
|--test
  |--server.js
# nodejs部署源码文件
|--dist
  |--server.js
```
**step02-基础环境搭建**

依赖类库镜像
```sh
# 工程名字
project_name=
# 容器名字
deps_image_name=
deps_container_name=node_modules

# 数据卷的路径
deps_volume_path=/project/node_modules
# 操作系统
os_image_name=alpine

# 创建依赖类库镜像+容器+运行
#docker run --interactive --tty --volume /project/node_modules --name node_modules alpine
# docker run -it -v /project/node_modules --name node_modules alpine
docker run --detach -v /project/node_modules --name node_modules alpine
```

工程代码镜像
```sh
# 工程名字
project_name=project
# 工程目录
project_path_in_phsyics= g:\code-store\nodejs\building-docker-nodejs-develop-environtment
project_path_in_vm=/project
# 数据卷名
deps_container_name=node_modules
# 编程语言
program_languague_name=node
program_languague_version=8.16.0
# 操作系统
os_name=alpine
os_version=3.9
# 容器镜像
container_image_name=${program_languague_name}:${program_languague_version}-${os_name}
# 注意：win10-于命令行-bash-运行失败
# 注意：win10-于命令行-exe-运行成功
#docker run -itd -v g:\code-store\nodejs\building-docker-nodejs-develop-environtment:/project --volumes-from node_modules --name project node:8.16.0-alpine
# 注意：win10-于命令行-bash-运行失败
#docker run -itd --volume /g/code-store/nodejs/building-docker-nodejs-develop-environtment:/project --volumes-from node_modules --name project node:8.16.0-alpine
# 注意：win10-于命令行-bash-命令执行成功，但是 没有看到挂载文件
docker run -itd -v g:/code-store/nodejs/building-docker-nodejs-develop-environtment:/project --volumes-from node_modules --name project node:8.16.0-alpine


```

**step03-环境搭建测试**
```sh
# 列出所建容器
#2 运行中的
docker container ls
#2 所有容器
docker container ls --all

# 列所建数据卷
docker volume ls

# 列出当前目录
docker exec -it project pwd
docker exec -it  -w /project project pwd
docker exec -it  -w /project project ls
docker exec -it  -w /project project ls -R

# 创建一个文件
docker exec -it  -w /project touch hi.txt

# 拷文件到容器
#2 nodejs工程包的描述
docker cp g:\code-store\nodejs\building-docker-nodejs-develop-environtment\nodejs_app\package.json project:/project
#2 nodejs开发源码文件
docker cp g:\code-store\nodejs\building-docker-nodejs-develop-environtment\nodejs_app\src project:/project
#2 nodejs测试源码文件
docker cp g:\code-store\nodejs\building-docker-nodejs-develop-environtment\nodejs_app\test project:/project
#2 nodejs部署源码文件
docker cp g:\code-store\nodejs\building-docker-nodejs-develop-environtment\nodejs_app\dist project:/project

# 拷文件到电脑
# https://stackoverflow.com/questions/22907231/copying-files-from-host-to-docker-container
# 注意：win10-于命令行-exe-运行成功
docker cp project:/project g:/code-store/nodejs/building-docker-nodejs-develop-environtment
# 注意：win10-于命令行-exe-运行成功
#docker cp project:/project g:\code-store\nodejs\building-docker-nodejs-develop-environtment

# 安装一个类库
#docker exec -it project npm i lodash #注意目录
#docker exec -it project "cd /project && npm i lodash"
#docker exec -it -w /project project npm i lodash
docker exec -it -w /project project npm install

# 列出模块文件
#docker exec -it project ls node_modules #注意目录
#docker exec -it project ls /project/node_modules
docker exec -it -w /project project ls

# 执行某一命令
#2 运行开发源码文件
docker exec -it -w /project project npm run start
#2 运行测试源码文件
docker exec -it -w /project project npm run test
#2 运行部署源码文件
docker exec -it -w /project project npm run dist

# 删除测试容器
docker container rm --force --volumes project
docker container rm --force --volumes node_modules
```

参考文献

[\[1\].亚里士朱德.“利用Docker容器搭建高效的Node.js开发环境”[J].慕课吧,2017-08-10.](https://www.imooc.com/article/19840)
