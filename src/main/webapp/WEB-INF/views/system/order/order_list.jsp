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
                                <input type="text" class="layui-input" id="order_no" autocomplete="off" name="order_no" placeholder="请输入订单号" >
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
            url: '${ctx}/order/ajax_order_list.do',
            id:'orderTableId',
            method: 'post',
            height:'full-140',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers",title:'序号',width:120},
                {field:'order_no', title: '订单号',align:'center'},
                {field:'num', title: '总数量',align:'center'},
                {field:'total_amount', title: '总价格',align:'center'},
                {field:'status', title: '订单状态',align:'center',templet:'#statusTem'},
                {field:'create_time', title: '创建时间',align:'center'},
                {title: '操作', align:'center',width:300, toolbar: '#orderBar'}

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
        table.on('tool(orderTableId)', function(obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'order_delete') {
                var id = data.id;
                var url = "${ctx}/order/ajax_del_order.do";
                common.ajaxCmsConfirm('系统提示', '确定要删除当前订单吗?',url,param);
            }
            if(layEvent === 'order_detail'){
                var order_no = data.order_no;
                var url = "${ctx}/order/order_detail.do?order_no="+order_no;

                common.cmsLayOpen('订单详情',url,'100%','100%');
            }
        });

    });
</script>

<script type="text/html" id="statusTem">
    {{# if(d.status == '1'){ }}
    <span style="color:red">待支付</span>
    {{# } else if(d.status == 2){ }}
    <span style="color:red">订单取消</span>
    {{# } else if(d.status == 3){ }}
    <span style="color:red">已完成</span>
    {{# } else { }}
    {{d.status}}
    {{# }  }}
</script>

<!--工具条 -->
<script type="text/html" id="orderBar">
    <button class="layui-btn" lay-event="order_detail">订单详情</button>
    <button class="layui-btn layui-btn-danger" lay-event="order_delete">删除</button>
</script>



</body>
</html>