package com.unitop.cache.config.redis;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

/**
 * @author hesh
 */
@Component
@PropertySource(value="classpath:redis.properties",ignoreResourceNotFound = true)
public class RedisProperties implements InitializingBean {

    private static RedisProperties redisProperties = null;
    public static RedisProperties getRedisProperties() {
        return redisProperties;
    }

    /**
     * 最大能够保持空闲状态的链接数
     */
    @Value("${redis.pool.maxIdle:10}")
    private int maxIdle = 10;
    /**
     *在获取连接的时候检查有效性, 默认false
     */
    @Value("${redis.pool.testOnBorrow:false}")
    private boolean testOnBorrow;

    /**
     *在空闲时检查有效性, 默认false
     */
    @Value("${redis.pool.testWhileIdle:false}")
    private boolean testWhileIdle;

    /**
     * 最大连接数
     */
    @Value("${redis.pool.maxTotal:500}")
    private int maxTotal = 500;

    public int getMinIdle() {
        return minIdle;
    }

    public void setMinIdle(int minIdle) {
        this.minIdle = minIdle;
    }

    public boolean isTestOnBorrow() {
        return testOnBorrow;
    }

    public void setTestOnBorrow(boolean testOnBorrow) {
        this.testOnBorrow = testOnBorrow;
    }

    public boolean isTestWhileIdle() {
        return testWhileIdle;
    }

    public void setTestWhileIdle(boolean testWhileIdle) {
        this.testWhileIdle = testWhileIdle;
    }

    /**
     * 最小连接数
     */
    @Value("${redis.pool.minIdle:0}")

    private int minIdle=0;
    /**
     *获取连接时的最大等待毫秒数(如果设置为阻塞时BlockWhenExhausted),如果超时就抛异常,
     *  小于零:阻塞不确定的时间,  默认-1
     */
    @Value("${redis.pool.maxWaitMillis:3000}")
    private int maxWaitMillis = 3000;

    /**
     * #主机地址，默认：localhost
     */
    @Value("${redis.hostName:127.0.0.1}")
    private String hostName = "127.0.0.1";
    /**
     * #主机端口，默认：6379
     */
    @Value("${redis.port:6379}")
    private int port = 6379;
    /**
     *#超时时间，默认：2000
     */
    @Value("${redis.timeout:3000}")
    private int timeout = 3000;

    public String getInstance() {
        return instance;
    }

    public void setInstance(String instance) {
        this.instance = instance;
    }

    /**
     *redis使用实例模式。三种：cluster、shard、sentinel,默认cluster
     */

    @Value("${redis.instance:cluster}")
    private String instance = "cluster";


    @Value("${redis.password:}")
    private String password;

    /**
     * 是否使用连接池，默认true
     */
    @Value("${redis.usePool:true}")
    private boolean usePool=true;

    public int getDefaultexpiration() {
        return defaultexpiration;
    }

    public void setDefaultexpiration(int defaultexpiration) {
        this.defaultexpiration = defaultexpiration;
    }

    /**
     * Spring Redis缓存默认过期时间，默认值1小时
     */
    @Value("${redis.cache.defaultexpiration:3600}")
    private  int defaultexpiration;

    public boolean isEnable() {
        return enable;
    }

    public void setEnable(boolean enable) {
        this.enable = enable;
    }

    /**
     * redis 缓存启用
     */
    @Value("${redis.cache.enable:false}")
    private  boolean enable;

    public boolean isUsePrefix() {
        return usePrefix;
    }

    public void setUsePrefix(boolean usePrefix) {
        this.usePrefix = usePrefix;
    }

    /**
     *  Spring Redis缓存 是否使用前缀
     */
    @Value("${redis.cache.usePrefix:true}")
    private  boolean usePrefix;

    public int getTimeout() {
        return timeout;
    }

    public void setTimeout(int timeout) {
        this.timeout = timeout;
    }

    public boolean isUsePool() {
        return usePool;
    }

    public void setUsePool(boolean usePool) {
        this.usePool = usePool;
    }

    /**
     * Maximum number of redirects to follow when executing commands across the
     * cluster.
     *  默认值是5
     一般当此值设置过大时，容易报：Too many Cluster redirections
     */
    @Value("${redis.cluster.maxRedirects:5}")
    private int maxRedirects = 5;

    @Value("${redis.sentinel.mastername:}")
    private String mastername;

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }
    public int getMaxIdle() {
        return maxIdle;
    }

    public void setMaxIdle(int maxIdle) {
        this.maxIdle = maxIdle;
    }

    public int getMaxTotal() {
        return maxTotal;
    }

    public void setMaxTotal(int maxTotal) {
        this.maxTotal = maxTotal;
    }

    public int getMaxWaitMillis() {
        return maxWaitMillis;
    }

    public void setMaxWaitMillis(int maxWaitMillis) {
        this.maxWaitMillis = maxWaitMillis;
    }

    public String getHostName() {
        return hostName;
    }

    public void setHostName(String hostName) {
        this.hostName = hostName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getMaxRedirects() {
        return maxRedirects;
    }

    public void setMaxRedirects(int maxRedirects) {
        this.maxRedirects = maxRedirects;
    }

    public String getMastername() {
        return mastername;
    }

    public void setMastername(String mastername) {
        this.mastername = mastername;
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        redisProperties=this;
    }
}