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
               <li class="layui-nav-item"><a href="${ctx}/user/index.do">首页</a></li>
               <li class="layui-nav-item">
                   <a href="#">货物分类</a>
                   <dl class="layui-nav-child">
                       <c:forEach var="code" items="${codes}">
                           <dd><a href="${ctx}/user/more.do?type_id=${code.id}">${code.name}</a></dd>
                       </c:forEach>
                   </dl>
               </li>
           </div>
           <div style="float: right;width:30%;">
               <c:if test="${sessionScope.loginUser==null}">
                  <li class="layui-nav-item"><a href="${ctx}/user_login/loginUI.do">登录</a></li>
               </c:if>
               <li class="layui-nav-item"><a href="${ctx}/cart/cart_list.do">购物车(${sessionScope.count})</a></li>
                <li class="layui-nav-item">
                   <c:if test="${sessionScope.loginUser!=null}">
                       <a>${sessionScope.loginUser.userName}</a>
                       <dl class="layui-nav-child">
                           <dd><a onclick="updateInfo()" style="cursor: pointer">修改信息</a></dd>
                           <dd><a href="${ctx}/user/logut.do">退出</a></dd>
                       </dl>
                   </c:if>
                </li>
                <li class="layui-nav-item"><a href="${ctx}/user/personal/info.do">个人中心</a></li>
            </div>
        </ul>
    </div>




<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form', 'table', 'layer','common','laydate','element'], function () {
        var $ =  layui.$,
            form = layui.form,
            element = layui.element;
            table = layui.table,
            layer = layui.layer,
            laydate = layui.laydate,
            common = layui.common;
    });
    function updateInfo() {
        common.cmsLayOpen('个人信息修改','${ctx}/user/editUserUI.do','400px','300px');
    }
</script>
</body>
</html>