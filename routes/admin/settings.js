const express = require('express');
const pool = require('../../pool');
var router = express.Router()

/**
 * GET  admin/settings
 * 获取所有全局设置信息
 * 返回数据：
 * {appName:xxx,adminUrl:xxx...}
 */
router.get('/',(req,res)=>{
  pool.query("SELECT * from xfn_settings LIMIT 1",(err,result)=>{
    if(err) throw err ;
    res.send(result[0]);
  })
})

/**
 * PUT  admin/settings
 * 修改所有全局设置信息
 * 请求数据：{appName:xxx,adminUrl:xxx...  }
 * 返回数据：
 * {code:200,msg:'settings update success'}
 */
router.put('/',(req,res)=>{
  pool.query('UPDATE xfn_settings SET ?',req.body,(err,result)=>{
    if(err) throw err;
    res.send({code:200,msg:'settings update success'})
  })
})


module.exports = router;