package com.unitop.cache.config.redis;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.parser.Feature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.RedisZSetCommands.Tuple;
import org.springframework.data.redis.core.*;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * Redis操作
 * Created by caizh on 2018-10-25.
 */
@Component
public class RedisOperate {

    @Autowired(required = false)
    private RedisTemplate<String, String> redisTemplate;
    @Autowired(required = false)
    private RedisTemplate<String, Long> longRedisTemplate;
    @Autowired(required = false)
    private RedisTemplate<String, Float> floatRedisTemplate;

    private static RedisOperate redisOperate;

    @PostConstruct
    void init() {
        redisOperate = this;
    }

    /**
     * 将数据存入缓存
     *
     * @param key
     * @param value
     * @return
     */
    public static void saveString(String key, String value) {
        ValueOperations<String, String> vo = redisOperate.redisTemplate.opsForValue();
        vo.set(key, value);
    }

    /**
     * 将数据存入缓存（并设置失效时间）
     *
     * @param key
     * @param value
     * @param seconds
     * @return
     */
    public static void saveString(String key, String value, int seconds) {
        redisOperate.redisTemplate.opsForValue().set(key, value, seconds, TimeUnit.SECONDS);
    }

    /**
     * 从缓存中取得字符串数据
     *
     * @param key
     * @return 数据
     */
    public static String getString(String key) {
        return redisOperate.redisTemplate.opsForValue().get(key);
    }

    /**
     * 将数据存入缓存的集合中
     *
     * @param key
     * @param value
     * @return
     */
    public static void saveToSet(String key, String value) {
        SetOperations<String, String> so = redisOperate.redisTemplate.opsForSet();
        so.add(key, value);
    }

    /**
     *从Set集合中获取数据
     * @param key 缓存Key
     * @return keyValue
     * @author:mijp
     * @since:2017/1/16 13:23
     */
    public static String getFromSet(String key) {
        return redisOperate.redisTemplate.opsForSet().pop(key);
    }

    /**
     * 将 key的值保存为 value ，当且仅当 key 不存在。 若给定的 key 已经存在，则 SETNX 不做任何动作。 SETNX 是『SET
     * if Not eXists』(如果不存在，则 SET)的简写。 <br>
     * 保存成功，返回 true <br>
     * 保存失败，返回 false
     */
    public static boolean saveNX(String key, String value) {
        /** 设置成功，返回 1 设置失败，返回 0 **/
        return redisOperate.redisTemplate.execute((RedisCallback<Boolean>) connection -> {
            return connection.setNX(key.getBytes(), value.getBytes());
        });

    }

    /**
     * 将 key的值保存为 value ，当且仅当 key 不存在。 若给定的 key 已经存在，则 SETNX 不做任何动作。 SETNX 是『SET
     * if Not eXists』(如果不存在，则 SET)的简写。 <br>
     * 保存成功，返回 true <br>
     * 保存失败，返回 false
     *
     * @param key
     * @param value
     * @param expire 超时时间
     * @return 保存成功，返回 true 否则返回 false
     */
    public static boolean saveNX(String key, String value, int expire) {
        boolean ret = saveNX(key, value);
        if (ret) {
            redisOperate.redisTemplate.expire(key, expire, TimeUnit.SECONDS);
        }
        return ret;
    }



    /**
     * 将自增变量存入缓存
     */
    public static void saveLongSequence(String key, long seqNo) {
        redisOperate.longRedisTemplate.delete(key);
        redisOperate.longRedisTemplate.opsForValue().increment(key, seqNo);
    }



    /**
     * 将递增浮点数存入缓存
     */
    public static void saveFloatSequence(String key, float data) {
        redisOperate.floatRedisTemplate.delete(key);
        redisOperate.floatRedisTemplate.opsForValue().increment(key, data);
    }

    /**
     * 保存复杂类型数据到缓存
     *
     * @param key
     * @param obj
     * @return
     */
    public static void saveBean(String key, Object obj) {
        redisOperate.redisTemplate.opsForValue().set(key, JSON.toJSONString(obj));
    }

