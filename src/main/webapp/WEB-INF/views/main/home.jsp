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

    <link rel="stylesheet" href="${ctx}/static/css/global.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/personal.css" media="all">
    <link rel="stylesheet" href="${ctx}/static/css/main.css">

    <link rel="stylesheet" type="text/css" href="http://at.alicdn.com/t/font_9h680jcse4620529.css">

    <script src="${ctx}/static/layui_v2/layui.js"></script>

    <script src="${ctx}/static/js/jquery-1.8.3.js"></script>
    <script src="${ctx}/static/js/jquery.leoweather.min.js"></script>

<%--    <script type="text/javascript" src="${ctx}/static/echarts/echarts.min.js" charset="utf-8"></script>--%>
<%--    <script type="text/javascript" src="${ctx}/static/echarts/macarons.js" charset="utf-8"></script>--%>

</head>
<body>
<div class="larry-grid layui-anim layui-anim-upbit larryTheme-A" >
    <div class="larry-personal" >
        <div class="layui-tab" >
            <blockquote class="layui-elem-quote col-md-12 head-con">
                <div>${LOGIN_NAME.userName}<span id="weather"></span></div>
            </blockquote>
            <div class="larry-separate"></div>
            <!-- 菜单列表 -->
            <div class="layui-show" style="padding: 10px 15px;">
                <div class="panel_box row">
                    <div class="panel col">
                        <a href="javascript:;" data-url="${ctx}/announcement/announcement_unread_list.do">
                            <div class="panel_icon">
                                <i class="layui-icon larry-icon larry-gonggaoguanli" data-icon="larry-gonggaoguanli"></i>
                            </div>
                            <div class="panel_word unreadAnnInfo">
                                <span>0</span>
                                <cite>未读公告</cite>
                            </div>
                        </a>
                    </div>
                  <%--  <div class="panel col">
                        <a href="javascript:;" data-url="page/message/message.html">
                            <div class="panel_icon">
                                <i class="layui-icon" data-icon="&#xe63a;">&#xe63a;</i>
                            </div>
                            <div class="panel_word newMessage">
                                <span>0</span>
                                <cite>待定</cite>
                            </div>
                        </a>
                    </div>
                    <div class="panel col">
                        <a href="javascript:;" data-url="page/user/allUsers.html">
                            <div class="panel_icon" style="background-color:#F7B824;">
                            <i class="layui-icon" data-icon="&#xe613;">&#xe613;</i>
                            </div>
                            <div class="panel_word waitNews">
                                <span>0</span>
                                <cite>待定</cite>
                            </div>
                        </a>
                    </div>
                    <div class="panel col max_panel">
                        <a href="javascript:;" data-url="page/img/images.html">
                            <div class="panel_icon" style="background-color:#5FB878;">
                                <i class="layui-icon" data-icon="&#xe64a;">&#xe64a;</i>
                            </div>
                            <div class="panel_word imgAll">
                                <span>0</span>
                                <cite>待定</cite>
                            </div>
                        </a>
                    </div>--%>

                </div>

            </div>
            <div class="larry-separate"></div>
           <%-- <div class="row">
                <div class="sysNotice col">
                    <div class="layui-collapse" >
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title" style="background-color: #ffffff;">网站访问情况统计</h2>
                            <div class="layui-colla-content layui-show" >
                                <div id="container" style="height: 300px; margin: 0 auto;width: 100%;"></div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="sysNotice col">
                    <div class="layui-collapse">
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title" style="background-color: #ffffff;">其他图表统计，待定</h2>
                            <div class="layui-colla-content layui-show" >

                            </div>
                        </div>

                    </div>
                </div>

            </div>--%>

        </div>
    </div>
</div>

<script type="text/javascript">
    var $;
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form','jquery','layer','common','element'],function() {
        $ = layui.$;
              var  form = layui.form,
                element = layui.element,
                common = layui.common;

        var loading = layer.load(0,{ shade: [0.3,'#000']});

        //天气插件
        $('#weather').leoweather({format:'，{时段}好！，<span id="colock">现在时间是：<strong>{年}年{月}月{日}日 星期{周} {时}:{分}:{秒}</strong>，</span> <b>{城市}天气</b> {天气} {夜间气温}℃ ~ {白天气温}℃ '});

        //首页卡片tab添加
        $(".panel a").on("click",function(){
            window.parent.addTab($(this));
        });
        //首页数据初始化
        homeInit();

        // //图表
        // var psLineChar = echarts.init(document.getElementById('container'),'macarons');

        //查询
        <%--function loadDrugs() {--%>
        <%--    psLineChar.clear();--%>
        <%--    psLineChar.showLoading({text: '正在努力的读取数据中...'});--%>
        <%--    $.post("${ctx}/main/ajax_echarts_login_info.do", function(data) {--%>

        <%--        var dataJson =  jQuery.parseJSON(data);--%>
        <%--        var option = {--%>
        <%--            title : {--%>
        <%--                text: '网站访问量',--%>
        <%--                subtext: '10天访问情况统计'--%>
        <%--            },--%>
        <%--            tooltip : {--%>
        <%--                trigger: 'axis'--%>
        <%--            },--%>
        <%--            legend: {--%>
        <%--                data:['访问量']--%>
        <%--            },--%>
        <%--            toolbox: {--%>
        <%--                show : true,--%>
        <%--                feature : {--%>
        <%--                    magicType : {type: ['line', 'bar']}--%>
        <%--                }--%>
        <%--            },--%>
        <%--            calculable : true,--%>
        <%--            xAxis : [--%>
        <%--                {--%>
        <%--                    type : 'category',--%>
        <%--                    data : dataJson.xAxisData--%>
        <%--                }--%>
        <%--            ],--%>
        <%--            yAxis : [--%>
        <%--                {--%>
        <%--                    type : 'value'--%>
        <%--                }--%>
        <%--            ],--%>
        <%--            series : [--%>
        <%--                {--%>
        <%--                    name:'访问量',--%>
        <%--                    type:'bar',--%>
        <%--                    data:dataJson.seriesData--%>
        <%--                }--%>
        <%--            ]--%>
        <%--        };--%>
        <%--        psLineChar.setOption(option, true);--%>
        <%--    });--%>
        <%--    psLineChar.hideLoading();--%>

        <%--}--%>


        <%--//载入图表--%>
        <%--loadDrugs();--%>

        //浏览器大小改变时重置大小
        window.onresize = function () {
            psLineChar.resize();

        };
        layer.close(loading);


    });
    /**页面赋值初始化*/
    function homeInit() {
        /**加载未读公告数*/
        $.post("${ctx}/announcement/ajax_unread_anninfo_count.do", function(data) {
            $(".unreadAnnInfo span").text(data);
        });
    }
</script>
</body>
</html>