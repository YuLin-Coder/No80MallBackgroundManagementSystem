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
    <script src="${ctx}/static/layui/layui.js"></script>
<body>


<div class="larry-grid layui-anim layui-anim-upbit larryTheme-A ">
    <div class="larry-personal">
        <div class="larry-separate"></div>
        <!-- 评论列表 -->
        <div class="layui-tab-item layui-show" style="padding: 10px 15px;">
            <table id="commentTableList" lay-filter="commentTableId"></table>
        </div>
    </div>
</div>

<script type="text/javascript">
    layui.config({
        base: "${ctx}/static/js/"
    }).use(['form', 'table', 'layer', 'common', 'laydate', 'element','rate'], function () {
        var $ = layui.$,
            form = layui.form,
            element = layui.element;
            table = layui.table,
            layer = layui.layer,
            laydate = layui.laydate,
            rate = layui.rate,
            common = layui.common;

        rate.render({
            elem: '#test2'
            ,value: 2 //初始值
            ,theme: '#FFB800'
            ,text: true //开启文本
        });
        var loading = layer.load(0, {shade: [0.3, '#000']});

        table.render({
            elem: '#commentTableList',
            url: '${ctx}/user/comment_list.do',
            id: 'commentTableId',
            method: 'post',
            height: 'full-140',
            skin: 'row',
            even: 'true',
            size: 'sm',
            cols: [[
                {type: "numbers", title: '序号', width: 120},
                {field: 'order_no', title: '订单号', align: 'center'},
                {field: 'star', title: '星级', align: 'center',templet:function(d){
                        return '<div id="star'+d.id +'"></div>';
                 }},
                {field: 'content', title: '评论内容', align: 'center'},
                {field: 'create_time', title: '创建时间', align: 'center'},
                {title: '操作', align: 'center', toolbar: '#commentBar'}

            ]],
            page: true,
            done: function (res, curr, count) {
                var data =res.data;
                console.log(data)
                for(var item in data){
                    rate.render({
                        elem: '#star'+data[item].id
                        ,value: data[item].star
                        ,text: true
                        ,theme: '#FFB800'
                        ,readonly: true
                        ,setText: function(value){ //自定义文本的回调
                            var arrs = {
                                '1': '极差'
                                ,'2': '差'
                                ,'3': '中等'
                                ,'4': '好'
                                ,'5': '极好'
                            };
                            this.span.text(arrs[value]);
                        }
                    })
                }
                common.resizeGrid();
                layer.close(loading);
            }
        });

        rate.render({
            elem: '#star'
            ,value: 2 //初始值
            ,text: true //开启文本
        });

        /**监听工具条*/
        table.on('tool(commentTableId)', function (obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'comment_delete') {
                var id = data.id;
                var url = "${ctx}/user/del_comment.do";
                var param = {id: id};
                layer.confirm('确定要删除当前评论吗?', {
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
                            if(data.returnCode == 0000){
                                layer.msg(data.returnMessage, {icon: 6});
                                location.reload();
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
</script>

<!--工具条 -->
<script type="text/html" id="commentBar">
    <button class="layui-btn layui-btn-danger" lay-event="comment_delete">删除</button>
</script>

</body>
</html>