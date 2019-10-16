package com.ctrip.framework.apollo.portal.controller;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.ctrip.framework.apollo.portal.component.config.PortalConfig;
import com.ctrip.framework.apollo.portal.entity.vo.Organization;
import com.ctrip.framework.apollo.portal.spi.unitop.UTUserService;
import com.unitop.cache.config.redis.RedisOperate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Jason Song(song_s@ctrip.com)
 */
@RestController
@RequestMapping("/organizations")
public class OrganizationController {

  private final PortalConfig portalConfig;

  public OrganizationController(final PortalConfig portalConfig) {
    this.portalConfig = portalConfig;
  }

  @Autowired
  private UTUserService utUserService;
  private String orgCacheKey="OrgConfigList";
  private static List<Organization> LocalOrgCache=null;
  private static long lastLoadTime=0L;
  @RequestMapping
  public List<Organization> loadOrganization() {
    List<Organization> result=new ArrayList<Organization>();
    //从SSO中获取
    if(LocalOrgCache==null)LocalOrgCache=new ArrayList<Organization>();
    if((lastLoadTime+(30*60*1000))<System.currentTimeMillis()||LocalOrgCache.size()==0) {
      String key = portalConfig.getValue("spring.session.namespace", "ApolloPortal") + ":" + orgCacheKey;
      String jsonStr = RedisOperate.getString(key);
      if (StringUtils.isEmpty(jsonStr)) {
        result = utUserService.findConfigDep();
        RedisOperate.saveBean(key, result);
      } else {
        result = JSON.parseObject(jsonStr, new TypeReference<List<Organization>>() {
        });
      }
      lastLoadTime=System.currentTimeMillis();
      LocalOrgCache = result;
      return result;
    }else{
      return LocalOrgCache;
    }

//        return portalConfig.organizations();
  }
}
