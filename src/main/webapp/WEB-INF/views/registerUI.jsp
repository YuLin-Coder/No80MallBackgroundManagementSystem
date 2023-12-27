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
                    <img class="layui-upload-img" id="test1" width="80px" height="80px" style="cursor: pointer">
                </div>
            </div>
            <div class="layui-inline" style="display: none">
                <label class="layui-form-label">图片</label>
                <div class="layui-input-block">
                    <input type="text" name="qualification" id="qualification" lay-verify="qualification"  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">店铺logo</label>
            <div class="layui-upload" >
                <div class="layui-upload-list">
                    <img class="layui-upload-img" id="test2" width="80px" height="80px" style="cursor: pointer">
                </div>
            </div>
            <div class="layui-inline" style="display: none">
                <label class="layui-form-label">图片</label>
                <div class="layui-input-block">
                    <input type="text" name="logo_photo" id="logo_photo" lay-verify="logo_photo"  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
    </div>

    <div class="layui-form-item" >
       <div class="layui-inline">
           <label class="layui-form-label">用户名</label>
           <div class="layui-input-block">
               <input type="text" class="layui-input" name="name"  autocomplete="off" lay-verify="required" maxlength="50"  placeholder="请输入姓名">
           </div>
       </div>
        <div class="layui-inline">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="password"  autocomplete="off" lay-verify="required" maxlength="50"  placeholder="请输入密码">
            </div>
        </div>
    </div>
    <div class="layui-form-item" >
        <div class="layui-inline">
            <label class="layui-form-label">电话</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="phone"  autocomplete="off" lay-verify="phone" maxlength="50"  placeholder="请输入电话">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">店铺名称</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="store_name"  autocomplete="off" lay-verify="required" maxlength="50"  placeholder="请输入店铺名称">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <label class="layui-form-label">店铺地址</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="address" placeholder="请输入店铺地址" autocomplete="off"  lay-verify="required">
            </div>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center;">
            <button class="layui-btn" lay-submit="" lay-filter="saveStore">保存</button>
            <button type="reset" class="layui-btn layui-btn-warm">重置</button>
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

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1',
            method:"post",
            url: '${pageContext.request.contextPath}/hourse/uploadHeadImage.do',
            before: function(obj){
                obj.preview(function(index, file, result){
                    $('#test1').attr('src', result);
                });
            },
            done: function(res){
                //如果上传失败
                if(res.code!="200"){
                    return  layer.msg("上传失败", {icon: 5});
                }else{
                    $('#qualification').val(res.data);
                    return  layer.msg("上传成功", {icon: 1});
                }
                //上传成功
            }
            ,error: function(){
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            }
        });

        var uploadInst = upload.render({
            elem: '#test2',
            method:"post",
            url: '${pageContext.request.contextPath}/hourse/uploadHeadImage.do',
            before: function(obj){
                obj.preview(function(index, file, result){
                    $('#test2').attr('src', result);
                });
            },
            done: function(res){
                //如果上传失败
                if(res.code!="200"){
                    return  layer.msg("上传失败", {icon: 5});
                }else{
                    $('#logo_photo').val(res.data);
                    return  layer.msg("上传成功", {icon: 1});
                }
                //上传成功
            }
            ,error: function(){
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            }
        });

        form.verify({
            qualification:function(value){
                var qualification=$('#qualification').val();
                if(qualification==""){
                    return '资质图片不能为空';
                }
            },
            logo_photo:function(value){
                var logo_photo=$('#logo_photo').val();
                if(logo_photo==""){
                    return 'logo图片不能为空';
                }
            },
        });
        /**保存信息**/
        form.on("submit(saveStore)",function(data){

            $.ajax({
                url : '${ctx}/register.do',
                type : 'post',
                async: false,
                data : {
                    name:data.field.name,
                    qualification:data.field.qualification,
                    log_photo:data.field.logo_photo,
                    store_name:data.field.store_name,
                    address:data.field.address,
                    phone:data.field.phone,
                    password:data.field.password
                },
                success : function(data) {
                    if(data.returnCode == "0000"){
                        common.cmsLaySucMsg("保存成功！");
                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                        parent.layer.close(index); //再执行关闭                        //刷新父页面
                        parent.location.reload();
                    }else{
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