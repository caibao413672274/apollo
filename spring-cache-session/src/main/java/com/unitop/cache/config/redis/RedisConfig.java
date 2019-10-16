package com.unitop.cache.config.redis;

import com.unitop.cache.config.ConditionKey;
import com.unitop.cache.config.redis.serializer.FastJsonRedisSerializer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.serializer.GenericToStringSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import redis.clients.jedis.JedisPoolConfig;

import javax.annotation.Resource;
import java.net.UnknownHostException;

/**
 * Created by caizh on 2018-10-24.
 */
public abstract class RedisConfig {
    //protected static final Logger LOGGER = LoggerFactory.getLogger(RedisConfig.class);


    @Resource
    protected RedisProperties redisProperties;

    protected JedisPoolConfig jedisPoolConfig() {
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        jedisPoolConfig.setMaxIdle(redisProperties.getMaxIdle());
        jedisPoolConfig.setMaxTotal(redisProperties.getMaxTotal());
        jedisPoolConfig.setMaxWaitMillis(redisProperties.getMaxWaitMillis());
        //最小空闲连接数, 默认0
        jedisPoolConfig.setMinIdle(redisProperties.getMinIdle());
        //在获取连接的时候检查有效性, 默认false
        jedisPoolConfig.setTestOnBorrow(redisProperties.isTestOnBorrow());
        jedisPoolConfig.setTestWhileIdle(redisProperties.isTestWhileIdle());
        return jedisPoolConfig;
    }

    protected abstract JedisConnectionFactory jedisConnectionFactory();

    @Bean
    @ConditionalOnProperty(name = ConditionKey.RedisHost)
    public StringRedisTemplate stringRedisTemplate() throws UnknownHostException {
        StringRedisTemplate template = new StringRedisTemplate();
        template.setConnectionFactory(jedisConnectionFactory());
        return template;
    }


    @Bean
    @Autowired
    @ConditionalOnProperty(name = ConditionKey.RedisHost)
    public RedisTemplate<String, Integer> integerRedisTemplate( JedisConnectionFactory connectionFactory) {
        RedisTemplate<String, Integer> redisTemplate = new RedisTemplate<>();
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setValueSerializer(new GenericToStringSerializer<>(Integer.class));
        redisTemplate.setConnectionFactory(connectionFactory);
        return redisTemplate;
    }


    @Bean
    @Autowired
    @ConditionalOnProperty(name = ConditionKey.RedisHost)
    public RedisTemplate<String, Long> longRedisTemplate(JedisConnectionFactory connectionFactory) {
        RedisTemplate<String, Long> redisTemplate = new RedisTemplate<>();
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setValueSerializer(new GenericToStringSerializer<>(Long.class));
        redisTemplate.setConnectionFactory(connectionFactory);
        return redisTemplate;
    }

    @Bean
    @Autowired
    @ConditionalOnProperty(name = ConditionKey.RedisHost)
    public RedisTemplate<String, Float> floatRedisTemplate (JedisConnectionFactory connectionFactory) {
        RedisTemplate<String, Float> redisTemplate = new RedisTemplate<>();
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setValueSerializer(new GenericToStringSerializer<>(Float.class));
        redisTemplate.setConnectionFactory(connectionFactory);
        return redisTemplate;
    }


    @Bean
    @Autowired
    @ConditionalOnProperty(name = ConditionKey.RedisHost)
    public RedisTemplate<String, Double> doubleRedisTemplate( JedisConnectionFactory connectionFactory) {
        RedisTemplate<String, Double> redisTemplate = new RedisTemplate<>();
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setValueSerializer(new GenericToStringSerializer<>(Double.class));
        redisTemplate.setConnectionFactory(connectionFactory);
        return redisTemplate;
    }

    @Bean
    @ConditionalOnProperty(name = ConditionKey.RedisHost)
    public RedisTemplate<Object, Object> redisTemplate() throws UnknownHostException   {
        RedisTemplate<Object, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(jedisConnectionFactory());
        template.setKeySerializer(new StringRedisSerializer());
//        Jackson2JsonRedisSerializer<Object> serializer = jackson2JsonRedisSerializer();
        FastJsonRedisSerializer<Object> serializer = new FastJsonRedisSerializer<>(Object.class);

        template.setValueSerializer(serializer);
        template.setHashKeySerializer(new StringRedisSerializer());
        template.setHashValueSerializer(serializer);

        return template;
    }
//    public Jackson2JsonRedisSerializer<Object> jackson2JsonRedisSerializer() {
//        final Jackson2JsonRedisSerializer<Object> jackson2JsonRedisSerializer = new Jackson2JsonRedisSerializer<>(Object.class);
//        final ObjectMapper objectMapper = Jackson2ObjectMapperBuilder
//                .json().build();
//        objectMapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
//        objectMapper.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_FINAL);
//        jackson2JsonRedisSerializer.setObjectMapper(objectMapper);
//        return jackson2JsonRedisSerializer;
//    }
}
