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
                <form class="layui-form" id="salarySearchForm">
                    <div class="layui-form-item" style="margin-bottom:auto;">
                        <label class="layui-form-label" style="width:auto;">姓名</label>
                        <div class="layui-input-inline" style="width:145px;">
                            <input type="text" class="layui-input" id="name" autocomplete="off" name="name" placeholder="请输入姓名" >
                        </div>
                        <a class="layui-btn salarySearchList_btn" lay-submit lay-filter="salarySearchFilter"><i class="layui-icon larry-icon larry-chaxun7"></i>查询</a>
                    </div>
                </form>
            </blockquote>
            <div class="larry-separate"></div>
            <!-- 员工列表 -->
            <div class="layui-tab-item layui-show" style="padding: 10px 15px;">
                <table id="salaryTableList"  lay-filter="salaryTableId"></table>
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

        /**员工表格加载*/
        table.render({
            elem: '#salaryTableList',
            url: '${ctx}/salary/ajax_salary_list.do',
            id:'salaryTableId',
            method: 'post',
            height:'full-140',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers",title:'序号',width:120},
                {field:'name', title: '姓名',align:'center' },
                {field:'able_time', title: '发放时间',align:'center'},
                {field:'should_salary', title: '应发工资',align:'center' },
                {field:'real_salary', title: '实发工资',align:'center'},
                {field:'deduct_salry', title: '扣除工资',align:'center' },
                {field:'remark', title: '备注',align:'center'}
            ]],
            page: true,
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });

        /**查询*/
        $(".salarySearchList_btn").click(function(){
            var loading = layer.load(0,{ shade: [0.3,'#000']});
            //监听提交
            form.on('submit(salarySearchFilter)', function (data) {
                table.reload('salaryTableId',{
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

        /**新增员工*/
        $(".salaryAdd_btn").click(function(){
            var url = "${ctx}/salary/salary_add.do";
            common.cmsLayOpen('新增员工',url,'700px','460px');
        });

    });
</script>

</body>
</html>