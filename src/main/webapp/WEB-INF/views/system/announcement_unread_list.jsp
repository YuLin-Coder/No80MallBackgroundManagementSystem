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
        <div class="layui-tab layui-tab-brief" lay-filter="filterAnnInfoTab">
            <ul class="layui-tab-title">
                <li class="layui-this">未读公告<span class="layui-badge unreadSpan">0</span></li>
                <li>已读公告<span class="layui-badge layui-bg-green readSpan">0</span></li>
                <li>全部公告<span class="layui-badge layui-bg-blue allreadSpan">0</span></li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <button class="layui-btn   allreadUserInfoBtn"><i class="layui-icon larry-icon larry-fabu"></i>已读</button>
                    <!-- 未读公告列表 -->
                    <table id="unReadAnnInfoTableList" lay-filter="unReadAnnInfoTableId"></table>
                </div>
                <div class="layui-tab-item">
                    <!-- 已读公告列表 -->
                    <table id="readAnnInfoTableList" lay-filter="readAnnInfoTableId"></table>
                </div>
                <div class="layui-tab-item">
                    <!-- 全部公告列表 -->
                    <table id="allReadAnnInfoTableList" lay-filter="allReadAnnInfoTableId"></table>

                </div>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    var $,table,common;
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form', 'table','common','element'], function () {
        $ =  layui.$;
        table = layui.table;
        common = layui.common;
       var  form = layui.form,
        element = layui.element


        //未读公告
        unReadAnnInfo();
        //已读公告
        readAnnInfo();
        //全部公告
        allreadAnnInfo();

        //默认加载未读公告
        unReadAnnInfoTable();
        /**tab监听*/
        element.on('tab(filterAnnInfoTab)', function(data){
            if(data.index == 0){
                unReadAnnInfoTable();   // 未读公告
            }else if(data.index == 1){
                readAnnInfoTable(); //已读公告table
            }else if(data.index == 2){
                allReadAnnInfoTable(); //全部公告table
            }

        });

        /**全部标记为已读*/
        $(".allreadUserInfoBtn").click(function(){

            //表格行操作
            var checkStatus = table.checkStatus('unReadAnnInfoTableId');

            if(checkStatus.data.length == 0){
                common.cmsLayErrorMsg("请选择未读公告信息");
            }else{
                var announcementIds = [];
                $(checkStatus.data).each(function(index,item){
                    announcementIds.push(item.announcementId);

                });
                var url = "${ctx}/announcement/ajax_ins_allread_anninfo_user.do";
                var param = {announcementIds:announcementIds};
                common.ajaxCmsConfirm('系统提示', '是否将选中的未读公告标记为已读?',url,param);
            }
        });

        /**监听未读公告工具条*/
        table.on('tool(unReadAnnInfoTableId)', function(obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值

            //公告详情
            if(layEvent === 'announcement_detail') {
                var announcementId = data.announcementId;
                var url =  "${ctx}/announcement/announcement_detail.do?announcementId="+announcementId;
                common.cmsLayOpenTip('公告详情',url,'100%','100%');
            //已读
            }else if(layEvent === 'announcement_read') {
                var announcementId = data.announcementId;
                var url = "${ctx}/announcement/ajax_ins_read_anninfo_user.do";
                var param = {announcementId:announcementId};
                common.ajaxCmsConfirm('系统提示', '是否将当前公告标记为已读?',url,param);




            }
        });

        /**监听已读公告工具条*/
        table.on('tool(readAnnInfoTableId)', function(obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值

            //公告详情
            if(layEvent === 'announcement_detail') {
                var announcementId = data.announcementId;
                var url =  "${ctx}/announcement/announcement_detail.do?announcementId="+announcementId;
                common.cmsLayOpenTip('公告详情',url,'100%','100%');

            }
        });
        /**监听全部公告工具条*/
        table.on('tool(allReadAnnInfoTableId)', function(obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值

            //公告详情
            if(layEvent === 'announcement_detail') {
                var announcementId = data.announcementId;
                var url =  "${ctx}/announcement/announcement_detail.do?announcementId="+announcementId;
                common.cmsLayOpenTip('公告详情',url,'100%','100%');



            }
        });


    });

    /**加载未读公告数*/
    function unReadAnnInfo() {
        $.post("${ctx}/announcement/ajax_unread_anninfo_count.do", function(data) {
            $(".unreadSpan").text(data);
        });
    }
    /**查询已读公告数*/
    function readAnnInfo() {
        $.post("${ctx}/announcement/ajax_read_anninfo_count.do", function(data) {
            $(".readSpan").text(data);
        });
    }
    /**查询全部公告数*/
    function allreadAnnInfo() {
        $.post("${ctx}/announcement/ajax_allread_anninfo_count.do", function(data) {
            $(".allreadSpan").text(data);
        });

    }
    /**加载未读公告Table*/
    function unReadAnnInfoTable() {
        var loading = layer.load(0,{ shade: [0.3,'#000']});

        table.render({
            elem: '#unReadAnnInfoTableList',
            url: '${ctx}/announcement/ajax_unread_anninfo_list.do',
            id:'unReadAnnInfoTableId',
            method: 'post',
            height:'full-125',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers"},
                {type:"checkbox"},
                {field:'announcementTitle', title: '公告标题',align:'center'},
                {field:'announcementType', title: '公告类型',align:'center',templet: '#announcementTypeTpl'},
                {field:'announcementAuthor', title: '发布人',align:'center'},
                {field:'announcementTime', title: '发布时间',align:'center',width: '12%'},
                {fixed:'right', title: '操作', align:'center',width: '17%', toolbar: '#unReadannouncementBar'}

            ]],
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });

    }
    /**加载已读公告Table*/
    function readAnnInfoTable() {
        var loading = layer.load(0,{ shade: [0.3,'#000']});

        table.render({
            elem: '#readAnnInfoTableList',
            url: '${ctx}/announcement/ajax_read_anninfo_list.do',
            id:'allReadAnnInfoTableId',
            method: 'post',
            height:'full-120',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers"},
                {field:'announcementTitle', title: '公告标题',align:'center'},
                {field:'announcementType', title: '公告类型',align:'center',templet: '#announcementTypeTpl'},
                {field:'announcementAuthor', title: '发布人',align:'center'},
                {field:'announcementTime', title: '发布时间',align:'center',width: '12%'},
                {fixed:'right', title: '操作', align:'center',width: '17%', toolbar: '#announcementBar'}

            ]],
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });

    }

    /**加载全部公告Table*/
    function allReadAnnInfoTable() {
        var loading = layer.load(0,{ shade: [0.3,'#000']});
        table.render({
            elem: '#allReadAnnInfoTableList',
            url: '${ctx}/announcement/ajax_allread_anninfo_list.do',
            id:'allReadAnnInfoTableId',
            method: 'post',
            height:'full-120',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers"},
                {field:'announcementTitle', title: '公告标题',align:'center'},
                {field:'announcementType', title: '公告类型',align:'center',templet: '#announcementTypeTpl'},
                {field:'announcementAuthor', title: '发布人',align:'center'},
                {field:'announcementTime', title: '发布时间',align:'center',width: '12%'},
                {fixed:'right', title: '操作', align:'center',width: '17%', toolbar: '#announcementBar'}

            ]],
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });
        
    }
</script>
<!-- 公告类型tpl-->
<script type="text/html" id="announcementTypeTpl">

    {{# if(d.announcementType == 1){ }}
    <span class="label label-info ">1-系统公告</span>
    {{# } else if(d.announcementType == 2){ }}
    <span class="label label-info ">2-活动公告</span>
    {{# } else { }}
    {{d.announcementType}}
    {{# }  }}
</script>


<!--未读Table工具条 -->
<script type="text/html" id="unReadannouncementBar">
    <div class="layui-btn-group">
            <a class="layui-btn  layui-btn-normal  announcement_detail" lay-event="announcement_detail"><i class="layui-icon larry-icon larry-chaxun2"></i>详情</a>
            <a class="layui-btn  announcement_read" lay-event="announcement_read"><i class="layui-icon larry-icon larry-fabu"></i>已读</a>
    </div>
</script>

<!--工具条 -->
<script type="text/html" id="announcementBar">
    <div class="layui-btn-group">
        <a class="layui-btn  layui-btn-normal  announcement_detail" lay-event="announcement_detail"><i class="layui-icon larry-icon larry-chaxun2"></i>详情</a>
    </div>
</script>



</body>
</html>