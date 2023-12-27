<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/comm/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>后台管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="后台管理系统">

    <link rel="shortcut icon" href="${ctx}/static/img/favicon.ico">
    <link rel="stylesheet" href="${ctx}/static/layui/css/layui.css">
    <link rel="stylesheet" href="${ctx}/static/css/global.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/personal.css" media="all">
    <script src="${ctx}/static/layui_v2/layui.js"></script>
    <style>
        .container{
            width: 420px;
            height: 320px;
            min-height: 320px;
            max-height: 320px;
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            margin: auto;
            padding: 60px;
            z-index: 130;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 3px 18px rgba(100, 0, 0, .5);
            font-size: 16px;
        }
        .layui-input{
            border-radius: 5px;
            width: 300px;
            height: 40px;
            font-size: 15px;
        }
        .layui-form-item{
            margin-left: -20px;
        }
        .layui-btn{
            margin-left: -50px;
            border-radius: 5px;
            width: 350px;
            height: 40px;
            font-size: 15px;
        }
        .font-set{
            font-size: 13px;
            text-decoration: none;
            margin-left: 120px;
        }
        a:hover{
            text-decoration: none;
            cursor: pointer;
        }

    </style>
</head>
<body>
<form class="layui-form" action="" method="post">
    <div class="container">

        <div class="layui-form-item">
            <div class="layui-input-block">
                <div class="layui-form-mid layui-word-aux"></div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text" name="userName"  lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密 &nbsp;&nbsp;码</label>
            <div class="layui-input-block">
                <input type="password" name="userPassword" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>

        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="formDemo">登陆</button>
            </div>
            <br>
            <div class="layui-input-block">
                <div class="layui-form-mid layui-word-aux">如果没有用户<a onclick="register()">立即注册</a><a style="margin-left: 10px" href="/user/index.do">返回首页</a></div>
            </div>
            <br><br>


        </div>

    </div>
</form>
<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form',  'layer','common','element'], function () {
        var $ =  layui.$,
            form = layui.form,
            element = layui.element;
            layer = layui.layer,
            common = layui.common;


           form.on('submit(formDemo)', function(data){
               $.ajax({
                   url : '${ctx}/user_login/user/login.do',
                   type : 'post',
                   async: false,
                   data : {
                       userName:data.field.userName,
                       userPassword:data.field.userPassword
                   },
                   success : function(data) {
                       if(data.returnCode == "0000"){
                           window.location.href='${ctx}/user/index.do';
                       }else{
                           common.cmsLayErrorMsg(data.returnMessage);
                       }
                   },error:function(data){
                       layer.close(index);
                   }
               });
              return false;
          });
    });
    function register() {
        common.cmsLayOpen('用户注册','${ctx}/user_login/registerUI.do','400px','300px');
    }

</script>
</body>
</html>