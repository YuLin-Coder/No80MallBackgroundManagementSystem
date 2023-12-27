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
                        <form class="layui-form" id="userSearchForm">
                            <label class="layui-form-label" style="width:auto;">订单号</label>
                            <div class="layui-input-inline" style="width:145px;">
                                <select name="type_name">
                                    <option value="1">按日</option>
                                    <option value="2">按月</option>
                                </select>
                            </div>

                            <a class="layui-btn orderSearchList_btn" lay-submit lay-filter="orderSearchFilter"><i class="layui-icon larry-icon larry-chaxun7"></i>查询</a>
                        </form>
                    </div>
                </div>
            </blockquote>
            <div class="larry-separate"></div>
            <!-- 订单列表 -->
            <div class="layui-tab-item layui-show" style="padding: 10px 15px;">
                <table id="orderTableList"  lay-filter="orderTableId"></table>
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

        /**订单表格加载*/
        table.render({
            elem: '#orderTableList',
            url: '${ctx}/order/order_sale_list.do',
            id:'orderTableId',
            method: 'post',
            height:'full-140',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers",title:'序号',width:120},
                {field:'num', title: '总数量',align:'center'},
                {field:'total_amount', title: '总价格',align:'center'},
                {field:'create_time', title: '创建时间',align:'center'},
            ]],
            page: true,
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });

        /**查询*/
        $(".orderSearchList_btn").click(function(){
            var loading = layer.load(0,{ shade: [0.3,'#000']});
            //监听提交
            form.on('submit(orderSearchFilter)', function (data) {
                table.reload('orderTableId',{
                    where: {
                        type_name:data.field.type_name
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
    });
</script>


</body>
</html>