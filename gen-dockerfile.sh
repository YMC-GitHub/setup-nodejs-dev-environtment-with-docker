#!/bin/sh

THIS_FILE_PATH=$(cd `dirname $0`; pwd)
source ${THIS_FILE_PATH}/conf.sh

#nodejs_app_path="./nodejs_app"
nodejs_app_path="$nodejs_project_path_in_phsyics"
PM_PROJECT_PATH="./"
VM_PROJECT_PATH="$project_path_in_vm" #"/app/nodejs/xx"
PM_APP_PORT=
VM_APP_PORT=7001
VM_MOUNT_PATH="$VM_PROJECT_PATH"
PM_MOUNT_PATH="$PM_PROJECT_PATH"
NODEJS_VERSION="$program_languague_version" #"10.16.3"
OS="$os_image_name" #alpine

cat > "$nodejs_app_path/.dockerignore" <<EOF
.git/
node_modules/
.vscode/
EOF

###
# 编写镜像
###
# 特性：
# 只需编写一个镜像配置文件
# 可以只构建某一阶段的镜像
# 构建时从其他镜像复制文件
# 阶段：
# 基础文件镜像--应用基础环境
# 依赖类库镜像--安装相关依赖
# 静态文件镜像--生成静态文件
# 生成环境镜像--最终运行环境


DOCKER_FILE_TXT=$(cat <<EOF
###
# dockerfile on app/nodejs/xx for pro env
###
# with mutli build image stage

# ---- Base Node ----
# 基础镜像nodejs
FROM node:${NODEJS_VERSION}-${OS} AS base
# 维护人员
LABEL maintainer "hualei03042013@163.com"
# 定义变量
ENV PROJECT_DIR=$VM_PROJECT_PATH
# 工作目录
WORKDIR \$PROJECT_DIR

# ---- Dependencies ----
# 依赖镜像nodejs
FROM base AS dependencies
# 拷贝文件
COPY ${PM_PROJECT_PATH}package*.json ./
# 安装依赖
RUN npm install

# ---- Copy Files/Build ----
# 静态镜像nodejs
#用 .dockerignore 来屏蔽掉不必要的文件
#对 react/vue/angular 打包，生成静态文件

FROM dependencies AS build
# 拷贝项目
COPY ${PM_PROJECT_PATH} ./
COPY ${PM_PROJECT_PATH}.dockerignore ./
# 生成文件
RUN npm run build

# --- pro with Alpine ----
# 产品镜像nodejs
FROM node:${NODEJS_VERSION}-${OS} AS pro
# 定义变量
ENV PROJECT_DIR=$VM_PROJECT_PATH
# 工作目录
WORKDIR \$PROJECT_DIR
# 安装依赖
# 可选命令-使用serve包部署静态文件
# RUN npm -g install serve
# 拷贝文件
COPY --from=dependencies $VM_PROJECT_PATH/package.json ./
RUN npm install --only=production
COPY --from=build $VM_PROJECT_PATH ./

# 环境变量
ENV VM_MOUNT_PATH=$VM_MOUNT_PATH \ 
    APP_PORT=$VM_APP_PORT

# 挂数据卷
VOLUME ["\$VM_MOUNT_PATH"]

# 暴露端口
EXPOSE \$APP_PORT
# 监控检查
#HEALTHCHECK CMD curl --fail http://localhost:\$APP_PORT || exit 1

# 设置时区
#RUN rm /etc/localtime && echo "Asia/Shanghai" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata \
#  && npm config set color false
RUN apk add -U tzdata && echo "Asia/Shanghai" > /etc/localtime && apk del tzdata

# 启动服务
# 不要使用 npm，也不用 shell form，避免 node 进程无法收到 SIGTERM 信号。
#2 部署静态文件
#CMD ["serve", "-s", "dist", "-p", "\$APP_PORT"]
#2 部署动态文件
CMD ["node", "./dist/server.js"]
EOF
)
#echo "$DOCKER_FILE_TXT"
echo "generate dockerfile :${nodejs_app_path}/Dockerfile"
echo "$DOCKER_FILE_TXT" > "${nodejs_app_path}/Dockerfile"


#### 参考文献
:<<reference
如何编写最佳的Dockerfile
https://juejin.im/post/5922e07cda2f60005d602dcd

一份为 Node.js 应用准备的 Dockerfile 指南
https://juejin.im/post/5a9626abf265da4e9d225f4f

NodeJS Docker 打包全面优化：优雅停机、多阶段、上下文目录
https://blog.csdn.net/weixin_34037515/article/details/91478989

Docker数据卷Volume实现文件共享、数据迁移备份（三）
https://www.cnblogs.com/it-peng/p/11388231.html
reference