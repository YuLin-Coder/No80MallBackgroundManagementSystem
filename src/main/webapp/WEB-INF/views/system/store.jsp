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
    <script src="${ctx}/static/layui_v2/layui.js"></script>


</head>
<body class="childrenBody" style="font-size: 12px;margin: 10px 10px 0;">
<form class="layui-form layui-form-pane" style="text-align: center">
    <input type="hidden" name="type_name" value="${type_name}">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">资质</label>
            <div class="layui-upload" >
                <div class="layui-upload-list">
                    <img class="layui-upload-img"  src="/upload/${store.qualification}" width="80px" height="80px" style="cursor: pointer">
                </div>
            </div>

        </div>
        <div class="layui-inline">
            <label class="layui-form-label">店铺logo</label>
            <div class="layui-upload" >
                <div class="layui-upload-list">
                    <img class="layui-upload-img"  src="/upload/${store.log_photo}" width="80px" height="80px" style="cursor: pointer">
                </div>
            </div>

        </div>
    </div>

    <div class="layui-form-item" >
        <div class="layui-inline">
            <label class="layui-form-label">电话</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="phone" readonly  value="${store.phone}"  >
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">店铺名称</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="store_name"  readonly  value="${store.store_name}"  >
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <label class="layui-form-label">店铺地址</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="address" readonly  value="${store.address}" >
            </div>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center;">
        <button type="layui-btn" id="cancle" class="layui-btn layui-btn-normal">取消</button>
    </div>
</form>
<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form','layer','jquery','common','upload'],function(){
        var $ = layui.$,
            form = layui.form,
            upload = layui.upload,
            common = layui.common,
            layer = parent.layer === undefined ? layui.layer : parent.layer;

        /**取消*/
        $("#cancle").click(function(){
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
        });
    });

</script>
</body>
</html>