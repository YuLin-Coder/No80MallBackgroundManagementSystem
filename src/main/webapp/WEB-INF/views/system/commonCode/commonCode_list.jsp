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
            <blockquote class="layui-elem-quote mylog-info-tit">
                <div class="layui-form-item" style="margin-bottom:auto;">
                    <div class="layui-inline" style="margin-bottom:auto;margin-left: auto;">
                        <a class="layui-btn layui-btn-normal commonCodeAdd_btn"> <i class="layui-icon larry-icon larry-xinzeng1"></i>新增类型</a>
                    </div>
                </div>
            </blockquote>
            <div class="larry-separate"></div>
            <!-- 类型列表 -->
            <div class="layui-tab-item layui-show" style="padding: 10px 15px;">
                <table id="commonCodeTableList"  lay-filter="commonCodeTableId"></table>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form', 'table', 'layer','common','laydate'], function () {
        var $ =  layui.$,
                form = layui.form,
                table = layui.table,
                layer = layui.layer,
                laydate = layui.laydate,
                common = layui.common;
        var loading = layer.load(0,{ shade: [0.3,'#000']});

        /**类型表格加载*/
        table.render({
            elem: '#commonCodeTableList',
            url: '${ctx}/commonCode/ajax_commonCode_list.do',
            id:'commonCodeTableId',
            method: 'post',
            height:'full-140',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers",title:'序号',width:120},
                {field:'code', title: '编码',align:'center' },
                {field:'name', title: '名称',align:'center'},
                {title: '操作', align:'center', toolbar: '#commonCodeBar'}

            ]],
            page: true,
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });



        /**新增类型*/
        $(".commonCodeAdd_btn").click(function(){
            var url = "${ctx}/commonCode/commonCode_add.do";
            common.cmsLayOpen('新增类型',url,'500px','260px');
        });

        /**监听工具条*/
        table.on('tool(commonCodeTableId)', function(obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            //类型详情
            if(layEvent === 'commonCode_detail') {
                var id = data.id;
                var url =  "${ctx}/commonCode/commonCode_detail.do?id="+id;
                common.cmsLayOpen('修改类型',url,'500px','260px');
             //类型删除
            }else if(layEvent === 'commonCode_delete') {
                var id = data.id;
                var url = "${ctx}/commonCode/ajax_del_commonCode.do";
                var param = {id:id};
                common.ajaxCmsConfirm('系统提示', '确定要删除当前类型吗?',url,param);
            }
        });

    });
</script>

<!--工具条 -->
<script type="text/html" id="commonCodeBar">
    <button class="layui-btn" lay-event="commonCode_detail">修改</button>
    <button class="layui-btn layui-btn-danger" lay-event="commonCode_delete">删除</button>
</script>



</body>
</html>