    /**
     * 保存复杂类型数据到缓存（并设置失效时间）
     *
     * @param key
     * @param obj
     * @param seconds
     * @return
     */
    public static void saveBean(String key, Object obj, int seconds) {
        redisOperate.redisTemplate.opsForValue().set(key, JSON.toJSONString(obj), seconds, TimeUnit.SECONDS);
    }

    /**
     * 功能: 存到指定的队列中<br />
     * 左进右出<br\>
     *
     * @param key
     * @param value
     * @param size  队列大小限制 0：不限制
     */
    public static void saveToQueue(String key, String value, long size) {
        ListOperations<String, String> lo = redisOperate.redisTemplate.opsForList();

        if (size > 0 && lo.size(key) >= size) {
            lo.rightPop(key);
        }
        lo.leftPush(key, value);
    }

    /**
     * 保存到hash集合中
     *
     * @param hName 集合名
     * @param key
     * @param value
     */
    public static void hashSet(String hName, String key, String value) {
        redisOperate.redisTemplate.opsForHash().put(hName, key, value);
    }

    /**
     * 根据key获取所有hash值
     *
     * @param key
     * @return
     */
    public static Map<String, String> hgetAll(String key) {
        HashOperations<String, String, String> operations = redisOperate.redisTemplate.opsForHash();
        return operations.entries(key);
    }

    /**
     * 保存到hash集合中
     *
     * @param <T>
     * @param hName 集合名
     * @param key
     * @param t
     */
    public static <T> void hashSet(String hName, String key, T t) {
        hashSet(hName, key, JSON.toJSONString(t));
    }

    /**
     * 取得复杂类型数据
     *
     * @param key
     * @param clazz
     * @return
     */
    public static <T> T getBean(String key, Class<T> clazz) {
        String value = redisOperate.redisTemplate.opsForValue().get(key);
        if (value == null) {
            return null;
        }
        return JSON.parseObject(value, clazz);
    }

    /**
     * 功能: 从指定队列里取得数据<br />
     * @param key
     * @param size 数据长度
     * @return
     */
    public static List<String> getFromQueue(String key, long size) {


        if (isCached(key)) {
            return new ArrayList<>();
        }
        ListOperations<String, String> lo = redisOperate.redisTemplate.opsForList();
        if (size > 0) {
            return lo.range(key, 0, size - 1);
        } else {
            return lo.range(key, 0, lo.size(key) - 1);
        }
    }

    /**
     * 功能: 从指定队列里取得数据<br />
     * @param key
     * @return
     */
    public static String popQueue(String key) {
        return redisOperate.redisTemplate.opsForList().rightPop(key);
    }

    /**
     * 取得序列值的下一个
     *
     * @param key
     * @return
     */
    public static Long getLongSequenceNext(String key) {
        return redisOperate.longRedisTemplate.execute((RedisCallback<Long>) connection -> {
            return connection.incr(key.getBytes());
        });
    }

    /**
     * 取得序列值的下一个
     *
     * @param key
     * @return
     */
    public static Long getLongSequenceNext(String key, long value) {
        return redisOperate.longRedisTemplate.execute((RedisCallback<Long>) connection -> {
            return connection.incrBy(key.getBytes(), value);
        });
    }

    /**
     * 将序列值回退一个
     *
     * @param key
     * @return
     */
    public static void getLongSequenceBack(String key) {
        redisOperate.longRedisTemplate.execute((RedisCallback<Long>) connection -> connection.decr(key.getBytes()));
    }

    /**
     * 从hash集合里取得指定key的数据
     *
     * @param hName
     * @param key
     * @return
     */
    public static String hashGet(String hName, String key) {
        HashOperations<String, String, String> operations = redisOperate.redisTemplate.opsForHash();
        return operations.get(hName, key);
    }
    /**
     * 从hash集合里取得指定key的数据，对象
     *
     * @param hName
     * @param key
     * @return
     */
    public static <T> T hashGet(String hName, String key, Class<T> clazz) {
        return JSON.parseObject(hashGet(hName, key), clazz);
    }

