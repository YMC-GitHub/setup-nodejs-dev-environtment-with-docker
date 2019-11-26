var fs = require("fs");
var path = require("path");
console.log("generate dist code ...")


var createFolder = function (to) { //文件写入
  var sep = path.sep
  var folders = path.dirname(to).split(sep);
  var p = '';
  while (folders.length) {
    p += folders.shift() + sep;
    if (!fs.existsSync(p)) {
      fs.mkdirSync(p);
    }
  }
}
var scope = "dist"
var dist = `
const name = "in ${scope} source"
console.log(\`I am \${ name }\`);
`;

createFolder('dist/server.js');
var writeStream = fs.createWriteStream('dist/server.js');
writeStream.write(dist);
writeStream.end();

