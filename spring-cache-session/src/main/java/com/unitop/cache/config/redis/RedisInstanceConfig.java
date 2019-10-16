package com.unitop.cache.config.redis;

import com.unitop.cache.config.ConditionKey;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.data.redis.connection.*;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.util.StringUtils;
import redis.clients.jedis.JedisShardInfo;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by caizh on 2018-10-25.
 */
@Configuration
public class RedisInstanceConfig extends RedisConfig {
    protected final Logger logger = LoggerFactory.getLogger(RedisInstanceConfig.class);
    /**
     * 集群配置
     * @return
     */
    public RedisClusterConfiguration redisClusterConfiguration() {
        RedisClusterConfiguration redisClusterConfiguration = new RedisClusterConfiguration();
        Set<RedisNode> redisNodes = new HashSet<RedisNode>();
        redisNodes.add(new RedisClusterNode(redisProperties.getHostName(),redisProperties.getPort()));
        redisClusterConfiguration.setClusterNodes(redisNodes);
        if (!StringUtils.isEmpty(redisProperties.getPassword()))
        redisClusterConfiguration.setPassword(RedisPassword.of(redisProperties.getPassword()));

        redisClusterConfiguration.setMaxRedirects(redisProperties.getMaxRedirects());
        return redisClusterConfiguration;
    }

    /**
     * 哨兵配置
     * @return
     */
    protected RedisSentinelConfiguration redisSentinelConfiguration() {
        String[] hosts = redisProperties.getHostName().split(",");
        HashSet<String> sentinelHostAndPorts = new HashSet<>();
        for (String hn : hosts) {
            sentinelHostAndPorts.add(hn);
        }
        return new RedisSentinelConfiguration(redisProperties.getMastername(), sentinelHostAndPorts);
    }

    /**
     * 分片配置
     * @return
     */
    public JedisShardInfo redisShardConfiguration() {

        JedisShardInfo jedisShardInfo = new JedisShardInfo(redisProperties.getHostName(),redisProperties.getPort());
        if (!StringUtils.isEmpty(redisProperties.getPassword()))
            jedisShardInfo.setPassword(redisProperties.getPassword());
        return jedisShardInfo;
    }

    public static JedisConnectionFactory getJedisConnectionFactory() {
        return jedisConnectionFactory;
    }

    private static JedisConnectionFactory jedisConnectionFactory = null;

    @Bean
    @Override
    @ConditionalOnProperty(name = ConditionKey.RedisHost)
    public JedisConnectionFactory jedisConnectionFactory() {
        if(jedisConnectionFactory == null) {
            synchronized (RedisInstanceConfig.class) {
                if(jedisConnectionFactory == null) {
                    switch (redisProperties.getInstance()){
                        case "cluster":
                            jedisConnectionFactory = new JedisConnectionFactory(redisClusterConfiguration(),
                                    jedisPoolConfig());
                            break;
                        case "shard":
                            jedisConnectionFactory = new JedisConnectionFactory(redisShardConfiguration());
                            break;
                        case "sentinel":
                            jedisConnectionFactory = new JedisConnectionFactory(redisSentinelConfiguration(),
                                    jedisPoolConfig());
                            break;
                    }

//                    jedisConnectionFactory.setTimeout(redisProperties.getTimeout());
//                    jedisConnectionFactory.setUsePool(redisProperties.isUsePool());
                    if (!StringUtils.isEmpty(redisProperties.getPassword()))
                        jedisConnectionFactory.setPassword(redisProperties.getPassword());

                }
            }
        }
        logger.info("初始化Redis服务，Host:"+redisProperties.getHostName()+",实例模式:"+redisProperties.getInstance());
        return jedisConnectionFactory;
    }
}