    /**
     * 增加浮点数的值
     *
     * @param key
     * @return
     */
    public static Double getFloatSequenceNext(String key, double incrBy) {
        return redisOperate.longRedisTemplate.execute((RedisCallback<Double>) connection -> {
            return connection.incrBy(key.getBytes(), incrBy);
        });
    }

    /**
     * 判断是否缓存了数据
     *
     * @param key 数据KEY
     * @return 判断是否缓存了
     */
    public static boolean isCached(String key) {
        return redisOperate.redisTemplate.execute((RedisCallback<Boolean>) connection -> {
            return connection.exists(key.getBytes());
        });
    }

    /**
     * 判断是否缓存在指定的集合中
     *
     * @param key   数据KEY
     * @param value 数据
     * @return 判断是否缓存了
     */
    public static boolean isMember(String key, String value) {
        return redisOperate.redisTemplate.execute((RedisCallback<Boolean>) connection -> {
            return connection.sIsMember(key.getBytes(), value.getBytes());
        });
    }

    /**
     * 从缓存中删除数据
     *
     * @param key
     * @return
     */
    public static void delKey(String key) {
        redisOperate.redisTemplate.execute((RedisCallback<Long>) connection -> connection.del(key.getBytes()));
    }

    /**
     * 设置超时时间
     *
     * @param key
     * @param seconds
     */
    public static void expire(String key, int seconds) {
        redisOperate.redisTemplate
                .execute((RedisCallback<Boolean>) connection -> connection.expire(key.getBytes(), seconds));

    }

    /**
     * 列出set中所有成员
     *
     * @param setName set名
     * @return
     */
    public static Set<String> getSet(String setName) {
        HashOperations<String, String, String> operations = redisOperate.redisTemplate.opsForHash();
        return operations.keys(setName);
    }

    /**
     * 向set中追加一个值
     *
     * @param setName set名
     * @param value
     */
    public static void saveSet(String setName, String value) {
        redisOperate.redisTemplate
                .execute((RedisCallback<Long>) connection -> connection.sAdd(setName.getBytes(), value.getBytes()));
    }

    /**
     * 逆序列出sorted set包括分数的set列表
     *
     * @param key   set名
     * @param start 开始位置
     * @param end   结束位置
     * @return 列表
     */
    public static Set<Tuple> getSortedSetWithScores(String key, int start, int end) {
        return redisOperate.redisTemplate.execute((RedisCallback<Set<Tuple>>) connection -> {
            return connection.zRevRangeWithScores(key.getBytes(), start, end);
        });
    }

    /**
     * 逆序取得sorted sort排名
     *
     * @param key    set名
     * @param member 成员名
     * @return 排名
     */
    public static Long getRankOfSortedSet(String key, String member) {
        return redisOperate.redisTemplate.execute((RedisCallback<Long>) connection -> {
            return connection.zRevRank(key.getBytes(), member.getBytes());
        });
    }

    /**
     * 根据成员名取得sorted sort分数
     *
     * @param key    set名
     * @param member 成员名
     * @return 分数
     */
    public static Double getScoreOfSortedSet(String key, String member) {
        return redisOperate.redisTemplate.execute((RedisCallback<Double>) connection -> {
            return connection.zScore(key.getBytes(), member.getBytes());
        });
    }

    /**
     * 向sorted set中追加一个值
     *
     * @param key    set名
     * @param score  分数
     * @param member 成员名称
     */
    public static void saveToSortedSet(String key, Double score, String member) {
        redisOperate.redisTemplate.execute(
                (RedisCallback<Boolean>) connection -> connection.zAdd(key.getBytes(), score, member.getBytes()));
    }

    /**
     * 从sorted set删除一个值
     *
     * @param key    set名
     * @param member 成员名称
     */
    public static void deleteFromSortedSet(String key, String member) {
        redisOperate.redisTemplate
                .execute((RedisCallback<Long>) connection -> connection.zRem(key.getBytes(), member.getBytes()));
    }

