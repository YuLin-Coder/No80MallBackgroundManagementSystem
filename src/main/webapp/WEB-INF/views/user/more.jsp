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
        .title{
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
            width: 70%;
            float: left;
        }
    </style>
</head>
<body>

    <jsp:include page="${ctx}/user/header.do"></jsp:include>
   <div class="layui-container" style="width: 95%">
       <div class="layui-row">
           <div class="layui-col-md12" style="display: flex;text-align: center;margin-bottom: 20px">
               <div class="layui-col-md6 layui-col-lg-offset2"> <input class="layui-input" name="name" id="name"></div>
               <div><button class="layui-btn" onclick="search()">搜索</button></div>
           </div>
           <div style="flex:1;margin-top: 20px">
               <c:if test="${result.data.size()==0}">
                     <div style="text-align: center;font-size: 16px">无数据</div>
               </c:if>
               <c:if test="${result.data.size()>0}">
                   <c:forEach items="${result.data}" var="hourse">
                       <div class="layui-card" style="margin: 5px 40px 10px 0px;width: 22%;float: left">
                           <div class="layui-card-header" style="display: flex;">
                               <div class="title" title="${hourse.name}">${hourse.name}</div>
                               <div style="float: right">${hourse.price}元  <span style="margin-left: 5px">${hourse.the_size}m*m</span></div>
                           </div>
                           <div class="layui-card-body" onclick="detail('${hourse.id}','${hourse.user_code}')" style="cursor: pointer;text-align: center">
                               <img src="/upload/${hourse.photo}" width="260" height="260">
                           </div>
                       </div>
                   </c:forEach>
               </c:if>
           </div>
       </div>
   </div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.8.3.js"></script>
<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form', 'table', 'layer','common','laydate','element','carousel'], function () {
        var $ =  layui.$,
            form = layui.form,
            element = layui.element;
            table = layui.table,
            layer = layui.layer,
            carousel = layui.carousel,
            laydate = layui.laydate,
            common = layui.common;

        //建造实例
        carousel.render({
            elem: '#lunbo',
            width: '95%',//设置容器宽度
            arrow: 'always', //始终显示箭头
            height:'360px'
        });
    });
    function detail(id,user_code){
        window.location.href='${ctx}/user/detailHourse.do?id='+id+"&user_code="+user_code;
    }
    function search() {
        window.location.href='${ctx}/user/more.do?name='+$('#name').val();
    }
</script>
</body>
</html>