/**
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
 *
 * Copyright 2017 © yangxiaobing, 873559947@qq.com
 *
 * This file is part of contentManagerSystem.
 * contentManagerSystem is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * contentManagerSystem is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with contentManagerSystem.  If not, see <http://www.gnu.org/licenses/>.
 *
 * 这个文件是contentManagerSystem的一部分。
 * 您可以单独使用或分发这个文件，但请不要移除这个头部声明信息.
 * contentManagerSystem是一个自由软件，您可以自由分发、修改其中的源代码或者重新发布它，
 * 新的任何修改后的重新发布版必须同样在遵守GPL3或更后续的版本协议下发布.
 * 关于GPL协议的细则请参考COPYING文件，
 * 您可以在contentManagerSystem的相关目录中获得GPL协议的副本，
 * 如果没有找到，请连接到 http://www.gnu.org/licenses/ 查看。
 *
 * - Author: yangxiaobing
 * - Contact: 873559947@qq.com
 * - License: GNU Lesser General Public License (GPL)
 * - source code availability: http://git.oschina.net/yangxiaobing_175/contentManagerSystem
 */
package com.yxb.cms.architect.conf;

import com.yxb.cms.architect.annotation.SystemControllerLog;
import com.yxb.cms.architect.annotation.SystemServiceLog;
import com.yxb.cms.architect.constant.Constants;
import com.yxb.cms.architect.utils.ClientIpUtil;
import com.yxb.cms.architect.utils.ThreadPool;
import com.yxb.cms.domain.vo.SystemLog;
import com.yxb.cms.domain.vo.User;
import com.yxb.cms.service.SystemLogService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NamedThreadLocal;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Map;


/**
 * Spring AOP实现日志管理
 */
@Aspect
@Component
public class SystemLogAspect {

    private Logger log = LogManager.getLogger(SystemLogAspect.class);

    private static final ThreadLocal<Date> beginTimeThreadLocal = new NamedThreadLocal<Date>("ThreadLocal beginTime");

    @Autowired
    private SystemLogService systemLogService;
    @Autowired(required=false)
    private HttpServletRequest request;
    /**
     * controller层切点,注解方式
     */
    //@Pointcut("execution(* *..controller..*Controller*.*(..))")
    @Pointcut("@annotation(com.yxb.cms.architect.annotation.SystemControllerLog)")
    public void controllerAspect() {
        log.info("========controllerAspect===========");
    }

    /**
     * Service层切点,注解方式
     */
    @Pointcut("@annotation(com.yxb.cms.architect.annotation.SystemServiceLog)")
    public void serviceAspect() {
        log.info("========ServiceAspect===========");
    }


    /**
     * 前置通知 (在方法执行之前返回)用于拦截Controller层记录用户的操作的开始时间
     * @param joinPoint 切点
     * @throws InterruptedException
     */
    @Before("controllerAspect()")
    public void doBefore(JoinPoint joinPoint) throws InterruptedException{

        //线程绑定变量（该数据只有当前请求的线程可见）
        Date beginTime=new Date();
        beginTimeThreadLocal.set(beginTime);


    }


    /**
     * 后置通知(在方法执行之后返回) 用于拦截Controller层操作
     * @param joinPoint 切点
     */
    @After("controllerAspect()")
    public void after(JoinPoint joinPoint){
        try {
            HttpSession session = request.getSession();
            //读取session中的用户
            User user = (User) session.getAttribute(Constants.SESSION_KEY_LOGIN_NAME);

            if (null != user) {

                //日志标题
                String logTitle = getControllerMethodDescription(joinPoint);
                //日志类型
                String logType = "info";
                //日志请求url
                String logUrl = request.getRequestURI();
                //请求方式
                String logMethod = request.getMethod();
                //请求参数
                Map<String,String[]> logParams=request.getParameterMap();
                //请求用户
                String logUserName = user.getUserLoginName();
                //请求IP
                String logIp = ClientIpUtil.getIpAddr(request);
                //请求开始时间
                Date logStartTime = beginTimeThreadLocal.get();

                long beginTime = beginTimeThreadLocal.get().getTime();
                long endTime = System.currentTimeMillis();
                //请求耗时
                Long logElapsedTime = endTime - beginTime;

                SystemLog systemLog = new SystemLog(logTitle,logType,logUrl,logMethod,logUserName,logIp,logStartTime,logElapsedTime);
                systemLog.setMapToParams(logParams);
                ThreadPool.getPool().execute(new SaveSystemLogThread(systemLog,systemLogService,logIp));


            }

        } catch (Exception e) {
            log.error("AOP后置通知异常", e);
        }
    }




