
package com.yxb.cms.handler;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * 配置一些常用的 redis 的操作
 */
public class RedisClient {

    private Logger log = LogManager.getLogger(RedisClient.class);

    private JedisPool jedisPool;


    public void set(String key, String value) {
        Jedis jedis = null;
        try {
            jedis = jedisPool.getResource();
            jedis.set(key, value);
        }catch (Exception e){
            log.error(e.getMessage(),e);
            throw e;
        }finally {
            jedis.close();
        }
    }

    public String get(String key) {

        Jedis jedis = null;
        try {
            jedis = jedisPool.getResource();
            return jedis.get(key);
        } catch (Exception e){
            log.error(e.getMessage(),e);
            throw e;
        }finally {
            jedis.close();
        }

    }

    public Long del(String key) {

        Jedis jedis = null;
        try {
            jedis = jedisPool.getResource();
            return jedis.del(key);
        } catch (Exception e){
            log.error(e.getMessage(),e);
            throw e;
        }finally {
            jedis.close();
        }

    }


    public JedisPool getJedisPool() {
        return jedisPool;
    }

    public void setJedisPool(JedisPool jedisPool) {
        this.jedisPool = jedisPool;
    }
}
