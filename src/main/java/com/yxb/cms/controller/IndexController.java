
package com.yxb.cms.controller;

import com.yxb.cms.architect.constant.Constants;
import com.yxb.cms.handler.RedisClient;
import com.yxb.cms.service.DataCleaningService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 主页Controller
 */
@Controller
@RequestMapping("main")
public class IndexController extends BasicController {

    @Autowired
    private DataCleaningService dataCleaningService;
    @Autowired
    private RedisClient redisClient;

    /**
     *跳转到主页
     * @return
     */
    @RequestMapping("/index.do")
    public String toIndexPage() {
        return "main/index";
    }

    /**
     * 跳转到欢迎页
     * @return
     */
    @RequestMapping("/home.do")
    public String toHomePage() {
        return "main/home";
    }

    /**
     * 跳转到权限不足页面
     * @return
     */
    @RequestMapping("/unauthorized.do")
    public String toUnauthorizedPage() {
        return "error/unauthorized";
    }

    /**
     * 网站访问量,图表展示
     * @return
     */
    @RequestMapping("/ajax_echarts_login_info.do")
    @ResponseBody
    public String  ajaxEchartsByLoginInfo() {

        String userPv = redisClient.get(Constants.REDIS_KEY_ECHARTS_USER_PV);
        if(StringUtils.isNotEmpty(userPv)){
            return userPv;
        }
        log.info("redis值为空，查询数据库，并重新set到redis");
        String dataUserPv = dataCleaningService.selectEchartsByLoginInfo();
        redisClient.set(Constants.REDIS_KEY_ECHARTS_USER_PV,dataUserPv);
        return dataUserPv;

    }


}
