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


    <script src="${ctx}/static/layui_v2/layui.js"></script>
    <script src="${ctx}/static/layui_v2/layui.js"></script>
    <script src="${ctx}/static/layui_v2/layui.js"></script>

</head>
<body class="childrenBody" style="font-size: 12px;margin: 10px 10px 0;">
<form class="layui-form layui-form-pane">

    <div class="layui-form-item">
        <label class="layui-form-label">公告标题</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="announcementTitle" lay-verify="required" maxlength="50"  placeholder="请输入公告标题">
        </div>
    </div>
    <div class="layui-form-item" >
        <label class="layui-form-label">公告类型</label>
        <div class="layui-input-block">
            <select  name="announcementType" lay-verify="required">
                <option value="">请选择</option>
                <option value="1">1-系统公告</option>
                <option value="2">2-活动公告</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">公告内容</label>
        <div class="layui-input-block">
            <textarea id="announcementContentEdit" style="display: none;" ></textarea>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center;">
            <button class="layui-btn" lay-submit="" lay-filter="saveAnnouncement">保存</button>
            <button type="layui-btn" id="cancle" class="layui-btn layui-btn-primary">取消</button>

    </div>
</form>
<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form','layer','jquery','common','layedit'],function(){
        var $ = layui.$,
                form = layui.form,
                common = layui.common,
                layedit = layui.layedit,
                layer = parent.layer === undefined ? layui.layer : parent.layer;

        /**建立编辑器*/
        var index = layedit.build('announcementContentEdit',{
            height: 120, //设置编辑器高度
            tool: ['strong', 'italic', 'underline', 'del','|','left','center','right','|','link','unlink','face']

        });


        /**保存公告信息**/
        form.on("submit(saveAnnouncement)",function(data){
            if($.trim(layedit.getText(index)).length <= 0){
                common.cmsLayErrorMsg("请输入公告内容")
                return false;
            }
            if(layedit.getContent(index).length >500){
                common.cmsLayErrorMsg("公告内容长度超出限制,当前长度:"+layedit.getContent(index).length+",最大长度:500")
                return false;
            }
            var loading = layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
            $.ajax({
                url : '${ctx}/announcement/ajax_save_announcement.do',
                type : 'post',
                async: false,
                data : {
                    announcementType:data.field.announcementType,
                    announcementTitle:data.field.announcementTitle,
                    announcementContent:layedit.getContent(index)
                },
                success : function(data) {
                    if(data.returnCode == 0000){
                        layer.close(loading);
                        common.cmsLaySucMsg("公告信息保存成功！");
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