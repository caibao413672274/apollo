package com.unitop.cache.config;

/**
 * Created by caizh on 2019-1-25.
 */
public class ConditionKey {
    /**
     * redis host 配置
     */
    public static  final String RedisHost="redis.hostName";
    /**
     * redis缓存启用
     */
    public static  final String RedisCacheEnable="redis.cache.enable";

    /**
     * Memcached缓存启用
     */
    public static  final String MemcachedCacheEnable="memcached.cache.enable";

    public static  final String MemcachedHost="memcached.host";
}


