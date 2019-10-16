package com.unitop.session;

import com.unitop.cache.config.redis.serializer.FastJsonRedisSerializer;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.annotation.AnnotationAttributes;
import org.springframework.core.type.AnnotationMetadata;
import org.springframework.data.redis.core.RedisOperations;
import org.springframework.scheduling.concurrent.ConcurrentTaskScheduler;
import org.springframework.session.data.redis.RedisFlushMode;
import org.springframework.session.data.redis.RedisOperationsSessionRepository;
import org.springframework.session.data.redis.config.annotation.web.http.RedisHttpSessionConfiguration;
import org.springframework.util.StringUtils;
import org.springframework.util.StringValueResolver;

import java.util.Map;

/**
 * Created by caizh on 2018-11-7.
 */
@Configuration
public class RedisHttpSessionConfigurationExt extends RedisHttpSessionConfiguration {
    private StringValueResolver stringValueResolver;

    @Override
    public void setEmbeddedValueResolver(StringValueResolver resolver) {
        this.stringValueResolver = resolver;
    }

    public Integer getMaxInactiveIntervalInSeconds() {
        return maxInactiveIntervalInSeconds;
    }

    private Integer maxInactiveIntervalInSeconds = 1800;
    private String redisNamespace = "";

    public RedisFlushMode getRedisFlushMode() {
        return redisFlushMode;
    }

    private RedisFlushMode redisFlushMode = RedisFlushMode.ON_SAVE;

    @Override
    public void setImportMetadata(AnnotationMetadata importMetadata) {
        Map<String, Object> enableAttrMap = importMetadata
                .getAnnotationAttributes(EnableRedisHttpSessionExt.class.getName());
        AnnotationAttributes enableAttrs = AnnotationAttributes.fromMap(enableAttrMap);

        String maxInactiveIntervalInSecondsValue = enableAttrs
                .getString("maxInactiveIntervalInSeconds");
        if (StringUtils.hasText(maxInactiveIntervalInSecondsValue)) {
            maxInactiveIntervalInSeconds = Integer.parseInt(this.stringValueResolver.resolveStringValue(maxInactiveIntervalInSecondsValue));
        } else {
            maxInactiveIntervalInSeconds = 36000;//10小时
        }
        this.setMaxInactiveIntervalInSeconds(maxInactiveIntervalInSeconds);
        String redisNamespaceValue = enableAttrs.getString("redisNamespace");
        if (StringUtils.hasText(redisNamespaceValue)) {
            redisNamespace = this.stringValueResolver.resolveStringValue(redisNamespaceValue);
            this.setRedisNamespace(redisNamespace);
        }
        redisFlushMode = enableAttrs.getEnum("redisFlushMode");
        this.setRedisFlushMode(redisFlushMode);
    }

    @Bean
    public ConcurrentTaskScheduler taskScheduler() {
        ConcurrentTaskScheduler taskScheduler = new ConcurrentTaskScheduler();

        return taskScheduler;
    }

    //    @Bean
//    @Override
//    public RedisMessageListenerContainer redisMessageListenerContainer(RedisConnectionFactory connectionFactory, RedisOperationsSessionRepository messageListener) {
//        return super.redisMessageListenerContainer(connectionFactory, messageListener);
//    }
    private String getRedisNamespace() {
        if (StringUtils.hasText(this.redisNamespace)) {
            return this.redisNamespace;
        }
        return System.getProperty("spring.session.redis.namespace", "");
    }

    //    @Autowired
//    RedisTemplate<Object, Object> redisTemplate;
    @Bean
    @Primary
    public RedisOperationsSessionRepository sessionRepository(@Qualifier("redisTemplate") RedisOperations<Object, Object> redisTemplate, ApplicationEventPublisher applicationEventPublisher) {
        RedisOperationsSessionRepository sessionRepository = new RedisOperationsSessionRepository(redisTemplate);

        FastJsonRedisSerializer<Object> serializer = new FastJsonRedisSerializer<>(Object.class);
        sessionRepository.setDefaultSerializer(serializer);

        sessionRepository.setApplicationEventPublisher(applicationEventPublisher);
        sessionRepository
                .setDefaultMaxInactiveInterval(this.getMaxInactiveIntervalInSeconds());

        String redisNamespace = getRedisNamespace();
        if (StringUtils.hasText(redisNamespace)) {
            //为了支持低版本中前缀：spring:session:
            if (!redisNamespace.startsWith("spring:session:")) {
                redisNamespace = "spring:session:".concat(redisNamespace);
            }
            sessionRepository.setRedisKeyNamespace(redisNamespace);
        }

        sessionRepository.setRedisFlushMode(this.redisFlushMode);

        return sessionRepository;
    }
}
