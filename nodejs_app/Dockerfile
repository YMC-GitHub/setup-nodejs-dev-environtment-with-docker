###
# dockerfile on app/nodejs/xx for pro env
###
# with mutli build image stage

# ---- Base Node ----
# 基础镜像nodejs
FROM node:10.16.3-alpine AS base
# 维护人员
LABEL maintainer "hualei03042013@163.com"
# 定义变量
ENV PROJECT_DIR=/nodejs/app/nodejs_app
# 工作目录
WORKDIR $PROJECT_DIR

# ---- Dependencies ----
# 依赖镜像nodejs
FROM base AS dependencies
# 拷贝文件
COPY ./package*.json ./
# 安装依赖
RUN npm install

# ---- Copy Files/Build ----
# 静态镜像nodejs
#用 .dockerignore 来屏蔽掉不必要的文件
#对 react/vue/angular 打包，生成静态文件

FROM dependencies AS build
# 拷贝项目
COPY ./ ./
COPY ./.dockerignore ./
# 生成文件
RUN npm run build

# --- pro with Alpine ----
# 产品镜像nodejs
FROM node:10.16.3-alpine AS pro
# 定义变量
ENV PROJECT_DIR=/nodejs/app/nodejs_app
# 工作目录
WORKDIR $PROJECT_DIR
# 安装依赖
# 可选命令-使用serve包部署静态文件
# RUN npm -g install serve
# 拷贝文件
COPY --from=dependencies /nodejs/app/nodejs_app/package.json ./
RUN npm install --only=production
COPY --from=build /nodejs/app/nodejs_app ./

# 环境变量
ENV VM_MOUNT_PATH=/nodejs/app/nodejs_app \ 
    APP_PORT=7001

# 挂数据卷
VOLUME ["$VM_MOUNT_PATH"]

# 暴露端口
EXPOSE $APP_PORT
# 监控检查
#HEALTHCHECK CMD curl --fail http://localhost:$APP_PORT || exit 1

# 设置时区
#RUN rm /etc/localtime && echo "Asia/Shanghai" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata #  && npm config set color false
RUN apk add -U tzdata && echo "Asia/Shanghai" > /etc/localtime && apk del tzdata

# 启动服务
# 不要使用 npm，也不用 shell form，避免 node 进程无法收到 SIGTERM 信号。
#2 部署静态文件
#CMD ["serve", "-s", "dist", "-p", "$APP_PORT"]
#2 部署动态文件
CMD ["node", "./dist/server.js"]
