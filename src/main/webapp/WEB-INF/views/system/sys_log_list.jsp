<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/comm/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>后台管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="后台管理系统">
    <meta name="description" content="致力于提供通用版本后台管理解决方案">

    <link rel="shortcut icon" href="${ctx}/static/img/favicon.ico">
    <link rel="stylesheet" href="${ctx}/static/layui_v2/css/layui.css">
    <link rel="stylesheet" href="${ctx}/static/css/global.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/personal.css" media="all">
    <link rel="stylesheet" type="text/css" href="http://at.alicdn.com/t/font_9h680jcse4620529.css">
    <script src="${ctx}/static/layui_v2/layui.js"></script>

<body>
<div class="larry-grid layui-anim layui-anim-upbit larryTheme-A ">
    <div class="larry-personal">
        <div class="layui-tab layui-tab-brief" lay-filter="filterSysLogTab">
            <ul class="layui-tab-title">
                <li class="layui-this">业务日志</li>
                <li>异常日志</li>
            </ul>
            <div class="layui-tab-content" style="padding: 0px">
                <!-- 业务日志TAB -->
                <div class="layui-tab-item layui-show">
                    <blockquote class="layui-elem-quote mylog-info-tit" style="border-bottom: 0px; margin: 10px 15px;">

                        <div class="layui-form-item" style="margin-bottom: 0px;">
                            <input type="hidden" id="currentDate" value="${currentDate}">
                            <form class="layui-form" id="sysSearchForm">
                                <div class="layui-inline" style="margin: 0px;">
                                    <input type="hidden" name="logType" value="info">
                                    <div class="layui-input-inline" style="width:110px;">
                                        <select name="searchTerm">
                                            <option value="logTitleTerm">日志标题</option>
                                            <option value="logMethodTerm">请求方式</option>
                                        </select>
                                    </div>
                                    <div class="layui-input-inline" style="width:145px;">
                                        <input type="text" name="searchContent" value="" placeholder="请输入关键字" class="layui-input search_input">
                                    </div>
                                </div>
                                <div class="layui-inline" style="margin:0px;">
                                    <label class="layui-form-label" style="width:auto;">请求时间</label>
                                    <div class="layui-input-inline" style="width:145px;">
                                        <input type="text" class="layui-input" id="beginTime" name="beginTime" placeholder="请选择" readonly>
                                    </div>
                                </div>
                                <div class="layui-inline" style="margin:0px;">
                                    <a class="layui-btn sysSearch_btn" lay-submit lay-filter="sysSearchFilter"><i class="layui-icon larry-icon larry-chaxun7"></i>查询</a>
                                </div>
                                <div class="layui-inline" style="margin:0px;">
                                    <a class="layui-btn layui-btn-normal excelSysLogExport_btn"  style="background-color:#5FB878"> <i class="layui-icon larry-icon larry-danye"></i>导出</a>
                                </div>
                            </form>
                        </div>
                    </blockquote>
                    <div class="larry-separate"></div>
                    <div style=" margin: 10px 15px;">
                        <!--  业务日志列表 -->
                        <table id="sysLogTableList" lay-filter="sysLogTableId" ></table>
                    </div>
                </div>
                <!-- 异常日志TAB -->
                <div class="layui-tab-item">
                    <blockquote class="layui-elem-quote mylog-info-tit" style="border-bottom: 0px; margin: 10px 15px;">
                        <div class="layui-form-item" style="margin-bottom: 0px;">
                            <input type="hidden" id="currentDate2" value="${currentDate}">
                            <form class="layui-form" id="sysExceptionForm">
                                <div class="layui-inline" style="margin: 0px;">
                                    <input type="hidden" name="logType" value="error">
                                    <div class="layui-input-inline" style="width:110px;">
                                        <select name="searchTerm" >
                                            <option value="logTitleTerm">日志标题</option>
                                        </select>
                                    </div>
                                    <div class="layui-input-inline" style="width:145px;">
                                        <input type="text" name="searchContent" value="" placeholder="请输入关键字" class="layui-input search_input">
                                    </div>
                                </div>
                                <div class="layui-inline" style="margin:0px;">
                                    <label class="layui-form-label" style="width:auto;">请求时间</label>
                                    <div class="layui-input-inline" style="width:145px;">
                                        <input type="text" class="layui-input" id="beginTime2" name="beginTime2" placeholder="请选择" readonly>
                                    </div>
                                </div>
                                <div class="layui-inline" style="margin:0px;">
                                    <a class="layui-btn sysExceptionSearch_btn" lay-submit lay-filter="sysExceptionSearchFilter"><i class="layui-icon larry-icon larry-chaxun7"></i>查询</a>
                                </div>
                                <div class="layui-inline" style="margin:0px;">
                                    <a class="layui-btn layui-btn-normal excelSysExceptionLogExport_btn"  style="background-color:#5FB878"> <i class="layui-icon larry-icon larry-danye"></i>导出</a>
                                </div>
                            </form>
                        </div>
                    </blockquote>
                    <div class="larry-separate"></div>
                    <div style=" margin: 10px 15px;">
                        <!-- 异常日志列表 -->
                        <table id="sysLogExceptionTableList" lay-filter="sysLogExceptionTableId"></table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    var $,table,common;
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form', 'table','common','element','laydate'], function () {
        $ =  layui.$;
        table = layui.table;
        common = layui.common;

       var  form = layui.form,
        element = layui.element,
        laydate = layui.laydate;


        /**请求时间*/
        laydate.render({
            elem: '#beginTime',
            theme: 'molv',
            value: new Date()
        });
        /**请求时间*/
        laydate.render({
            elem: '#beginTime2',
            theme: 'molv',
            value: new Date()
        });


        //业务日志
        sysLogTable();

        /**tab监听*/
        element.on('tab(filterSysLogTab)', function(data){
            if(data.index == 0){
                sysLogTable();  //业务日志
            }else if(data.index == 1){
                sysLogExceptionTable(); //异常日志table
            }
        });

        /**业务日志查询*/
        $(".sysSearch_btn").click(function(){
            var loading = layer.load(0,{ shade: [0.3,'#000']});

            //监听提交
            form.on('submit(sysSearchFilter)', function (data) {
                table.reload('sysLogTableId',{
                    where: {
                        searchTerm:data.field.searchTerm,
                        searchContent:data.field.searchContent,
                        beginTime:data.field.beginTime,
                        logType:'info'
                    },
                    height: 'full-183',
                    page: true,
                    done: function (res, curr, count) {
                        common.resizeGrid();
                        layer.close(loading);

                    }
                });

            });

        });
        /**异常日志查询*/
        $(".sysExceptionSearch_btn").click(function(){
            var loading = layer.load(0,{ shade: [0.3,'#000']});

            //监听提交
            form.on('submit(sysExceptionSearchFilter)', function (data) {
                table.reload('sysLogExceptionTableId',{
                    where: {
                        searchTerm:data.field.searchTerm,
                        searchContent:data.field.searchContent,
                        beginTime:data.field.beginTime2,
                        logType:'error'
                    },
                    height: 'full-183',
                    page: true,
                    done: function (res, curr, count) {
                        common.resizeGrid();
                        layer.close(loading);

                    }
                });

            });

        });


        /**业务日志导出*/
        $(".excelSysLogExport_btn").click(function(){
            var url = '${ctx}/syslog/excel_sys_log_export.do';
            $("#sysSearchForm").attr("action",url);
            $("#sysSearchForm").submit();
        });

        /**异常日志导出*/
        $(".excelSysExceptionLogExport_btn").click(function(){
            var url = '${ctx}/syslog/excel_sys_exception_log_export.do';
            $("#sysExceptionForm").attr("action",url);
            $("#sysExceptionForm").submit();
        });



    });


    /**业务日志table*/
    function sysLogTable() {
        var loading = layer.load(0,{ shade: [0.3,'#000']});

        table.render({
            elem: '#sysLogTableList',
            url: '${ctx}/syslog/ajax_sys_log_list.do',
            id:'sysLogTableId',
            method: 'post',
            height:'full-183',
            skin:'row',
            even:'true',
            size: 'sm',
            where: {
                logType:'info',
                beginTime:$("#currentDate").val(),
            },
            cols: [[
                {type:"numbers"},
                {field:'logTitle', title: '日志标题',align:'center' },
                {field:'logType', title: '日志类型',align:'center',templet: '#logTypeTpl'},
                {field:'logUrl', title: '日志请求URL',align:'center'},
                {field:'logMethod', title: '请求方式',align:'center'},
                {field:'logParams', title: '请求参数',align:'center'},
                {field:'logUserName', title: '请求用户',align:'center'},
                {field:'logIp', title: '请求IP',align:'center',width: '10%'},
                {field:'logIpAddress', title: 'IP归属',align:'center'},
                {field:'logStartTime', title: '请求时间',align:'center',width: '12%'},
                {field:'logElapsedTime', title: '耗时(毫秒)',align:'center'}


            ]],
            page: true,
            limit: 10,//默认显示10条
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });

    }
    /**异常日志table*/
    function sysLogExceptionTable() {
        var loading = layer.load(0,{ shade: [0.3,'#000']});

        table.render({
            elem: '#sysLogExceptionTableList',
            url: '${ctx}/syslog/ajax_sys_log_list.do',
            id:'sysLogExceptionTableId',
            method: 'post',
            height:'full-183',
            skin:'row',
            even:'true',
            size: 'sm',
            where: {
                logType:'error',
                beginTime:$("#currentDate2").val(),
            },
            cols: [[
                {field:'logTitle', title: '日志标题',align:'center' },
                {field:'logType', title: '日志类型',align:'center',templet: '#logTypeTpl'},
                {field:'logUrl', title: '异常方法',align:'center'},
                {field:'logParams', title: '请求参数',align:'center'},
                {field:'logException', title: '异常信息',align:'center'},
                {field:'logUserName', title: '请求用户',align:'center'},
                {field:'logIp', title: '请求IP',align:'center'},
                {field:'logIpAddress', title: 'IP归属',align:'center',width: '10%'},
                {field:'logStartTime', title: '请求时间',align:'center',width: '12%'},
                {field:'logElapsedTime', title: '耗时(毫秒)',align:'center'}


            ]],
            page: true,
            limit: 10,//默认显示10条
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });

    }



</script>
<!-- 日志类型tpl-->
<script type="text/html" id="logTypeTpl">

    {{# if(d.logType == 'info'){ }}
    <span class="label label-info ">业务日志</span>
    {{# } else if(d.logType == 'error'){ }}
    <span class="label label-danger ">异常日志</span>
    {{# } else { }}
    {{d.logType}}
    {{# }  }}
</script>




</body>
</html>