/**
 * 桌台相关路由器
 */

const express = require('express');
const pool = require('../../pool');
var router = express.Router();

/**
 * GET  admin/table
 * 获取所有桌台设置信息
 * 返回数据：
 * {tid:xxx,tname:xxx,...}
 */
router.get('/',(req,res)=>{
  pool.query("SELECT * from xfn_table ORDER BY tid",(err,result)=>{
    if(err) throw err ;
    res.send(result);
  })
})

// /**
//  * PATCH  admin/table
//  * 修改所有桌台设置信息
//  * 请求数据：{status,tid }
//  * 返回数据：
//  * {code:200,msg:'settings update success'}
//  */
// router.patch('/',(req,res)=>{
//   pool.query('UPDATE xfn_table SET status=? WHERE tid=?',[req.body.status,req.body.tid],(err,result)=>{
//     if(err) throw err;
//     res.send({code:200,msg:'settings update success'})
//   })
// })

module.exports = router;