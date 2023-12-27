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
        <div class="larry-separate"></div>
        <!-- 评论列表 -->
        <div class="layui-tab-item layui-show" style="padding: 10px 15px;">
            <table id="orderTableList" lay-filter="orderTableId"></table>
        </div>
    </div>
</div>

<script type="text/javascript">
    layui.config({
        base: "${ctx}/static/js/"
    }).use([ 'table', 'layer', 'common'], function () {
        var $ = layui.$,
            table = layui.table,
            layer = layui.layer,
            common = layui.common;

        var loading = layer.load(0, {shade: [0.3, '#000']});

        table.render({
            elem: '#orderTableList',
            url: '${ctx}/user/order_list.do',
            id: 'orderTableId',
            method: 'post',
            height: 'full-140',
            skin: 'row',
            even: 'true',
            size: 'sm',
            cols: [[
                {type: "numbers", title: '序号', width: 80},
                {field: 'order_no', title: '订单号', align: 'center',width: 200},
                {field: 'num', title: '购买数量', align: 'center',width: 120},
                {field: 'total_amount', title: '总价', align: 'center',width: 120},
                {field: 'status', title: '状态', align: 'center',width: 120,templet:'#statusTem'},
                {field: 'create_time', title: '创建时间', align: 'center',width: 200},
                {title: '操作', align: 'center', toolbar: '#orderBar',width: 500}

            ]],
            page: true,
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);
            }
        });

        /**监听工具条*/
        table.on('tool(orderTableId)', function (obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'order_delete') {
                var id = data.id;
                var url = "${ctx}/user/del_order.do";
                var param = {id: id};
                common.ajaxCmsConfirm('系统提示', '确定要删除当前订单吗?', url, param);
            }
            if(layEvent === 'view_hourse'){
                var order_no = data.order_no;
                var url =  "${ctx}/user/view_hourse.do?order_no="+order_no;
                common.cmsLayOpen('订单详情',url,'80%','80%');
            }
            if(layEvent === 'cancle_apply'){
                var id = data.id;
                var url = "${ctx}/user/update_order_status.do";
                var param = {id:id,status:'2',order_no:data.order_no};
                common.ajaxCmsConfirm('系统提示', '确定要取消订单吗?', url, param);
            }
            if(layEvent === 'add_comment'){
                var url = "${ctx}/user/comment_add.do?order_no="+data.order_no;
                common.cmsLayOpen('添加评论',url,'600px','400px');
            }
            if(layEvent === 'pay'){
              var url= "${ctx}/pay/toPay.do?order_no="+data.order_no+"&total_amount="+data.total_amount;
              window.open(url);
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
    <button class="layui-btn" lay-event="view_hourse">详情查看</button>
    {{# if(d.status == '1'){ }}
       <button class="layui-btn layui-btn-danger" lay-event="pay">去支付</button>
       <button class="layui-btn layui-btn-warm" lay-event="cancle_apply">取消订单</button>
    {{# } else if(d.status == 2){ }}
       <button class="layui-btn layui-btn-danger" lay-event="order_delete">删除</button>
    {{# } else if(d.status == 3){ }}
       <button class="layui-btn layui-btn-warm" lay-event="add_comment">评价</button>
       <button class="layui-btn layui-btn-danger" lay-event="order_delete">删除</button>
    {{# } else { }}

    {{# }  }}
</script>

</body>
</html>