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
        <div class="layui-tab">
            <blockquote class="layui-elem-quote mylog-info-tit">
                <div class="layui-form-item" style="margin-bottom:auto;">

                    <div class="layui-inline" style="margin-bottom:auto;margin-left: auto;">
                        <form class="layui-form" id="userSearchForm">
                            <label class="layui-form-label" style="width:auto;">发布时间</label>

                            <div class="layui-input-inline" style="width:145px;">
                                <input type="text" class="layui-input" id="beginTime" name="beginTime" placeholder="请选择"  readonly>

                            </div>
                            <div class="layui-form-mid">-</div>
                            <div class="layui-input-inline" style="width:145px;">
                                <input type="text" class="layui-input" id="endTime" name="endTime" placeholder="请选择" readonly>
                            </div>

                            <a class="layui-btn announcementSearchList_btn" lay-submit lay-filter="announcementSearchFilter"><i class="layui-icon larry-icon larry-chaxun7"></i>查询</a>
                        </form>
                    </div>
                    <shiro:hasPermission name="4JQVLmOd">
                        <div class="layui-inline" style="margin-bottom:auto;margin-left: auto;">
                            <a class="layui-btn layui-btn-normal announcementAdd_btn"> <i class="layui-icon larry-icon larry-xinzeng1"></i>新增公告</a>
                        </div>
                    </shiro:hasPermission>
                </div>


            </blockquote>
            <div class="larry-separate"></div>
            <!-- 公告列表 -->
            <div class="layui-tab-item layui-show" style="padding: 10px 15px;">
                <table id="announcementTableList"  lay-filter="announcementTableId"></table>
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

        /**公告表格加载*/
        table.render({
            elem: '#announcementTableList',
            url: '${ctx}/announcement/ajax_announcement_list.do',
            id:'announcementTableId',
            method: 'post',
            height:'full-140',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers"},
                {field:'announcementTitle', title: '公告标题',align:'center' },
                {field:'announcementType', title: '公告类型',align:'center',templet: '#announcementTypeTpl'},
                {field:'announcementAuthor', title: '发布人',align:'center'},
                {field:'announcementTime', title: '发布时间',align:'center'},
                {title: '操作', align:'center',width: '17%', toolbar: '#announcementBar'}

            ]],
            page: true,
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });

        /**查询*/
        $(".announcementSearchList_btn").click(function(){
            var loading = layer.load(0,{ shade: [0.3,'#000']});
            //监听提交
            form.on('submit(announcementSearchFilter)', function (data) {
                table.reload('announcementTableId',{
                    where: {
                        beginTime:data.field.beginTime,
                        endTime:data.field.endTime
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

        /**开始日期*/
        laydate.render({
            elem: '#beginTime',
            theme: 'molv'
        });
        /**结束日期*/
        laydate.render({
            elem: '#endTime',
            theme: 'molv'
        });


        /**新增公告*/
        $(".announcementAdd_btn").click(function(){
            var url = "${ctx}/announcement/announcement_add.do";
            common.cmsLayOpen('新增公告',url,'890px','480px');
        });



        /**监听工具条*/
        table.on('tool(announcementTableId)', function(obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值

            //公告详情
            if(layEvent === 'announcement_detail') {
                var announcementId = data.announcementId;
                var url =  "${ctx}/announcement/announcement_detail.do?announcementId="+announcementId;
                common.cmsLayOpenTip('公告详情',url,'100%','100%');

             //公告删除
            }else if(layEvent === 'announcement_delete') {
                var announcementId = data.announcementId;
                var url = "${ctx}/announcement/ajax_del_announcement.do";
                var param = {announcementId:announcementId};
                common.ajaxCmsConfirm('系统提示', '确定要删除当前公告吗?',url,param);

            }
        });


    });
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


<!--工具条 -->
<script type="text/html" id="announcementBar">
    <div class="layui-btn-group">
        <a class="layui-btn  layui-btn-normal" lay-event="announcement_detail"><i class="layui-icon larry-icon larry-chaxun2"></i>详情</a>
        <shiro:hasPermission name="eTDnjGAM">
            <a class="layui-btn  layui-btn-danger" lay-event="announcement_delete"><i class="layui-icon larry-icon larry-ttpodicon"></i>删除</a>
        </shiro:hasPermission>
    </div>
</script>



</body>
</html>