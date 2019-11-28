FROM node:10.16.3-alpine AS base
LABEL maintainer "hualei03042013@163.com"
ENV PROJECT_DIR=/nodejs/app/nodejs_app
WORKDIR $PROJECT_DIR
FROM base AS deps
COPY ./package*.json ./
RUN npm install
FROM deps AS build
COPY ./ ./
COPY ./.dockerignore ./
RUN npm run build
FROM base AS  pro
COPY --from=deps /nodejs/app/nodejs_app/package.json ./
RUN npm install --only=production
COPY --from=build /nodejs/app/nodejs_app/dist dist
COPY ./ ./
ENV VM_MOUNT_PATH=/nodejs/app/nodejs_app \ 
    APP_PORT=7001
VOLUME ["$VM_MOUNT_PATH"]
EXPOSE $APP_PORT   3000   9229   8080
CMD ["node", "./src/server.js"]
