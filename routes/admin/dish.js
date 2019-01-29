/*
*菜品相关路由 
*/
const express = require('express');
const pool = require('../../pool');
var router = express.Router();


/*
*API：  GET  /admin/dish  
*获取所有的菜品（按类别进行分类）
*返回数据：
* [
  *   {cid: 1, cname:'肉类', dishList:[{},{},...]}
  *   {cid: 2, cname:'菜类', dishList:[{},{},...]}
  *   ....
  * ]
  */
router.get('/',(req,res)=>{
  pool.query('SELECT cid,cname FROM xfn_category ORDER BY cid',(err,result)=>{
    if(err) throw err;
    var categoryList = result;
    var finishCount = 0;
    for(let c of categoryList){
      pool.query('SELECT did,title,imgUrl,price,detail FROM xfn_dish WHERE categoryId=? ORDER BY did DESC',c.cid,(err,result)=>{
        if(err) throw err;
        c.dishList = result;
        finishCount++
        if(finishCount == categoryList.length){
          res.send(categoryList)
        }
      })
    }
  })
})

/**
 * 非幂等 post /admin/dish
 * 请求参数：
 * 接收客户端上传的菜品图片，保存在服务器上，返回该图片在服务器上的随机文件名
 */
const multer = require('multer');
const fs = require('fs');
//指定上传文件的临时存储路径
var upload = multer({dest:'tmp/'});
router.post('/image',upload.single('dishImg'),(req,res)=>{
  //客户端上传的文件
  //console.log(req.file);
  //客户端随同图片提交的字符数据
  //console.log(req.body);
  //把客户端上传的临时文件转移到永久的图片路径下
  var tmpFile = req.file.path;
  var suffix = req.file.originalname.substring(req.file.originalname.lastIndexOf('.'));
  var newFile = randFileName(suffix);
  //临时文件转移
  fs.rename(tmpFile,'img/dish/' + newFile,()=>{
    res.send({code:200,msg:'upload success',fileName:newFile})
  })
})

/**
 * 生成新文件名
 * @param {*} suffix 要生成的文件名后缀
 */
function randFileName(suffix){
  //当前系统时间戳
  var time = new Date().getTime();
  //4位随机数字
  var num = Math.floor(Math.random()*(10000-1000)+1000);
  return time + '-' + num + suffix;
}

 /**
  * post /admin/dish
  * 参数：{title:XX,imgUrl:XX,price:XX,detail:XX,categoryId:XX}
  * 添加一个新的菜品
  * 输出消息：
  * {code:200,msg:'dish added succ',dishId:46}
  */
router.post('/dish',(req,res)=>{
  var title = req.body.title;
  var imgUrl = req.body.imgUrl;
  var price = req.body.price;
  var detail = req.body.detail;
  var categoryId = req.body.categoryId;
  pool.query('INSERT INTO xfn_dish VALUES')
})

/**
 * DELETE /admin/dish/:did
 * 根据指定的菜品编号删除该菜品
 * 输出数据：
 * {code:200,msg:'dish deleted succ'}
 * {code:400,msg:'dish not exists'}
 */



 /**
  * PUT /admin/dish
  * 请求参数：{did:XX,title:xx,imgUrl:xx,price:xx,detail:xx,categoryId:xx}
  * 根据指定的菜品编号修改菜品
  * 输出数据：
 * {code:200,msg:'dish updated succ'}
 * {code:400,msg:'dish not exists'}
  */

 module.exports = router;