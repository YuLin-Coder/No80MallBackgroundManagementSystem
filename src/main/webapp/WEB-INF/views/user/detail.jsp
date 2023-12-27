<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <link rel="stylesheet" href="${ctx}/static/css/global.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/personal.css" media="all">
    <script src="${ctx}/static/layui_v2/layui.js"></script>
    <style>
        .item_icon{
            font-size: 16px;padding:30px 30px 30px 0px;
        }
        .item_icon div{
            height: 45px;
        }
    </style>
</head>
<body>

    <jsp:include page="${ctx}/user/header.do"></jsp:include>
    <div class="layui-container" >
        <div class="layui-row layui-col-md12" style="text-align: center">
            <img src="/upload/${store.log_photo}" width="30px" height="30px" onclick="show_img(this)" >
           <span style="font-size: 14px"> 电话:${store.phone}  地址:${store.address}</span>
        </div>
        <div class="layui-row layui-col-md12">
            <div class="layui-col-md6">
                <div class="layui-panel">
                    <div style="padding:30px 30px 30px 0px;">
                        <img width="350" height="350" src="${ctx}/upload/${hourse.photo}">
                    </div>
                </div>
            </div>
            <div class="layui-col-md6">
                <div class="layui-panel">
                    <div class="item_icon">
                        <div>名称:<span style="margin-left: 10px">${hourse.name}</span></div>
                        <div>价格:<span style="margin-left: 10px">${hourse.price}元</span></div>
                        <div>类型:<span style="margin-left: 10px">${hourse.type_id}</span></div>
                        <div>库存:<span style="margin-left: 10px">${hourse.the_size}</span></div>
                        <div>标签:<span style="margin-left: 10px">${hourse.welfare}</span></div>
                        <div>关键词:<span style="margin-left: 10px">${hourse.type_name}</span></div>
                    </div>
                </div>
               <form>
                   <div>
                       <button  class="layui-btn" lay-submit="" lay-filter="saveCart">加入购物车</button>
                   </div>
               </form>
            </div>
        </div>
        <div class="layui-row layui-col-md12">
            <div class="layui-collapse" lay-accordion>
                <div class="layui-colla-item">
                    <h2 class="layui-colla-title">详情</h2>
                    <div class="layui-colla-content layui-show">${hourse.info}</div>
                </div>
            </div>
        </div>
    </div>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.8.3.js"></script>
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
        form.on("submit(saveCart)",function(data){

            var loading = layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
            $.ajax({
                url : '${ctx}/cart/addCart.do',
                type : 'post',
                async: false,
                data : ${hourse},
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
    });
    function  show_img(e) {
        layer.open({
            type: 1,
            skin: 'layui-layer-rim', //加上边框
            area: ['96%', '96%'], //宽高
            shadeClose: true, //开启遮罩关闭
            title: '商品图片',
            content: "<div style='text-align: center'><img  src=" + $(e).attr('src') + " /></div>"
        });
    }
</script>
</body>
</html>