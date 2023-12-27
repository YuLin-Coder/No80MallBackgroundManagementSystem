
package com.yxb.cms.architect.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

/**
 * redis配置<br>
 * 读取jedis.properties配置文件,配置不同环境的redis配置信息
 */
@Component
@PropertySource("classpath:jedis.properties")
@ConfigurationProperties(prefix = "redis-pool")
public class JedisProperties {

    //Redis服务器地址
    public static String host;
    //Redis服务器端口
    public static int port;

    //Redis服务器连接密码（默认为空）
    public static String password;
    //连接超时时间（毫秒）
    public static int timeOut;

    //连接池中的最大空闲连接
    public static int maxIdle;
    //连接池最大阻塞等待时间（使用负值表示没有限制）
    public static int maxWaitMillis;

    //连接池最大实例
    public static int maxTotal;


    public static void setHost(String host) {
        JedisProperties.host = host;
    }

    public static void setPort(int port) {
        JedisProperties.port = port;
    }

    public static void setPassword(String password) {
        JedisProperties.password = password;
    }

    public static void setTimeOut(int timeOut) {
        JedisProperties.timeOut = timeOut;
    }

    public static void setMaxIdle(int maxIdle) {
        JedisProperties.maxIdle = maxIdle;
    }

    public static void setMaxWaitMillis(int maxWaitMillis) {
        JedisProperties.maxWaitMillis = maxWaitMillis;
    }

    public static void setMaxTotal(int maxTotal) {
        JedisProperties.maxTotal = maxTotal;
    }
}
