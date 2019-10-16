package com.unitop.apollo.demo.mysql;

import com.unitop.jdbc.config.IAthenaMapper;

public interface TbTestMapper extends IAthenaMapper<TbTest> {
    int deleteByPrimaryKey(Integer id);

    int insert(TbTest record);

    int insertSelective(TbTest record);

    TbTest selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TbTest record);

    int updateByPrimaryKey(TbTest record);
}