
package com.yxb.cms.architect.conf;

import com.yxb.cms.architect.realm.ShiroDbRealm;
import com.yxb.cms.dao.ResourceMapper;
import com.yxb.cms.domain.vo.Resource;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Shiro配置类
 */
@Configuration
public class ShiroConfiguration {

    private Logger log = LogManager.getLogger(ShiroConfiguration.class);

    /**
     * Shiro Web过滤器Factory
     * @param securityManager 安全管理Bean
     * @return
     */
    @Bean(name = "shiroFilter")
    public ShiroFilterFactoryBean shiroFilterFactoryBean(@Qualifier("securityManager") SecurityManager securityManager, ResourceMapper resourceMapper) {
        log.info("注入Shiro的Web过滤器-->shiroFilter");
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        //Shiro的核心安全接口,这个属性是必须的
        shiroFilterFactoryBean.setSecurityManager(securityManager);
        //要求登录时的链接(可根据项目的URL进行替换),非必须的属性,默认会自动寻找Web工程根目录下的"/login.jsp"页面
        shiroFilterFactoryBean.setLoginUrl("/loginProxy.do");
        //登录成功后要跳转的连接,逻辑也可以自定义，例如返回上次请求的页面
        shiroFilterFactoryBean.setSuccessUrl("/main.do");
        //用户访问未对其授权的资源时,所显示的连接
        shiroFilterFactoryBean.setUnauthorizedUrl("/main/unauthorized.do");
         /*定义shiro过滤链 Map结构 * Map中key(xml中是指value值)的第一个'/'代表的路径是相对于HttpServletRequest.getContextPath()的值来的 *
         anon：它对应的过滤器里面是空的,什么都没做,这里 .do和.jsp后面的*表示参数,比方说login.jsp?main这种 *
         authc：该过滤器下的页面必须验证后才能访问,它是Shiro内置的一个拦截器org.apache.shiro.web.filter.authc.FormAuthenticationFilter */
        Map<String, String> filterChainDefinitionMap = new LinkedHashMap<String, String>();
        // 配置退出过滤器,其中的具体的退出代码Shiro已经替我们实现了
        filterChainDefinitionMap.put("/logout.do", "logout");

        // <!-- 过滤链定义，从上向下顺序执行，一般将 /**放在最为下边 -->:这是一个坑呢，一不小心代码就不好使了;
        // <!-- authc:所有url都必须认证通过才可以访问; anon:所有url都都可以匿名访问-->
        filterChainDefinitionMap.put("/login.do", "anon");//anon 可以理解为不拦截
        filterChainDefinitionMap.put("/registerUI.do", "anon");//anon 可以理解为不拦截
        filterChainDefinitionMap.put("/register.do", "anon");//anon 可以理解为不拦截
        filterChainDefinitionMap.put("/loginCheck.do", "anon");//anon 可以理解为不拦截
        filterChainDefinitionMap.put("/loginProxy.do", "anon");//anon 可以理解为不拦截
        filterChainDefinitionMap.put("/captcha.do", "anon");//anon 可以理解为不拦截
        filterChainDefinitionMap.put("/user/**", "anon");//anon 可以理解为不拦截
        filterChainDefinitionMap.put("/cart/**", "anon");//anon 可以理解为不拦截
        filterChainDefinitionMap.put("/user_login/**", "anon");//anon 可以理解为不拦截
        filterChainDefinitionMap.put("/pay/**", "anon");//anon 可以理解为不拦截
        filterChainDefinitionMap.put("/hourse/uploadHeadImage.do", "anon");//anon 可以理解为不拦截

        filterChainDefinitionMap.put("/upload/**", "anon");//anon 可以理解为不拦截
        filterChainDefinitionMap.put("/comm/**", "anon");//anon 可以理解为不拦截
        filterChainDefinitionMap.put("/static/**", "anon");//anon 可以理解为不拦截
        filterChainDefinitionMap.put("/about/**", "anon");//anon 可以理解为不拦截

        //动态URL过滤
        List<Resource> resList= resourceMapper.selectResUrlAllList();
        for (Resource resource : resList) {
            filterChainDefinitionMap.put(resource.getResLinkAddress(), "perms["+resource.getResModelCode()+"]");
        }
        filterChainDefinitionMap.put("/**", "authc");//表示需要认证才可以访问

        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);

        return shiroFilterFactoryBean;

    }


    /**
     * 配置Shiro 缓存
     * @return
     */
    @Bean(name = "cacheManager")
    public EhCacheManager ehCacheManager(){
        EhCacheManager cacheManager = new EhCacheManager();
        return cacheManager;
    }


    /**
     * 配置核心安全事务管理器
     * @param myRealm       自定义权限bean
     * @param cacheManager 缓存
     * @return
     */
    @Bean(name = "securityManager")
    public SecurityManager securityManager(ShiroDbRealm myRealm, @Qualifier("cacheManager") EhCacheManager cacheManager) {
        log.info("--------------加载securityManager----------------");
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setRealm(myRealm);
        securityManager.setCacheManager(cacheManager);
        return securityManager;
    }

    /**
     * Shiro生命周期处理器 * @return
     */
    @Bean
    public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
        return new LifecycleBeanPostProcessor();
    }


    /**
     * 开启Shiro的注解(如@RequiresRoles,@RequiresPermissions),需借助SpringAOP扫描使用Shiro注解的类,并在必要时进行安全逻辑验证
     * 配置以下两个bean(DefaultAdvisorAutoProxyCreator(可选)和AuthorizationAttributeSourceAdvisor)即可实现此功能
     * @return
     */
    @Bean
    @DependsOn({"lifecycleBeanPostProcessor"})
    public DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator() {
        DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator = new DefaultAdvisorAutoProxyCreator();
        advisorAutoProxyCreator.setProxyTargetClass(true);
        return advisorAutoProxyCreator;
    }
    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(@Qualifier("securityManager") SecurityManager securityManager) {
        AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
        authorizationAttributeSourceAdvisor.setSecurityManager(securityManager);
        return authorizationAttributeSourceAdvisor;
    }


}
