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
    <input type="hidden" class="layui-input" name="user_code"  value="${user_code}">
    <div class="layui-form-item" >
       <div class="layui-inline">
           <label class="layui-form-label">发放时间</label>
           <div class="layui-input-block">
               <input type="text" class="layui-input" name="able_time" id="able_time" autocomplete="off" lay-verify="required" maxlength="50"  placeholder="请选择发放时间">
           </div>
       </div>
        <div class="layui-inline">
            <label class="layui-form-label">应发工资</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="should_salary"  id="should_salary" autocomplete="off" lay-verify="required|age" maxlength="50"  placeholder="请输入应发工资">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">实发工资</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="real_salary" id="real_salary"  autocomplete="off" lay-verify="required|age" maxlength="50"  placeholder="请输入实发工资">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">扣除工资</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="deduct_salry" id="deduct_salry"  autocomplete="off" lay-verify="required|age" maxlength="50"  placeholder="请输入扣除工资">
            </div>
        </div>
    </div>
    <div style="font-size: 12px;color: red;margin-bottom: 10px">注:应发工资=实发工资+扣除工资</div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">备注</label>
            <div class="layui-input-block">
                <textarea type="text" class="layui-textarea" cols="66" name="remark"   lay-verify="required" maxlength="200"
                          placeholder="请输入备注"></textarea>
            </div>
        </div>
    </div>

    <div class="layui-form-item" style="text-align: center;">
            <button class="layui-btn" lay-submit="" lay-filter="savesalary">保存</button>
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

        var date=new Date();
        var max=date.getFullYear()+"-"+date.getMonth();
        laydate.render({
            elem : "#able_time",
            format : 'yyyy-MM',
            type : 'month',
            max:max
        });

        form.verify({
            age: function(value, item){
                if(!new RegExp("^[0-9]+$").test(value)){
                    return '必须是数字';
                }
            },
        });
        /**保存信息**/
        form.on("submit(savesalary)",function(data){
           var deduct_salry= $('#deduct_salry').val();
           var real_salary=$('#real_salary').val();
           var should_salary=$('#should_salary').val();
           if(parseInt(should_salary)!=(parseInt(real_salary)+parseInt(deduct_salry))){
               common.cmsLayErrorMsg("应发工资不等于实发工资+扣除工资");
               return false;
           }

            var loading = layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
            $.ajax({
                url : '${ctx}/salary/ajax_save_salary.do',
                type : 'post',
                async: false,
                data : {
                    user_code:data.field.user_code,
                    able_time:data.field.able_time,
                    should_salary:data.field.should_salary,
                    real_salary:data.field.real_salary,
                    deduct_salry:data.field.deduct_salry,
                    remark:data.field.remark
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