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
    <script src="${ctx}/static/layui_v2/layui.js"></script>
    <script src="${ctx}/static/layui_v2/layui.js"></script>

</head>
<body class="childrenBody" style="font-size: 12px;margin: 10px 10px 0;">
<form class="layui-form layui-form-pane" style="text-align: center">

    <input type="hidden" class="layui-input" id="id" name="id" value="${id}">
    <div class="layui-form-item" >
       <div class="layui-inline">
           <label class="layui-form-label">进货数量</label>
           <div class="layui-input-block">
               <input type="text" class="layui-input" name="the_size"  autocomplete="off" lay-verify="required|the_size" maxlength="50"  placeholder="请输入进货数量">
           </div>
       </div>
    </div>
    <div class="layui-form-item" style="text-align: center;">
            <button class="layui-btn" lay-submit="" lay-filter="saveemployee">保存</button>
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


        form.verify({
            the_size: function (value) {
                if (!new RegExp("^[0-9]+$").test(value)) {
                    return '进货数量必须为数字';
                }
            },
        });
        /**保存信息**/
        form.on("submit(saveemployee)",function(data){

            var loading = layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
            $.ajax({
                url : '${ctx}/instoack/in_stack.do',
                type : 'post',
                async: false,
                data : {
                    id:data.field.id,
                    the_size:data.field.the_size
                },
                success : function(data) {
                    if(data.returnCode == "0000"){
                        layer.close(loading);
                        common.cmsLaySucMsg("保存成功！");
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