
const Koa = require('koa');
const app = new Koa();
const path = require('path');
const serve = require('koa-static');

const publicFiles = serve(path.join(__dirname, 'dist'));
publicFiles._name = 'static /dist';

app.use(publicFiles);

const name = "in src source"
// response
app.use(ctx => {
  ctx.body = `I am ${name}`;
});

app.listen(7001);