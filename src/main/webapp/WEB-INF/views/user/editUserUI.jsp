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
    <link rel="stylesheet" href="${ctx}/static/layui/css/layui.css">
    <script src="${ctx}/static/layui/layui.js"></script>


</head>
<body class="childrenBody" style="font-size: 12px;margin: 10px 10px 0;">
<form class="layui-form layui-form-pane" style="text-align: center">
    <input type="hidden" value="${order_no}" name="order_no" id="order_no">
    <div class="layui-form-item" >
       <div class="layui-inline">
           <label class="layui-form-label">姓名</label>
           <div class="layui-input-block">
               <input type="text" name="userName" lay-verify="required"
                      placeholder="请输入姓名" autocomplete="off" value="${sessionScope.loginUser.userName}" class="layui-input">
           </div>
       </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block">
                <input type="password" name="userPassword" lay-verify="required"
                       placeholder="请输入密码" autocomplete="off" value="${sessionScope.loginUser.userPassword}" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center;">
            <button class="layui-btn" lay-submit="" lay-filter="saveUser">保存</button>
            <button type="layui-btn" id="cancle" class="layui-btn layui-btn-normal">取消</button>
    </div>
</form>
<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form','layer','jquery','common','rate'],function(){
        var $ = layui.$,
                form = layui.form,
                common = layui.common,
                rate = layui.rate,
                layer = parent.layer === undefined ? layui.layer : parent.layer;

        rate.render({
            elem: '#star'
            ,value: 2 //初始值
            ,theme: '#FFB800'
            ,text: true //开启文本
        });

        /**保存信息**/
        form.on("submit(saveUser)",function(data){

            var loading = layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
            $.ajax({
                url : '${ctx}/user/update_user.do',
                type : 'post',
                data : {
                    userName:data.field.userName,
                    userPassword:data.field.userPassword
                },
                success : function(data) {
                    if(data.returnCode == "0000"){
                        layer.close(loading);
                        layer.msg('保存成功！',{icon:5});
                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                        parent.layer.close(index); //再执行关闭                        //刷新父页面
                        parent.location.reload();
                    }else{
                        layer.close(loading);
                        layer.msg(data.returnMessage,{icon:5});
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