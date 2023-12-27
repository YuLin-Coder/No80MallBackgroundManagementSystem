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
    <link rel="stylesheet" href="${ctx}/static/layui_v2/css/layui.css">
    <link rel="stylesheet" href="${ctx}/static/css/global.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/personal.css" media="all">
    <script src="${ctx}/static/layui_v2/layui.js"></script>
<body>
<div class="layui-row">
    <ul class="layui-nav" lay-filter="top" style="display: flex">
        <div class="layui-col-lg-offset2" style="float: left;width:60%;">
            <li class="layui-nav-item">个人中心</li>
        </div>
    </ul>
</div>

<div>
        <ul class="layui-nav layui-nav-tree layui-nav-side" >
           <div style="margin-top: 50px">
               <li  class="layui-nav-item"><a href="/user/index.do" >首页</a></li>
               <li  class="layui-nav-item"><a href="/user/comment.do" target="iframeMain">我的评论</a></li>
               <li  class="layui-nav-item"><a href="/user/myorder.do" target="iframeMain">我的订单</a></li>
           </div>
        </ul>
    </div>
    <div class="layui-body">
        <div style="padding:80px 20px 0px 20px;">
            <div class="layadmin-tabsbody-item layui-show">
                <iframe src="" width="95%" height="800" frameborder="0"  id="test" name="iframeMain"></iframe>
            </div>
        </div>
    </div>

</body>
</html>