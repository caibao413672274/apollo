package com.unitop.cache.config.redis;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.cache.RedisCache;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.cache.RedisCacheWriter;
import org.springframework.data.redis.core.RedisOperations;
import org.springframework.lang.Nullable;

import java.time.Duration;
import java.util.Objects;

/**
 *  * 重写redis缓存管理器
 * <p>
 * 重写 RedisCacheManager createCache 方法
 * <p>
 * 在缓存名字上添加过期时间表达式 如:cachename#60*60
 * Created by caizh on 2018-10-26.
 */
public class ExtendedRedisCacheManager extends RedisCacheManager {
    //    private static final ScriptEngine scriptEngine = new ScriptEngineManager().getEngineByName("JavaScript");
    protected static final Logger log = LoggerFactory.getLogger(ExtendedRedisCacheManager.class);
//    private static final Pattern pattern = Pattern.compile("[+\\-*/%]");

    public boolean isCacheEnable() {
        return cacheEnable;
    }

    public void setCacheEnable(boolean cacheEnable) {
        this.cacheEnable = cacheEnable;
    }

    /**
     * 缓存是否启用
     */
    private boolean cacheEnable=false;

    /**
     * 分隔符
     */
    private char separator = '#';
    public ExtendedRedisCacheManager(RedisCacheWriter cacheWriter, RedisCacheConfiguration defaultCacheConfiguration) {
        super(cacheWriter, defaultCacheConfiguration, true);
    }

//    public ExtendedRedisCacheManager(@SuppressWarnings("rawtypes") RedisOperations redisOperations) {
//        super(redisOperations);
//    }

    @Override
    protected RedisCache createRedisCache(String name, @Nullable RedisCacheConfiguration cacheConfig) {
        long expiration=cacheConfig.getTtl().getSeconds();
        int index = name.indexOf(this.getSeparator());
        if (index > 0) {
            expiration = getExpiration(name, index, expiration);
        }

        cacheConfig=  cacheConfig.entryTtl(Duration.ofSeconds(expiration));
        return super.createRedisCache(name, cacheConfig);
    }

//    @Override
//    @SuppressWarnings("unchecked")
//    protected RedisCache createCache(String cacheName) {
//        // 获取默认时间
//        long expiration = computeExpiration(cacheName);
//        int index = cacheName.indexOf(this.getSeparator());
//        if (index > 0) {
//            expiration = getExpiration(cacheName, index, expiration);
//        }
//        return new RedisCache(cacheName, (isUsePrefix() ? getCachePrefix().prefix(cacheName) : null),
//                getRedisOperations(), expiration);
//    }

    /**
     * 计算缓存时间
     * @param name 缓存名字 cache#60*60
     * @param separatorIndex 分隔符位置
     * @param defalutExp 默认缓存时间
     * @return
     */
    protected long getExpiration(final String name, final int separatorIndex, final long defalutExp) {
        Long expiration = null;
        String expirationAsString = name.substring(separatorIndex + 1);
//        try {
//            if (pattern.matcher(expirationAsString).find()) {
//                expiration = NumberUtils.toLong(scriptEngine.eval(expirationAsString).toString(), defalutExp);
//            } else {
//                expiration = NumberUtils.toLong(expirationAsString, defalutExp);
//            }
//        } catch (ScriptException e) {
//            log.error("缓存时间转换错误:{},异常:{}", name, e.getMessage());
//        }
        try {
            expiration = Long.parseLong(expirationAsString);
        } catch (NumberFormatException ex) {
            log.error(String.format("Cannnot separate expiration time from cache: '%s'", name), ex);
        }

        return Objects.nonNull(expiration) ? expiration.longValue() : defalutExp;
    }

    public char getSeparator() {
        return separator;
    }

    public void setSeparator(char separator) {
        this.separator = separator;
    }
}
