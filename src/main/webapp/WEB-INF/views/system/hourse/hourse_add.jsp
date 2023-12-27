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
            <label class="layui-form-label">商品照片</label>
            <div class="layui-upload" >
                <div class="layui-upload-list">
                    <img class="layui-upload-img" id="test1" width="80px" height="80px" style="cursor: pointer">
                    <p id="demoText"></p>
                </div>
            </div>
            <div class="layui-inline" style="display: none">
                <label class="layui-form-label">图片</label>
                <div class="layui-input-block">
                    <input type="text" name="photo" id="photo" lay-verify="photo"  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
    </div>
    <div class="layui-form-item" >
       <div class="layui-inline">
           <label class="layui-form-label">商品名称</label>
           <div class="layui-input-block">
               <input type="text" class="layui-input" name="name"  autocomplete="off" lay-verify="required" maxlength="50"  placeholder="请输入商品名称">
           </div>
       </div>
    </div>
    <div class="layui-form-item" >
        <div class="layui-inline">
            <label class="layui-form-label">价格</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="price"  autocomplete="off" lay-verify="required|age" maxlength="50"  placeholder="请输入价格">
            </div>
        </div>
    </div>
    <div class="layui-form-item" >
        <div class="layui-inline">
            <label class="layui-form-label">关键词</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="type_name"  autocomplete="off" lay-verify="required" maxlength="50"  placeholder="请输入关键词">
            </div>
        </div>
    </div>
    <div class="layui-form-item" style="display: none">
        <div class="layui-inline">
            <label class="layui-form-label">商品大小</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="the_size"  value="0">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">类型</label>
            <div class="layui-input-block">
                <select lay-verify="required" name="type_id">
                    <option value="">请选择</option>
                   <c:forEach items="${commonCodes}" var="code">
                       <option value="${code.id}">${code.name}</option>
                   </c:forEach>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">标签</label>
            <div class="layui-input-block">
                <input type="checkbox" name="welfare" value="新品" lay-skin="primary"  title="新品">
                <input type="checkbox" name="welfare" value="热销" lay-skin="primary" title="热销">
                <input type="checkbox" name="welfare" value="促销" lay-skin="primary" title="促销">
                <input type="checkbox" name="welfare" value="热卖" lay-skin="primary" title="热卖">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <label class="layui-form-label">描述</label>
            <div class="layui-input-block">
                <textarea id="announcementContentEdit" style="display: none;" ></textarea>
            </div>
        </div>
    </div>

    <div class="layui-form-item" style="text-align: center;">
            <button class="layui-btn" lay-submit="" lay-filter="savehourse">保存</button>
            <button type="reset" class="layui-btn layui-btn-warm">重置</button>
            <button type="layui-btn" id="cancle" class="layui-btn layui-btn-normal">取消</button>
    </div>
</form>
<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form','layer','jquery','common','layedit','laydate','upload'],function(){
        var $ = layui.$,
                form = layui.form,
                upload = layui.upload,
                common = layui.common,
                layedit = layui.layedit,
                laydate = layui.laydate,
                layer = parent.layer === undefined ? layui.layer : parent.layer;

        /**建立编辑器*/
        var index = layedit.build('announcementContentEdit',{
            height: 120, //设置编辑器高度
            tool: ['strong', 'italic', 'underline', 'del','|','left','center','right','|','link','unlink','face']

        });

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1',
            method:"post",
            url: '${pageContext.request.contextPath}/hourse/uploadHeadImage',
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
                    $('#photo').val(res.data);
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
            age: function(value, item){
                if(!new RegExp("^[0-9]+$").test(value)){
                    return '必须是数字';
                }
            },
            photo:function(value){
                var photo=$('#photo').val();
                if(photo==""){
                    return '图片不能为空';
                }
            },
        });
        /**保存信息**/
        form.on("submit(savehourse)",function(data){
            if($.trim(layedit.getText(index)).length <= 0){
                common.cmsLayErrorMsg("请输入商品描述")
                return false;
            }

            //获取checkbox[name='like']的值
            var arr = new Array();
            $("input:checkbox[name='welfare']:checked").each(function(i){
                arr[i] = $(this).val();
            });
            data.field.welfare = arr.join(",");

            var loading = layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});

            $.ajax({
                url : '${ctx}/hourse/ajax_save_hourse.do',
                type : 'post',
                async: false,
                data : {
                    name:data.field.name,
                    type_id:data.field.type_id,
                    photo:data.field.photo,
                    price:data.field.price,
                    the_size:data.field.the_size,
                    info:layedit.getText(index),
                    welfare:data.field.welfare,
                    type_name:data.field.type_name
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