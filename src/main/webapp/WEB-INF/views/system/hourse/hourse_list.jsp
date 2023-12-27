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
                <form class="layui-form" id="hourseSearchForm">
                    <div class="layui-form-item" style="margin-bottom:auto;">
                        <label class="layui-form-label" style="width:auto;">商品名称</label>
                        <div class="layui-input-inline" style="width:145px;">
                            <input type="text" class="layui-input" id="name" autocomplete="off" name="name" placeholder="请输入姓名" >
                        </div>
                        <label class="layui-form-label" style="width:auto;">商品类型</label>
                        <div class="layui-input-inline" style="width:145px;">
                            <select name="type_id">
                                <option value="">请选择</option>
                                <c:forEach items="${codes}" var="code">
                                    <option value="${code.id}">${code.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <a class="layui-btn hourseSearchList_btn" lay-submit lay-filter="hourseSearchFilter"><i class="layui-icon larry-icon larry-chaxun7"></i>查询</a>
                        <div class="layui-inline" style="margin-bottom:auto;margin-left: auto;">
                            <a class="layui-btn layui-btn-normal hourseAdd_btn"> <i class="layui-icon larry-icon larry-xinzeng1"></i>新增商品</a>
                        </div>
                    </div>
                </form>
            </blockquote>
            <div class="larry-separate"></div>
            <!-- 商品列表 -->
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

        /**商品表格加载*/
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
                {field:'name', title: '商品名称',align:'center' },
                {field:'type_id', title: '类型',align:'center'},
                {field:'price', title: '价格(元)',align:'center' },
                {field:'welfare', title: '标签',align:'center' },
                {field:'type_name', title: '关键词',align:'center' },
                {field:'photo', title: '图片',align:'center',templet: '<div><img src="${pageContext.request.contextPath}/upload/{{d.photo}}" alt="" style="width:40px; height:40px;" onclick="show_img(this)""></div>'},
                {field:'info', title: '商品描述',align:'center'},
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
                        name:data.field.name,
                        type_id:data.field.type_id
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

        /**新增商品*/
        $(".hourseAdd_btn").click(function(){
            var url = "${ctx}/hourse/hourse_add.do";
            common.cmsLayOpen('新增商品',url,'100%','100%');
        });

        /**监听工具条*/
        table.on('tool(hourseTableId)', function(obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            //商品详情
            if(layEvent === 'hourse_detail') {
                var id = data.id;
                var url =  "${ctx}/hourse/hourse_detail.do?id="+id;
                common.cmsLayOpen('修改商品',url,'100%','100%');
             //商品删除
            }else if(layEvent === 'hourse_delete') {
                var id = data.id;
                var url = "${ctx}/hourse/ajax_del_hourse.do";
                var param = {id:id};
                common.ajaxCmsConfirm('系统提示', '确定要删除当前商品吗?',url,param);
            }
        });

    });
    function  show_img(e) {
        layer.open({
            type: 1,
            skin: 'layui-layer-rim', //加上边框
            area: ['96%', '96%'], //宽高
            shadeClose: true, //开启遮罩关闭
            title: '商品图片',
            content: "<div style='text-align: center'><img  src=" + $(e).attr('src') + " /></div>"
        });
    }
</script>

<!--工具条 -->
<script type="text/html" id="hourseBar">
    <button class="layui-btn" lay-event="hourse_detail">修改</button>
    <button class="layui-btn layui-btn-danger" lay-event="hourse_delete">删除</button>
</script>

</body>
</html>