    /**
     * 异常通知 用于拦截service层记录异常日志
     * @param joinPoint
     * @param e
     */
    @AfterThrowing(pointcut="serviceAspect()", throwing="e")
    public void doAfterThrowing(JoinPoint joinPoint, Throwable e) {

        try {
            HttpSession session = request.getSession();
            //读取session中的用户
            User user = (User) session.getAttribute(Constants.SESSION_KEY_LOGIN_NAME);
            if (null != user) {

                //日志标题
                String logTitle = getServiceMethodDescription(joinPoint);
                //日志类型
                String logType = "error";
                //日志请求url
                String logUrl = joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()";
                //请求方式
                String logMethod = request.getMethod();
                //请求参数
                Map<String,String[]> logParams=request.getParameterMap();

                //请求用户
                String logUserName = user.getUserLoginName();
                //请求IP
                String logIp = ClientIpUtil.getIpAddr(request);
                //请求开始时间
                Date logStartTime = beginTimeThreadLocal.get();

                long beginTime = beginTimeThreadLocal.get().getTime();
                long endTime = System.currentTimeMillis();
                //请求耗时
                Long logElapsedTime = endTime - beginTime;
                //异常描述
                String LogException = e.toString();

                SystemLog systemLog = new SystemLog(logTitle,logType,logUrl,logMethod,LogException,logUserName,logIp,logStartTime,logElapsedTime);
                systemLog.setMapToParams(logParams);
                ThreadPool.getPool().execute(new SaveSystemLogThread(systemLog,systemLogService,logIp));


            }

        } catch (Exception e1) {
            log.error("AOP异常通知异常", e1);
        }

    }


    /**
     * 保存日志
     */
    private static class SaveSystemLogThread implements Runnable {
        private SystemLog systemLog;
        private SystemLogService systemLogService;
        private String logIp;

        public SaveSystemLogThread(SystemLog systemLog, SystemLogService systemLogService,String logIp) {
            this.systemLog = systemLog;
            this.systemLogService = systemLogService;
            this.logIp = logIp;
        }

        @Override
        public void run() {
            String logIpAddress = ClientIpUtil.getIpAddrSource(logIp);
            systemLog.setLogIpAddress(logIpAddress);
            systemLogService.insertSelective(systemLog);
        }
    }



    /**
     * 获取注解中对方法的描述信息 用于Controller层注解
     * @param joinPoint 切点
     * @return 方法描述
     * @throws Exception
     */
    public static String getControllerMethodDescription(JoinPoint joinPoint) throws Exception{
        //获取目标类名
        String targetName = joinPoint.getTarget().getClass().getName();
        //获取方法名
        String methodName = joinPoint.getSignature().getName();
        //获取相关参数
        Object[] arguments = joinPoint.getArgs();
        //生成类对象
        Class targetClass = Class.forName(targetName);
        //获取该类中的方法
        Method[] methods = targetClass.getMethods();

        String description = "";

        for(Method method : methods) {
            if(!method.getName().equals(methodName)) {
                continue;
            }
            Class[] clazzs = method.getParameterTypes();
            if(clazzs.length != arguments.length) {//比较方法中参数个数与从切点中获取的参数个数是否相同，原因是方法可以重载哦
                continue;
            }
            description = method.getAnnotation(SystemControllerLog.class).description();
        }
        return description;
    }
    /**
     * 获取注解中对方法的描述信息 用于Service层注解
     * @param joinPoint 切点
     * @return 方法描述
     * @throws Exception
     */
    public static String getServiceMethodDescription(JoinPoint joinPoint) throws Exception{
        //获取目标类名
        String targetName = joinPoint.getTarget().getClass().getName();
        //获取方法名
        String methodName = joinPoint.getSignature().getName();
        //获取相关参数
        Object[] arguments = joinPoint.getArgs();
        //生成类对象
        Class targetClass = Class.forName(targetName);
        //获取该类中的方法
        Method[] methods = targetClass.getMethods();

        String description = "";

        for(Method method : methods) {
            if(!method.getName().equals(methodName)) {
                continue;
            }
            Class[] clazzs = method.getParameterTypes();
            if(clazzs.length != arguments.length) {//比较方法中参数个数与从切点中获取的参数个数是否相同，原因是方法可以重载哦
                continue;
            }
            description = method.getAnnotation(SystemServiceLog.class).description();
        }
        return description;
    }
}
