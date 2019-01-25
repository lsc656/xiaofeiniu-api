/**
 * 小肥牛扫码点餐项目API子系统
 */
const PORT = 8090;
const EXPRESS = require('express');
var app = EXPRESS();
app.listen(PORT,()=>{
  console.log('服务器正在监听'+PORT+'...')
});

