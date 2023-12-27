
package com.yxb.cms.architect.interceptor;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *通用错误页面拦截器
 */
@Controller
public class ErrorInterceptor implements HandlerInterceptor {
    private Logger log = LogManager.getLogger(ErrorInterceptor.class);


    /**
     * 在请求处理之前进行调用（Controller方法调用之前）当preHandle的返回值为false的时候整个请求结束
     */
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        return true; // 只有返回true才会继续向下执行，返回false取消当前请求;
    }

    /**
     * 请求处理之后进行调用，但是在视图被渲染之前（Controller方法调用之后）
     */
    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        if(httpServletResponse.getStatus()==500){
            modelAndView.setViewName("error/500");
        }else if(httpServletResponse.getStatus()==404){
            modelAndView.setViewName("error/404");
        }

    }
    /**
     * 请求完成之后，也就是DispatcherServlet渲染了视图执行，主要作用是用于清理资源
     */
    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
