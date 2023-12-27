<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/comm/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>后台管理系统登陆</title>
    <link rel="shortcut icon" href="${ctx}/static/img/favicon.ico">
    <link rel="stylesheet" href="${ctx}/static/layui_v2/css/layui.css">
    <link rel="stylesheet" href="${ctx}/static/css/login.css">
    <script type="text/javascript" src="${ctx}/static/layui_v2/layui.js"></script>
</head>
<body>
<div class="layui-carousel video_mask" id="login_carousel" >
    <div carousel-item>
        <div class="carousel_div1"></div>
        <div class="carousel_div2"></div>
        <div class="carousel_div3"></div>
    </div>
    <%--<video class="video-player" preload="auto" autoplay="autoplay"  muted = "true" loop="loop" data-height="1080" data-width="1920" height="1080" width="1920">--%>
    <%--<source src="${ctx}/static/video/video1.mp4" type="video/mp4">--%>
    <%--<!-- 此视频文件为腾讯所有，在此仅供样式参考，如用到商业用途，请自行更换为其他视频或图片，否则造成的任何问题使用者本人承担，谢谢 -->--%>
    <%--</video>--%>
    <%--<div class="video_mask"></div>--%>
    <div class="login layui-anim layui-anim-up">
        <h1>商城</h1></p>
        <form class="layui-form" action="" method="post">
            <div class="layui-form-item">
                <input type="text" name="username" lay-verify="required" placeholder="请输入账号" autocomplete="off"  value="" class="layui-input">
            </div>
            <div class="layui-form-item">
                <input type="password" name="password" lay-verify="required" placeholder="请输入密码" autocomplete="off" value="" class="layui-input">
            </div>
            <div class="layui-form-item form_code">
                <input class="layui-input" name="code" placeholder="验证码" lay-verify="required" type="text" autocomplete="off">
                <div class="code"><img src="${ctx}/captcha.do" width="116" height="36"></div>
            </div>

           <div style="display: flex">
               <button class="layui-btn login_btn" lay-submit="" lay-filter="login">登陆</button>
               <a class="layui-btn"  onclick="registerUI()">注册</a>
           </div>
        </form>
    </div>

</div>
</body>

</html>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.8.3.js"></script>
<script>
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form','layer','jquery','common','carousel'], function () {
        var $ = layui.jquery,
                form = layui.form,
                 layer = layui.layer,
                common = layui.common,
                carousel = layui.carousel;

        /**背景图片轮播*/
        carousel.render({
             elem: '#login_carousel',
             width: '100%',
             height: '100%',
             interval:2000,
             arrow: 'none',
             anim: 'fade',
             indicator:'none'
        });

        /**重新生成验证码*/
        function reqCaptcha() {
            var url = "${ctx}/captcha.do?nocache=" + new Date().getTime()
            $('.code img').attr("src",url)
        }
        /**点击验证码重新生成*/
        $('.code img').on('click', function () {
            reqCaptcha();
        });

        /**监听登陆提交*/
        form.on('submit(login)', function (data) {
            //弹出loading
            var loginLoading = layer.msg('登陆中，请稍候', {icon: 16, time: false, shade: 0.8});
            //记录ajax请求返回值
            var ajaxReturnData;

            //登陆验证
            $.ajax({
                url: '${ctx}/loginCheck.do',
                type: 'post',
                async: false,
                data: data.field,
                success: function (data) {
                    ajaxReturnData = data;
                }
            });
            //登陆成功
            if (ajaxReturnData.returnCode == 0000) {
                window.location.href="${ctx}/main/index.do";
                layer.close(loginLoading);
                return false;
            } else {
                layer.close(loginLoading);
                common.cmsLayErrorMsg(ajaxReturnData.returnMessage);
                reqCaptcha();
                return false;
            }
        });

       // layer.alert('账号:user_system/123456 用户管理员<br>账号:user_readonly/123456 只读用户<br>原admin账号暂时回收');
    });

    function registerUI() {
        var url="${ctx}/registerUI.do";
        layer.open({
            type: 2,
            skin: 'layui-layer-rim', //加上边框
            area: ['800px', '500px'], //宽高
            shadeClose: true, //开启遮罩关闭
            title: '商家注册',
            content: url
        });
    }
</script>