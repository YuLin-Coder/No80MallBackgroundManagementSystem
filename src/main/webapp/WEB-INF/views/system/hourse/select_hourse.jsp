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
                    <input type="hidden" value="${order_no}" name="order_no" id="order_no">
                    <input type="hidden" value="${other_id}" name="other_id" id="other_id">
                    <label class="layui-form-label" style="width:auto;">房间名称</label>

                    <div class="layui-input-inline" style="width:145px;">
                        <input type="text" class="layui-input" id="name" autocomplete="off" name="name" placeholder="请输入姓名" >
                    </div>

                    <label class="layui-form-label" style="width:auto;">房间名称</label>

                    <div class="layui-input-inline" style="width:145px;">
                        <input type="text" class="layui-input" id="type_id" autocomplete="off" name="type_id" placeholder="请输入房间类型" >
                    </div>

                </div>
            </blockquote>
            <div class="larry-separate"></div>
            <!-- 房间列表 -->
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
        var $ =  layui.$,
            form = layui.form,
            table = layui.table,
            layer = layui.layer,
            laydate = layui.laydate,
            common = layui.common;
        var loading = layer.load(0,{ shade: [0.3,'#000']});

        /**房间表格加载*/
        table.render({
            elem: '#hourseTableList',
            url: '${ctx}/hourse/ajax_hourse_list.do',
            id:'hourseTableId',
            method: 'post',
            height:'full-140',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers",title:'序号',width:120},
                {field:'name', title: '房间名称',align:'center' },
                {field:'type_id', title: '类型',align:'center'},
                {field:'price', title: '价格(元)',align:'center' },
                {field:'the_size', title: '房间大小(m*m)',align:'center'},
                {field:'welfare', title: '条件',align:'center' },
                {field:'photo', title: '图片',align:'center',templet: '<div><img src="${pageContext.request.contextPath}/upload/{{d.photo}}" alt="" style="width:40px; height:40px;" onclick="show_img(this)""></div>'},
                {field:'info', title: '房间描述',align:'center'},
                {title: '操作', align:'center', toolbar: '#hourseBar'}

            ]],
            page: true,
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });

        /**查询*/
        $(".hourseSearchList_btn").click(function(){
            var loading = layer.load(0,{ shade: [0.3,'#000']});
            //监听提交
            form.on('submit(hourseSearchFilter)', function (data) {
                table.reload('hourseTableId',{
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
        table.on('tool(hourseTableId)', function(obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'hourse_set') {
                console.log("12",data);
                var id = data.id;
                var url = "${ctx}/order/set_hourse.do";
                var param = {id:id,order_no:$('#order_no').val(),total_amount:data.price,other_id:$('#other_id').val()};

                layer.confirm('确定要换房间吗?', {
                    title: '系统提示',
                    resize: false,
                    btn: ['确定', '取消'],
                    btnAlign: 'c',
                    anim:1,
                    icon: 3
                }, function () {
                    $.ajax({
                        url : url,
                        type : 'post',
                        async: false,
                        data : param,
                        success : function(data) {
                            if(data.returnCode == '0000'){
                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                parent.layer.close(index); //再执行关闭                        //刷新父页面
                                parent.location.reload();
                            }else{
                                var index =layer.alert(data.returnMessage, { icon: 5},function () {
                                    layer.close(index);
                                });
                            }
                        },error:function(data){

                        }
                    });

                }, function () {

                })
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
<script type="text/html" id="hourseBar">
    <button class="layui-btn" lay-event="hourse_set">换购</button>
</script>

</body>
</html>