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
                        <form class="layui-form" id="commentSearchForm">
                            <label class="layui-form-label" style="width:auto;">订单号</label>
                            <div class="layui-input-inline" style="width:145px;">
                                <input type="text" class="layui-input" id="order_no" autocomplete="off" name="order_no" placeholder="请输入订单号" >
                            </div>

                            <a class="layui-btn commentSearchList_btn" lay-submit lay-filter="commentSearchFilter"><i class="layui-icon larry-icon larry-chaxun7"></i>查询</a>
                        </form>
                    </div>
                </div>
            </blockquote>
            <div class="larry-separate"></div>
            <!-- 评论列表 -->
            <div class="layui-tab-item layui-show" style="padding: 10px 15px;">
                <table id="commentTableList"  lay-filter="commentTableId"></table>
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

        /**评论表格加载*/
        table.render({
            elem: '#commentTableList',
            url: '${ctx}/comment/ajax_comment_list.do',
            id:'commentTableId',
            method: 'post',
            height:'full-140',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers",title:'序号',width:120},
                {field:'user_code', title: '用户名称',align:'center' },
                {field:'order_no', title: '订单号',align:'center'},
                {field:'star', title: '星级',align:'center'},
                {field:'content', title: '评论内容',align:'center'},
                {field:'create_time', title: '创建时间',align:'center'},
                {title: '操作', align:'center', toolbar: '#commentBar'}

            ]],
            page: true,
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });

        /**查询*/
        $(".commentSearchList_btn").click(function(){
            var loading = layer.load(0,{ shade: [0.3,'#000']});
            //监听提交
            form.on('submit(commentSearchFilter)', function (data) {
                table.reload('commentTableId',{
                    where: {
                        order_no:data.field.order_no
                    },
                    height: 'full-140',
                    page: true,
                    done: function (res, curr, count) {
                        common.resizeGrid();
                        layer.close(loading);

                    }
                });

            });

        });

        /**监听工具条*/
        table.on('tool(commentTableId)', function(obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'comment_delete') {
                var id = data.id;
                var url = "${ctx}/comment/ajax_del_comment.do";
                var param = {id:id};
                common.ajaxCmsConfirm('系统提示', '确定要删除当前评论吗?',url,param);
            }
        });

    });
</script>



<!--工具条 -->
<script type="text/html" id="commentBar">
    <button class="layui-btn layui-btn-danger" lay-event="comment_delete">删除</button>
</script>



</body>
</html>