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
    <input type="hidden" class="layui-input" name="id" value="${commonCode.id}">
    <div class="layui-form-item" >
        <div class="layui-inline">
            <label class="layui-form-label">编码</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="code" value="${commonCode.code}" autocomplete="off" lay-verify="required" maxlength="50"  placeholder="请输入编码">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">名称</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="name" value="${commonCode.name}" autocomplete="off" lay-verify="required" maxlength="50"  placeholder="请输入名称">
            </div>
        </div>
    </div>

    <div class="layui-form-item" style="text-align: center;">
        <button class="layui-btn" lay-submit="" lay-filter="saveCommonCode">保存</button>
        <button type="layui-btn" id="cancle" class="layui-btn layui-btn-primary">取消</button>
    </div>
</form>
<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form','layer','jquery','common','layedit','laydate'],function(){
        var $ = layui.$,
            form = layui.form,
            common = layui.common,
            layedit = layui.layedit,
            laydate = layui.laydate,
            layer = parent.layer === undefined ? layui.layer : parent.layer;


        /**保存信息**/
        form.on("submit(saveCommonCode)",function(data){

            var loading = layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
            $.ajax({
                url : '${ctx}/commonCode/ajax_update_commonCode.do',
                type : 'post',
                async: false,
                data : {
                    id:data.field.id,
                    code:data.field.code,
                    name:data.field.name
                },
                success : function(data) {
                    if(data.returnCode == "0000"){
                        layer.close(loading);
                        common.cmsLaySucMsg("修改成功！");
                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                        parent.layer.close(index); //再执行关闭                        //刷新父页面
                        parent.location.reload();
                    }else{
                        layer.close(loading);
                        common.cmsLayErrorMsg(data.returnMessage);
                    }
                },error:function(data){
                    layer.close(index);

                }
            });
            return false;
        });
        /**取消*/
        $("#cancle").click(function(){
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
        });
    });

</script>
</body>
</html>