
package com.yxb.cms.architect.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

/**
 * 数据库相关配置<br>
 * 读取jdbc.properties配置文件,配置不同环境的数据库配置信息
 */
@Component
@PropertySource("classpath:jdbc.properties")
@ConfigurationProperties(prefix = "jdbc.mysql-master")
public class JdbcProperties {

    //数据库URL
    private String url;
    //数据库用户名
    private String username;
    //数据库密码
    private String password;
    //初始化链接大小
    private int initialSize;
    //连接池最大使用链接数量
    private int maxActive;
    //连接池最大空闲
    private int maxIdle;
    //连接池最小空闲
    private int minIdle;
    //连接池最大等待时间
    private long maxWait;
    //验证数据库是否连通
    private String validationQuery;


    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getInitialSize() {
        return initialSize;
    }

    public void setInitialSize(int initialSize) {
        this.initialSize = initialSize;
    }

    public int getMaxActive() {
        return maxActive;
    }

    public void setMaxActive(int maxActive) {
        this.maxActive = maxActive;
    }

    public int getMaxIdle() {
        return maxIdle;
    }

    public void setMaxIdle(int maxIdle) {
        this.maxIdle = maxIdle;
    }

    public int getMinIdle() {
        return minIdle;
    }

    public void setMinIdle(int minIdle) {
        this.minIdle = minIdle;
    }

    public long getMaxWait() {
        return maxWait;
    }

    public void setMaxWait(long maxWait) {
        this.maxWait = maxWait;
    }

    public String getValidationQuery() {
        return validationQuery;
    }

    public void setValidationQuery(String validationQuery) {
        this.validationQuery = validationQuery;
    }
}
