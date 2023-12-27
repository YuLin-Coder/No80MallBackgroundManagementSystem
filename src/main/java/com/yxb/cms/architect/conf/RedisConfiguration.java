
package com.yxb.cms.architect.conf;

import com.yxb.cms.architect.properties.JedisProperties;
import com.yxb.cms.handler.RedisClient;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

/**
 * redis配置
 */
@Configuration
@ConditionalOnClass(RedisClient.class)//判断这个类是否在classpath中存在
public class RedisConfiguration{


    private Logger log = LogManager.getLogger(RedisConfiguration.class);


    @Bean(name="jedisPool")
    public JedisPool jedisPool() {
        JedisPoolConfig config = new JedisPoolConfig();
        config.setMaxTotal(JedisProperties.maxTotal);
        config.setMaxIdle(JedisProperties.maxIdle);
        config.setMaxWaitMillis(JedisProperties.maxWaitMillis);
        return new JedisPool(config, JedisProperties.host, JedisProperties.port,JedisProperties.timeOut,JedisProperties.password);
    }


    @Bean
    @ConditionalOnMissingBean(RedisClient.class) //容器中如果没有RedisClient这个类,那么自动配置这个RedisClient
    public RedisClient redisClient(@Qualifier("jedisPool") JedisPool pool) {
        log.info("初始化……Redis Client==Host={},Port={}", JedisProperties.host, JedisProperties.port);
        RedisClient redisClient = new RedisClient();
        redisClient.setJedisPool(pool);
        return redisClient;
    }



}