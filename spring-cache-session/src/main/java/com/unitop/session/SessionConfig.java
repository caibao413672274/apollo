package com.unitop.session;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

/**
 * Created by caizh on 2019-4-19.
 */
@Configuration
@EnableRedisHttpSessionExt(redisNamespace ="${spring.session.namespace:default}" ,maxInactiveIntervalInSeconds = "${spring.session.maxInactiveIntervalInSeconds:1800}")//10小时
@PropertySource(value="classpath:sessions.properties",ignoreResourceNotFound = true)
public class SessionConfig {
}
