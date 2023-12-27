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
<div class="larry-grid layui-anim layui-anim-upbit larryTheme-A ">
    <div class="larry-personal">
        <div class="layui-tab">
            <div class="larry-separate"></div>
            <input type="hidden" id="order_no" value="${order_no}">
            <div class="layui-tab-item layui-show" style="padding: 10px 15px;">
                <table id="hourseTableList"  lay-filter="hourseTableId"></table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.8.3.js"></script>
<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form', 'table', 'layer','common','laydate'], function () {
        var     $ =  layui.$,
                form = layui.form,
                table = layui.table,
                layer = layui.layer,
                laydate = layui.laydate,
                common = layui.common;
        var loading = layer.load(0, {shade: [0.3, '#000']});
        var order_no=$('#order_no').val();
        /**房间表格加载*/
        table.render({
            elem: '#hourseTableList',
            url: '${ctx}/user/hourse_all_list.do',
            id:'hourseTableId',
            method: 'post',
            height:'full-140',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {field:'name', title: '名称',align:'center' },
                {field:'type_id', title: '类型',align:'center'},
                {field:'price', title: '价格(元)',align:'center' },
                {field:'welfare', title: '条件',align:'center' },
                {field:'num', title: '购买数量',align:'center' },
                {field:'total_amount', title: '总价',align:'center' },
                {field:'photo', title: '图片',align:'center',templet: '<div><img src="${pageContext.request.contextPath}/upload/{{d.photo}}" alt="" style="width:40px; height:40px;" onclick="show_img(this)"></div>'},
                {field:'info', title: '描述',align:'center'}
            ]],
            where:{
                id:order_no
            },
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });
    });
    function  show_img(e) {
        layer.open({
            type: 1,
            skin: 'layui-layer-rim', //加上边框
            area: ['96%', '96%'], //宽高
            shadeClose: true, //开启遮罩关闭
            title: '图片',
            content: "<div style='text-align: center'><img  src=" + $(e).attr('src') + " /></div>"
        });
    }
</script>
</body>
</html>