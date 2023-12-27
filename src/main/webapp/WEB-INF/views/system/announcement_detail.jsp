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
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/personal.css" media="all">
    <link rel="stylesheet" type="text/css" href="http://at.alicdn.com/t/font_9h680jcse4620529.css">
    <script src="${ctx}/static/layui_v2/layui.js"></script>


<body>
<div class="larry-grid layui-anim layui-anim-upbit larryTheme-A ">
    <div class="larry-personal">
        <div class="layui-tab">

            <div class="larry-separate"></div>
            <!-- 公告列表 -->
            <div class="layui-tab-item layui-show" style="padding: 10px 15px;">
                <div class="layui-elem-quote layui-quote-nm" style="border-width: 1px;">
                    <span style="display:inline-block;width:100%;text-align:center; font-size:25px;">${announcementInfo.announcementTitle}</span>
                    <span style="display:inline-block;width:100%;text-align:center;color:#999999;margin-top: 22px;font-size: 14px; ">
                        <label style="margin-right: 20px;">公告类型：${announcementInfo.announcementType_Lable}</label>
                        <label style="margin-right: 20px;">发布时间：${announcementInfo.announcementTime_Lable}</label>
                        <label style="margin-right: 20px;">发布者:${announcementInfo.announcementAuthor}</label>
                    </span>
                    <hr class="layui-bg-green">
                    <div>
                        <p style="font-size: 14px;line-height: 22px;">尊敬的用户：</p>
                        <br>
                        <p style="margin-left:12px;font-size: 14px;line-height: 22px;">${announcementInfo.announcementContent}</p >

                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
</script>
</body>
</html>