package com.unitop.session;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.session.data.redis.RedisFlushMode;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

/**
 * Created by caizh on 2018-11-7.
 */
@Retention(java.lang.annotation.RetentionPolicy.RUNTIME)
@Target({ java.lang.annotation.ElementType.TYPE })
@Documented
@Import(RedisHttpSessionConfigurationExt.class)
@Configuration
public @interface EnableRedisHttpSessionExt {
    String maxInactiveIntervalInSeconds() default "1800";

    /**
     * <p>
     * Defines a unique namespace for keys. The value is used to isolate sessions by
     * changing the prefix from "spring:session:" to
     * "spring:session:&lt;redisNamespace&gt;:". The default is "" such that all Redis
     * keys begin with "spring:session".
     * </p>
     *
     * <p>
     * For example, if you had an application named "Application A" that needed to keep
     * the sessions isolated from "Application B" you could set two different values for
     * the applications and they could function within the same Redis instance.
     * </p>
     *
     * @return the unique namespace for keys
     */
    String redisNamespace() default "default";

    /**
     * <p>
     * Sets the flush mode for the Redis sessions. The default is ON_SAVE which only
     * updates the backing Redis when
     * {@link SessionRepository#save(org.springframework.session.Session)} is invoked. In
     * a web environment this happens just before the HTTP response is committed.
     * </p>
     * <p>
     * Setting the value to IMMEDIATE will ensure that the any updates to the Session are
     * immediately written to the Redis instance.
     * </p>
     *
     * @return the {@link RedisFlushMode} to use
     * @since 1.1
     */
    RedisFlushMode redisFlushMode() default RedisFlushMode.ON_SAVE;
}
