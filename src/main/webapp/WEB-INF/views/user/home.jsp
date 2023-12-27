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
   <div class="layui-container" style="width: 90%">
       <div class="layui-row">
           <div class="layui-carousel" id="lunbo" style="margin:10px 0px;">
               <div carousel-item>
                   <div><img src="/upload/1.jpg"  width="100%" height="400px"></div>
                   <div><img src="/upload/2.jpg"  width="100%" height="400px"></div>
                   <div><img src="/upload/3.jpg"  width="100%" height="400px"></div>
                   <div><img src="/upload/4.jpg"  width="100%" height="400px" ></div>
                   <div><img src="/upload/5.jpg"  width="100%" height="400px"></div>
               </div>
           </div>

           <div class="layui-card" style="width: 95%">
               <div class="layui-card-header" style="background: gray;display: flex;">
                   <div class="title" style="width: 95%">房间列表</div>
                   <div onclick="more()" style="cursor: pointer">更多</div>
               </div>
           </div>
           <div style="flex:1;">
               <c:forEach items="${result.data}" var="hourse">
                   <div class="layui-card" style="margin: 5px 40px 10px 0px;width: 30%;float: left">
                       <div class="layui-card-header" style="display: flex;">
                           <div class="title" title="${hourse.name}">${hourse.name}</div>
                           <div style="float: right">${hourse.price}元  <span style="margin-left: 5px">${hourse.the_size}m*m</span></div>
                       </div>
                       <div class="layui-card-body" onclick="detail('${hourse.id}','${hourse.user_code}')" style="cursor: pointer;text-align: center">
                           <img src="/upload/${hourse.photo}" width="260" height="260">
                       </div>
                   </div>
               </c:forEach>
           </div>
       </div>
   </div>
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
    function more() {
        window.location.href='${ctx}/user/more.do';
    }
</script>
</body>
</html>