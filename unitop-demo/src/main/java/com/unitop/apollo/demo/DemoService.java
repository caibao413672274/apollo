package com.unitop.apollo.demo;


import com.alibaba.fastjson.JSON;
import com.ctrip.framework.apollo.model.ConfigChange;
import com.ctrip.framework.apollo.model.ConfigChangeEvent;
import com.ctrip.framework.apollo.spring.annotation.ApolloConfigChangeListener;
import com.unitop.apollo.demo.mysql.TbTest;
import com.unitop.apollo.demo.mysql.TbTestMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by caizh on 2019-7-12.
 */
@Service
public class DemoService {
    private static final Logger logger = LoggerFactory.getLogger(DemoService.class);
    @Autowired
    TbTestMapper tbTestMapper;

    @Transactional
    public void add(){
        TbTest tbTest=new TbTest();
        tbTest.setId((int) (Math.random()*1000));
        tbTest.setName("Demo");
        tbTest.setRemark(Math.random()* 100 +"");
        System.out.println("mysql 库tb_test表插入数据:"+tbTest.toString());
        tbTestMapper.insertSelective(tbTest);
        tbTestMapper.updateByPrimaryKeySelective(tbTest);

    }
    @Transactional
    public void query(){
        TbTest tbTest=new TbTest();
        tbTest.setName("Demo");
        TbTest result=  tbTestMapper.selectOne(tbTest);
        System.out.println( JSON.toJSONString(result));
    }

}