    /**
     * 判断hash集合中是否缓存了数据
     *
     * @param hName
     * @param key   数据KEY
     * @return 判断是否缓存了
     */
    public static boolean hashCached(String hName, String key) {
        return redisOperate.redisTemplate.execute((RedisCallback<Boolean>) connection -> {
            return connection.hExists(key.getBytes(), key.getBytes());
        });
    }

    /**
     * 从hash map中取得复杂类型数据
     *
     * @param key
     * @param field
     * @param clazz
     */
    public static <T> T getFromHash(String key, String field, Class<T> clazz) {
        byte[] input = redisOperate.redisTemplate.execute((RedisCallback<byte[]>) connection -> {
            return connection.hGet(key.getBytes(), field.getBytes());
        });
        return JSON.parseObject(input, clazz, Feature.AutoCloseSource);
    }

    /**
     * 从hashmap中删除一个值
     *
     * @param key   map名
     * @param field 成员名称
     */
    public static void deleteFromHash(String key, String field) {
        redisOperate.redisTemplate
                .execute((RedisCallback<Long>) connection -> connection.hDel(key.getBytes(), field.getBytes()));
    }

    /**
     * 保存到hash集合中 只在 key 指定的哈希集中不存在指定的字段时，设置字段的值。如果 key 指定的哈希集不存在，会创建一个新的哈希集并与
     * key 关联。如果字段已存在，该操作无效果。
     *
     * @param hashName 集合名
     * @param field
     * @param value
     */
    public static void setHashFieldValueNX(final String hashName, final String field, final String value) {
        redisOperate.redisTemplate.execute((RedisCallback<Boolean>) connection -> connection.hSetNX(hashName.getBytes(),
                field.getBytes(), value.getBytes()));
    }

    /**
     * 保存到hash集合中 只在 key 指定的哈希集中不存在指定的字段时，设置字段的值。如果 key 指定的哈希集不存在，会创建一个新的哈希集并与
     * key 关联。如果字段已存在，该操作无效果。
     *
     * @param <T>
     * @param hashName 集合名
     * @param field
     * @param t
     */
    public static <T> void setHashFieldValueNX(String hashName, String field, T t) {
        setHashFieldValueNX(hashName, field, JSON.toJSONString(t));
    }

    /**
     * 将所有指定的值插入到存于 key 的列表的头部。如果 key 不存在，那么在进行 push 操作前会创建一个空列表
     *
     * @param <T>
     * @param key
     * @param value
     * @return
     */
    public static <T> Long lpush(String key, T value) {
        return redisOperate.redisTemplate.opsForList().leftPush(key, JSON.toJSONString(value));
    }

    /**
     * 只有当 key 已经存在并且存着一个 list 的时候，在这个 key 下面的 list 的头部插入 value。 与 LPUSH 相反，当
     * key 不存在的时候不会进行任何操作
     *
     * @param key
     * @param value
     * @return
     */
    public static <T> Long lpushx(String key, T value) {
        return redisOperate.redisTemplate.opsForList().leftPushIfPresent(key, JSON.toJSONString(value));
    }

    /**
     * 返回存储在 key 里的list的长度。 如果 key 不存在，那么就被看作是空list，并且返回长度为 0
     *
     * @param key
     * @return
     */
    public static Long llen(String key) {
        return redisOperate.redisTemplate.opsForList().size(key);
    }

    /**
     * 返回存储在 key 的列表里指定范围内的元素。 start 和 end
     * 偏移量都是基于0的下标，即list的第一个元素下标是0（list的表头），第二个元素下标是1，以此类推
     *
     * @param key
     * @return
     */
    public static List<String> lrange(String key, long start, long end) {
        return redisOperate.redisTemplate.opsForList().range(key, start, end);
    }

    /**
     * 移除并且返回 key 对应的 list 的第一个元素
     *
     * @param key
     * @return
     */
    public static String lpop(String key) {
        return redisOperate.redisTemplate.opsForList().leftPop(key);
    }

    /**
     * 清空缓存数据库
     * @return
     */
    public  static boolean flushDb(){
     return redisOperate.redisTemplate.execute((RedisCallback<Boolean>)connection->{
            connection.flushDb();
         connection.flushAll();
        return true;
        });

    }
}
