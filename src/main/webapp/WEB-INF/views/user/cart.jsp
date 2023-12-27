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
    <link rel="stylesheet" href="${ctx}/static/css/global.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/personal.css" media="all">
    <link rel="stylesheet" href="${ctx}/static/layui/css/layui.css">
    <script src="${ctx}/static/layui_v2/layui.js"></script>
    <style>
        .info{
            width: 100px;
        }
        p{
            width: 100px;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }
    </style>
</head>
<body>

    <jsp:include page="${ctx}/user/header.do"></jsp:include>
    <div class="layui-container" >
        <div class="layui-row layui-col-md12">
            <div style="margin-top: 30px;">
                  <h1>购物车</h1>
            </div>
            <table class="layui-table" >
                <thead>
                    <tr>
                        <th style="text-align: center">图片</th>
                        <th style="text-align: center">名称</th>
                        <th style="text-align: center">标签</th>
                        <th style="text-align: center">关键词</th>
                        <th style="text-align: center">库存</th>
                        <th style="text-align: center">价格(元)</th>
                        <th style="text-align: center">总数量</th>
                        <th style="text-align: center">总价</th>
                        <th class="info">介绍</th>
                        <th style="text-align: center">操作</th>
                    </tr>
                </thead>
                <c:if test="${sessionScope.hourseList.size()==0}">
                    <tr style="text-align: center">
                        <td colspan="9">购物车空空如也</td>
                    </tr>
                </c:if>
                <c:if test="${sessionScope.hourseList.size()>0}">
                    <c:forEach items="${sessionScope.hourseList}" var="hourse">
                        <tr>
                            <td style="text-align: center"><img  onclick="show_img(this)" src="${ctx}/upload/${hourse.photo}" width="80" height="80"></td>
                            <td style="text-align: center">${hourse.name}</td>
                            <td style="text-align: center">${hourse.welfare}</td>
                            <td style="text-align: center">${hourse.type_name}</td>
                            <td style="text-align: center">${hourse.the_size}</td>
                            <td style="text-align: center">${hourse.price}</td>
                            <td style="text-align: center">
                                <i class="layui-icon layui-icon-subtraction" onclick="addNum('${hourse.id}','-','${hourse.num}')" style="font-size: 16px;color: red;cursor: pointer"></i>
                                    ${hourse.num}
                                <i class="layui-icon layui-icon-add-1" onclick="addNum('${hourse.id}','+','${hourse.num}')" style="font-size: 16px;color: red;cursor: pointer"></i>
                            </td>
                            <td style="text-align: center">${hourse.total_amount}</td>
                            <td class="info" title="${hourse.info}"><p class="info">${hourse.info}</p></td>
                            <td style="text-align: center"><a class="layui-btn" href="/cart/deleteCart.do?id=${hourse.id}">删除</a></td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="10" ><div style="margin-left: 90%"><a onclick="generOrder()" class="layui-btn layui-btn-danger">去结算</a></div></td>
                    </tr>
                </c:if>
            </table>

        </div>
    </div>

    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.8.3.js"></script>
<script type="text/javascript">
    function  show_img(e) {
        layer.open({
            type: 1,
            skin: 'layui-layer-rim', //加上边框
            area: ['80%', '80%'], //宽高
            shadeClose: true, //开启遮罩关闭
            title: '图片',
            content: "<div style='text-align: center'><img  src=" + $(e).attr('src') + " /></div>"
        });
    }
    function generOrder() {

        $.ajax({
            url : '${ctx}/cart/generOrder.do',
            type : 'post',
            async: false,
            success : function(data) {
               if(data.returnCode=='0000'){
                   var url= "${ctx}/pay/toPay.do?order_no="+data.returnData.order_no+"&total_amount="+data.returnData.total_amount;
                   window.open(url);
               }else{
                   layer.msg(data.returnMessage,{icon:5});
               }
            },error:function(data){

            }
        });
    }
    function addNum(id,type,num) {
        if(type=='-'&&num=='1'){
            layer.msg('加购数量不能少于1',{icon:5});
            return false;
        }
        $.ajax({
            url : '${ctx}/cart/addNum.do',
            type : 'post',
            async: false,
            data : {
                id:id,
                type:type
            },
            success : function(data) {
                window.location.href='${ctx}/cart/cart_list.do'
            },error:function(data){

            }
        });
    }
</script>
</body>
</html>