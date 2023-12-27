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
            <input type="hidden" name="order_no" id="order_no" value="${order_no}">
            <!-- 房间列表 -->
            <div class="layui-tab-item layui-show" style="padding: 10px 15px;">
                <table id="orderTableList"  lay-filter="orderTableId"></table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.8.3.js"></script>
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

        /**房间表格加载*/
        table.render({
            elem: '#orderTableList',
            url: '${ctx}/order/order_detail_list.do',
            id:'orderTableId',
            method: 'post',
            height:'full-140',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers",title:'序号',width:120},
                {field:'name', title: '名称',align:'center' },
                {field:'price', title: '价格(元)',align:'center' },
                {field:'num', title: '购买数量',align:'center' },
                {field:'total_amount', title: '总价格',align:'center' },
                {field:'photo', title: '图片',align:'center',templet: '<div><img src="${pageContext.request.contextPath}/upload/{{d.photo}}" alt="" style="width:40px; height:40px;" onclick="show_img(this)""></div>'},
                {title: '操作', align:'center', toolbar: '#orderBar'}

            ]],
            where:{
              order_no:$('#order_no').val()
            },
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
                        name:data.field.name
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
            if(layEvent === 'order_set') {
                var order_no = data.order_no;
                var url = "${ctx}/order/select_hourse.do?order_no="+order_no+"&other_id="+data.other_id;
                common.cmsLayOpen('换房列表',url,'85%','85%');
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

<!--工具条 -->
<script type="text/html" id="orderBar">
    {{# if(d.status == '1' && d.type_name == '房间管理'){ }}
        <button class="layui-btn" lay-event="order_set">换购</button>
    {{# } else { }}
          无操作
    {{# }  }}

</script>

</body>
</html>