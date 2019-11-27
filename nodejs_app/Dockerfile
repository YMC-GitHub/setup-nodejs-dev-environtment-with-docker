FROM node:10.16.3-alpine AS base
LABEL maintainer "hualei03042013@163.com"
ENV PROJECT_DIR=/nodejs/app/nodejs_app
WORKDIR $PROJECT_DIR
FROM base AS dependencies
COPY ./package*.json ./
RUN npm install
FROM dependencies AS build
COPY ./ ./
COPY ./.dockerignore ./
RUN npm run build
FROM node:10.16.3-alpine AS pro
ENV PROJECT_DIR=/nodejs/app/nodejs_app
WORKDIR $PROJECT_DIR
COPY --from=dependencies /nodejs/app/nodejs_app/package.json ./
RUN npm install --only=production
COPY --from=build /nodejs/app/nodejs_app ./
ENV VM_MOUNT_PATH=/nodejs/app/nodejs_app \ 
    APP_PORT=7001
VOLUME ["$VM_MOUNT_PATH"]
EXPOSE $APP_PORT
RUN apk add -U tzdata && echo "Asia/Shanghai" > /etc/localtime && apk del tzdata
CMD ["node", "./dist/server.js"]
