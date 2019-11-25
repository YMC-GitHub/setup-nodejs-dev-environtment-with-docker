#### 工程目录结构

虽然Node.js在前后端开发使用场景作用差别很大，前端通常要运行构建工具，如gulp、webpack等，后端则可以直接执行js代码启动服务器。不过目录结构大体相同，所以可以放在一起讨论。

下面是个简单的项目结构示例，代表了项目种的几类文件和目录。
```md
nodejs_app
# nodejs工程说明文件
|--readme.md 
# nodejs工程包的描述 for npm/yarn
|--package.json 
# nodejs开发源码目录
|--src
  |--server.js
# nodejs测试源码目录
|--test
  |--server.js
# nodejs生产源码目录
|--dist
  |--server.js
```
