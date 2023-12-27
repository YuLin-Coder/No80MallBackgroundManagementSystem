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
                <form class="layui-form" id="instoackSearchForm">
                    <div class="layui-form-item" style="margin-bottom:auto;">
                        <label class="layui-form-label" style="width:auto;">商品名称</label>
                        <div class="layui-input-inline" style="width:145px;">
                            <input type="text" class="layui-input" id="name" autocomplete="off" name="name" placeholder="请输入商品名称" >
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
                        <a class="layui-btn instoackSearchList_btn" lay-submit lay-filter="instoackSearchFilter"><i class="layui-icon larry-icon larry-chaxun7"></i>查询</a>

                    </div>
                </form>
            </blockquote>
            <div class="larry-separate"></div>
            <!-- 商品列表 -->
            <div class="layui-tab-item layui-show" style="padding: 10px 15px;">
                <table id="instoackTableList"  lay-filter="instoackTableId"></table>
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
            elem: '#instoackTableList',
            url: '${ctx}/instoack/ajax_stoack_list.do',
            id:'instoackTableId',
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
                {field:'the_size', title: '剩余库存量',align:'center'},
                {title: '操作', align:'center', toolbar: '#instoackBar'}

            ]],
            page: true,
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });

        /**查询*/
        $(".instoackSearchList_btn").click(function(){
            var loading = layer.load(0,{ shade: [0.3,'#000']});
            //监听提交
            form.on('submit(instoackSearchFilter)', function (data) {
                table.reload('instoackTableId',{
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


        /**监听工具条*/
        table.on('tool(instoackTableId)', function(obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            //商品详情
            if(layEvent === 'instoack_detail') {
                var id = data.id;
                var url =  "${ctx}/instoack/in_good.do?id="+id;
                common.cmsLayOpen('进货',url,'400px','300px');
             //商品删除
            }
        });

    });
</script>

<!--工具条 -->
<script type="text/html" id="instoackBar">
    <button class="layui-btn" lay-event="instoack_detail">进货</button>
</script>

</body>
</html>