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
<div class="larry-grid layui-anim layui-anim-upbit larryTheme-A" >
    <div class="larry-personal" >
        <div class="layui-tab" >
            <blockquote class="layui-elem-quote mylog-info-tit">
                <div class="layui-inline">
                    <form class="layui-form" id="resSearchForm">

                        <div class="layui-input-inline" style="width:110px;">
                            <select name="searchTerm" >
                                <option value="resNameTerm">菜单名称</option>
                                <option value="parentNameTerm">父级菜单</option>
                                <option value="resTypeTerm">菜单类型</option>
                                <option value="resLevelTerm">菜单级别</option>
                            </select>
                        </div>
                        <div class="layui-input-inline" style="width:145px;">
                            <input type="text" name="searchContent" value="" placeholder="请输入关键字" class="layui-input search_input">
                        </div>
                        <a class="layui-btn resSearchList_btn" lay-submit lay-filter="resSearchFilter"><i class="layui-icon larry-icon larry-chaxun7"></i>查询</a>
                    </form>
                </div>
                <shiro:hasPermission name="Mhtly5er">
                    <div class="layui-inline">
                        <a class="layui-btn layui-btn-normal  resAdd_btn"> <i class="layui-icon larry-icon larry-xinzeng1"></i>新增菜单</a>
                    </div>
                </shiro:hasPermission>
                <shiro:hasPermission name="wPUNDGgZ">
                    <div class="layui-inline">
                        <a class="layui-btn layui-btn-normal excelResExport_btn"  style="background-color:#5FB878"> <i class="layui-icon larry-icon larry-danye"></i>导出</a>
                    </div>
                </shiro:hasPermission>

            </blockquote>
            <div class="larry-separate"></div>
            <!-- 菜单列表 -->
            <div class="layui-tab-item layui-show" style="padding: 10px 15px;">
                <table id="resTableList" lay-filter="resTableId"></table>

            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form', 'table', 'layer','common'], function () {
        var $ = layui.$,
                form = layui.form,
                table = layui.table,
                layer = layui.layer,
                common = layui.common;

        var loading = layer.load(0,{ shade: [0.3,'#000']});

        /**用户表格加载*/
         table.render({
            elem: '#resTableList',
            url: '${ctx}/res/ajax_res_list.do',
            id:'resTableId',
            method: 'post',
            height:'full-140',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers"},
                {type:"checkbox"},
                {field:'resName', title: '菜单名称',align:'center'},
                {field:'resModelCode', title: '菜单编码',align:'center'},
                {field:'resStatus', title: '菜单状态',align:'center',width: '6%',templet: '#resStatusTpl'},
                {field:'resLinkAddress', title: '菜单路径',align:'center'},
                {field:'resType', title: '菜单类型',align:'center',templet: '#resTypeTpl'},
                {field:'resLevel', title: '菜单级别',align:'center',templet: '#resLevelTpl'},
                {field:'parentname', title: '上级菜单',align:'center'},
                {field:'createTime', title: '创建时间',align:'center',width: '10%'},
                {field:'modifyTime', title: '修改时间',align:'center',width: '10%'},
                {title: '操作', align:'center',width: '17%', toolbar: '#resBar'}

            ]],
            page: true,
             done: function (res, curr, count) {
                 common.resizeGrid();
                 layer.close(loading);

             }
        });

        /**查询*/
        $(".resSearchList_btn").click(function(){
            var loading = layer.load(0,{ shade: [0.3,'#000']});
            //监听提交
            form.on('submit(resSearchFilter)', function (data) {
                table.reload('resTableId',{
                    where: {
                        searchTerm:data.field.searchTerm,
                        searchContent:data.field.searchContent
                    },
                    height:'full-140',
                    page: true,
                    done: function (res, curr, count) {
                        common.resizeGrid();
                        layer.close(loading);

                    }
                });

            });

        });


        /**新增菜单*/
        $(".resAdd_btn").click(function(){
            var url = "${ctx}/res/res_edit.do";
            common.cmsLayOpen('新增菜单',url,'750px','470px');
        });

        /**监听工具条*/
        table.on('tool(resTableId)', function(obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值

            //编辑菜单
            if(layEvent === 'res_edit') {

                var resId = data.resId;
                var url =  "${ctx}/res/res_update.do?resId="+resId;
                common.cmsLayOpen('编辑菜单',url,'750px','470px');
            //失效菜单
            }else if(layEvent === 'res_fail'){

            }



        });

    });

</script>
<!-- 菜单状态tpl-->
<script type="text/html" id="resStatusTpl">

    {{# if(d.resStatus == 0){ }}
    <span class="label label-success ">0-有效</span>
    {{# } else if(d.resStatus == 1){ }}
    <span class="label label-danger ">1-失效</span>
    {{# } else { }}
    {{d.resStatus}}
    {{# }  }}
</script>
<!-- 菜单类型tpl-->
<script type="text/html" id="resTypeTpl">

    {{# if(d.resType == 0){ }}
    <span class="label label-info ">0-菜单</span>
    {{# } else if(d.resType == 1){ }}
    <span class="label label-warning ">1-按钮</span>
    {{# } else { }}
    {{d.resType}}
    {{# }  }}
</script>

<!-- 菜单级别tpl-->
<script type="text/html" id="resLevelTpl">

    {{# if(d.resLevel == 1){ }}
    <span>1级菜单</span>
    {{# } else if(d.resLevel == 2){ }}
    <span>2级菜单</span>
    {{# } else if(d.resLevel == 3){ }}
    <span>3级菜单</span>
    {{# } else { }}
    {{d.resLevel}}
    {{# }  }}
</script>

<!--工具条 -->
<script type="text/html" id="resBar">
    <div class="layui-btn-group">
        <shiro:hasPermission name="KxCQVzRq">
            <a class="layui-btn  res_edit" lay-event="res_edit"><i class="layui-icon larry-icon larry-bianji2"></i> 编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="DK3uPfe7">
            <a class="layui-btn  layui-btn-danger res_fail" lay-event="res_fail"><i class="layui-icon larry-icon larry-ttpodicon"></i>失效</a>
        </shiro:hasPermission>
    </div>
</script>

</body>
</html>