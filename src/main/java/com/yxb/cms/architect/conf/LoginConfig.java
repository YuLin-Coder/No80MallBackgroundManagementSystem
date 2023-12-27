package com.yxb.cms.architect.conf;

import com.yxb.cms.architect.interceptor.UserInterceptor;
import java.util.List;
import org.springframework.context.annotation.Configuration;
import org.springframework.format.FormatterRegistry;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.validation.MessageCodesResolver;
import org.springframework.validation.Validator;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.HandlerMethodReturnValueHandler;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.config.annotation.AsyncSupportConfigurer;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
public class LoginConfig implements WebMvcConfigurer
{
    @Override
    public void configurePathMatch(PathMatchConfigurer pathMatchConfigurer)
    {

    }
    @Override
    public void configureContentNegotiation(ContentNegotiationConfigurer contentNegotiationConfigurer)
    {

    }
    @Override
    public void configureAsyncSupport(AsyncSupportConfigurer asyncSupportConfigurer)
    {

    }
    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer defaultServletHandlerConfigurer)
    {

    }
    @Override
    public void addFormatters(FormatterRegistry formatterRegistry)
    {

    }
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry resourceHandlerRegistry)
    {

    }
    @Override
    public void addCorsMappings(CorsRegistry corsRegistry)
    {

    }
    @Override
    public void addViewControllers(ViewControllerRegistry viewControllerRegistry)
    {

    }
    @Override
    public void configureViewResolvers(ViewResolverRegistry viewResolverRegistry)
    {

    }
    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> list)
    {

    }
    @Override
    public void addReturnValueHandlers(List<HandlerMethodReturnValueHandler> list)
    {

    }
    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> list)
    {

    }
    @Override
    public void extendMessageConverters(List<HttpMessageConverter<?>> list)
    {

    }
    @Override
    public void configureHandlerExceptionResolvers(List<HandlerExceptionResolver> list)
    {

    }
    @Override
    public void extendHandlerExceptionResolvers(List<HandlerExceptionResolver> list)
    {

    }
    @Override
    public Validator getValidator()
    {
        return null;
    }
    @Override
    public MessageCodesResolver getMessageCodesResolver()
    {
        return null;
    }

    // 这个方法用来注册拦截器，我们自己写好的拦截器需要通过这里添加注册才能生效

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //注册TestInterceptor拦截器
        InterceptorRegistration registration = registry.addInterceptor(new UserInterceptor());
        registration.addPathPatterns("/user//personal/info.do");                      //所有路径都被拦截
        registration.addPathPatterns("/user/comment.do");
        registration.addPathPatterns("/user/myserver.do");
        registration.addPathPatterns("/user/view_hourse.do");
        registration.addPathPatterns("/user/view_server.do");
        registration.addPathPatterns("/user/detailHourse.do");
        registration.addPathPatterns("/user/comment_add.do");
        registration.addPathPatterns("/user/editUserUI.do");
        registration.addPathPatterns("/cart/generOrder.do");
        registration.excludePathPatterns(                         //添加不拦截路径
                "/**/*.jsp",            //html静态资源
                "/**/*.js",              //js静态资源
                "/**/*.css"             //css静态资源
        );
    }
}
