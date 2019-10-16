package com.unitop.cache.config;


import com.unitop.cache.config.redis.ExtendedRedisCacheManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.CachingConfigurer;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.interceptor.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

/**
 * Created by caizh on 2018-10-26.
 */
@Configuration
@EnableCaching(proxyTargetClass = true)

public class CacheConfig implements CachingConfigurer {

    @Autowired(required = false)
    ExtendedRedisCacheManager redisCacheManager;

    @Bean
    @Primary
    @Override
    public CacheManager cacheManager() {
        if(redisCacheManager!=null&&redisCacheManager.isCacheEnable())return redisCacheManager;

        return null;
    }
    @Override

    public CacheResolver cacheResolver() {
        return new SimpleCacheResolver(cacheManager());
    }

    @Bean
    @Override
    public KeyGenerator keyGenerator() {
        return new SimpleKeyGenerator();
    }

    @Override
    public CacheErrorHandler errorHandler() {
        return new SimpleCacheErrorHandler();
    }
}
