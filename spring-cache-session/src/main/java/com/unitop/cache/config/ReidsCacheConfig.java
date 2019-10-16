package com.unitop.cache.config;

import com.unitop.cache.config.redis.ExtendedRedisCacheManager;
import com.unitop.cache.config.redis.RedisProperties;
import com.unitop.cache.config.redis.serializer.FastJsonRedisSerializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.cache.interceptor.KeyGenerator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.cache.RedisCacheWriter;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.RedisSerializer;

import java.time.Duration;

/**
 * Created by caizh on 2018-10-25.
 */
@Configuration
@PropertySource(value = {
        "classpath:redis.properties" //如果是相同的key，则最后一个起作用
},ignoreResourceNotFound = true)
public class ReidsCacheConfig  {
    protected final Logger logger = LoggerFactory.getLogger(ReidsCacheConfig.class);


    @Autowired(required = false)
    RedisTemplate<Object, Object> redisTemplate;
    @Autowired(required = false)
    protected RedisProperties redisProperties;
    @Autowired(required = false)
    protected RedisConnectionFactory jedisConnectionFactory;

    @Bean
    @ConditionalOnProperty(name = ConditionKey.RedisCacheEnable)
    public KeyGenerator simpleKeyGenerator() {
        return (o, method, objects) -> {
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append(o.getClass().getSimpleName());
            stringBuilder.append(".");
            stringBuilder.append(method.getName());
            stringBuilder.append("[");
            for (Object obj : objects) {
                stringBuilder.append(obj.toString());
            }
            stringBuilder.append("]");

            return stringBuilder.toString();
        };
    }
    @Bean
    @ConditionalOnProperty(name = ConditionKey.RedisCacheEnable)
    public ExtendedRedisCacheManager redisCacheManager() {
        //初始化一个RedisCacheWriter
        RedisCacheWriter redisCacheWriter = RedisCacheWriter.nonLockingRedisCacheWriter(jedisConnectionFactory);
        //设置CacheManager的值序列化方式为json序列化
//        RedisSerializer<Object> jsonSerializer = new GenericJackson2JsonRedisSerializer();
        FastJsonRedisSerializer<Object> jsonSerializer = new FastJsonRedisSerializer<>(Object.class);
        RedisSerializationContext.SerializationPair<Object> pair = RedisSerializationContext.SerializationPair
                .fromSerializer(jsonSerializer);
        RedisCacheConfiguration defaultCacheConfig=RedisCacheConfiguration.defaultCacheConfig()
                .serializeValuesWith(pair)
                .entryTtl(Duration.ofSeconds(redisProperties.getDefaultexpiration()));
        logger.info("启用Redis缓存，Host:"+redisProperties.getHostName());
        //初始化RedisCacheManager
        ExtendedRedisCacheManager cacheManager= new ExtendedRedisCacheManager(redisCacheWriter, defaultCacheConfig);
        cacheManager.setCacheEnable(redisProperties.isEnable());
        return cacheManager;

//        ExtendedRedisCacheManager cacheManager=new ExtendedRedisCacheManager(redisTemplate);
//        cacheManager.setCacheEnable(redisProperties.isEnable());
//        cacheManager.setUsePrefix(redisProperties.isUsePrefix());
//        //默认设置1小时
//        cacheManager.setDefaultExpiration(redisProperties.getDefaultexpiration());
//        logger.info("启用Redis缓存，Host:"+redisProperties.getHostName());
//        return  cacheManager;


//        SimpleCacheManager cacheManager=new SimpleCacheManager();
//        RedisCache cache=new RedisCache("redisCache",null,redisTemplate,100);
//
//        List<Cache> c=new ArrayList<>();
//        c.add(cache);
//        c.add(new ConcurrentMapCache("localMaps"));
//        cacheManager.setCaches(c);
//
//return  cacheManager;
    }

}
