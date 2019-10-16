package com.ctrip.framework.apollo.portal.spi.unitop;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.ctrip.framework.apollo.portal.component.config.PortalConfig;
import com.ctrip.framework.apollo.portal.entity.bo.UserInfo;
import com.ctrip.framework.apollo.portal.entity.vo.Organization;
import com.ctrip.framework.apollo.portal.spi.UserService;
import com.google.common.collect.Lists;
import com.unitop.sso.core.context.SSOContextHolder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.util.CollectionUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class UTUserService implements UserService {
    private static final Logger logger = LoggerFactory.getLogger(UTUserService.class);
    private RestTemplate restTemplate;

    private PortalConfig portalConfig;

    public UTUserService(PortalConfig portalConfig) {
        this.portalConfig = portalConfig;
        this.restTemplate = new RestTemplate(clientHttpRequestFactory());

    }

    private ClientHttpRequestFactory clientHttpRequestFactory() {
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(portalConfig.connectTimeout());
        factory.setReadTimeout(portalConfig.readTimeout());

        return factory;
    }
    private HttpEntity<MultiValueMap<String,String>> getRequest(MultiValueMap<String,String> map){
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        List<String> cookieList = new ArrayList<String>();
        cookieList.add("sso_sessionid=" + SSOContextHolder.getSessionId());
        headers.put(HttpHeaders.COOKIE,cookieList); //将cookie放入header
        return  new HttpEntity<MultiValueMap<String,String>>(map,headers);//将参数和header组成一个请求
    }
    /**
     * 判断字符串中是否包含中文
     * @param str
     * 待校验字符串
     * @return 是否为中文
     * @warn 不能校验是否为中文标点符号
     */
    public static boolean isContainChinese(String str) {
        Pattern p = Pattern.compile("[\u4e00-\u9fa5]");
        Matcher m = p.matcher(str);
        if (m.find()) {
            return true;
        }
        return false;
    }
    @Override
    public List<UserInfo> searchUsers(String keyword, int offset, int limit) {
        try {
            if(StringUtils.isEmpty(keyword)||(!isContainChinese(keyword)&&keyword.getBytes().length<=3))
                return Collections.emptyList();

            String postUrl=portalConfig.utSSOServerUrlPrefix()+"/user/searchUserByKey";
        MultiValueMap<String, String> map= new LinkedMultiValueMap<String, String>();
        map.add("key",keyword);

        ResponseEntity<String> result= restTemplate.postForEntity(postUrl,getRequest(map),String.class);

            List<HashMap<String, Object>> list = JSON.parseObject(result.getBody(), new TypeReference<List<HashMap<String, Object>>>() {
            });

            return convertToUserInfo(list);
        }catch (Exception ex){
            logger.error("调用 searchUsers 失败",ex);
            return Collections.emptyList();
        }
    }

    private List<UserInfo> convertToUserInfo(List<HashMap<String,Object>> list){
       if(CollectionUtils.isEmpty(list)) return Collections.emptyList();
        List<UserInfo> result = Lists.newArrayList();
        result.addAll(
                list.stream().map(this::transformMapToUserInfo)
                        .collect(Collectors.toList()));
        return result;
    }

    private UserInfo transformMapToUserInfo(HashMap<String,Object> map) {
        UserInfo userInfo = new UserInfo();
        String empKey="employeeID".toUpperCase();
        String emailKey="email".toUpperCase();
        String nameKey="name".toUpperCase();
        String depNoKey="deptcode".toUpperCase();
        String depNameKey="deptname".toUpperCase();
        String stationNoKey="stationno".toUpperCase();
        String stationNameKey="stationname".toUpperCase();

        if(map.containsKey(empKey))
        userInfo.setUserId((String)map.get(empKey));
        if(map.containsKey(emailKey))
            userInfo.setEmail((String)map.get(emailKey));
        if(map.containsKey(nameKey))
            userInfo.setName((String)map.get(nameKey));
        if(map.containsKey(depNoKey))
            userInfo.setOrgNo((String)map.get(depNoKey));
        if(map.containsKey(depNameKey))
            userInfo.setOrgName((String)map.get(depNameKey));
        if(map.containsKey(stationNoKey))
            userInfo.setStationNo((String)map.get(stationNoKey));
        if(map.containsKey(stationNameKey))
            userInfo.setStationName((String)map.get(stationNameKey));
        return userInfo;
    }
    @Override
    public UserInfo findByUserId(String userId) {
        List<UserInfo> userInfoList = this.findByUserIds(Lists.newArrayList(userId));
        if (CollectionUtils.isEmpty(userInfoList)) {
            return null;
        }
        return userInfoList.get(0);
    }

    @Override
    public List<UserInfo> findByUserIds(List<String> userIds) {
       try{
        String postUrl=portalConfig.utSSOServerUrlPrefix()+"/user/findByUserIds";
        MultiValueMap<String, String> map= new LinkedMultiValueMap<String, String>();
        map.add("userIds",String.join(",",userIds));
        ResponseEntity<String> result= restTemplate.postForEntity(postUrl,getRequest(map),String.class);
        List<HashMap<String,Object>> list= JSON.parseObject(result.getBody(),new TypeReference<List<HashMap<String,Object>>>(){});

        return convertToUserInfo(list);
       }catch (Exception ex){
           logger.error("调用 findByUserIds 失败",ex);
           return Collections.emptyList();
       }
    }

    public List<Organization> findConfigDep() {
        try {

            String postUrl=portalConfig.utSSOServerUrlPrefix()+"/user/findConfigDep";
            MultiValueMap<String, String> map= new LinkedMultiValueMap<String, String>();

            ResponseEntity<String> result= restTemplate.postForEntity(postUrl,getRequest(map),String.class);

            List<HashMap<String, Object>> list = JSON.parseObject(result.getBody(), new TypeReference<List<HashMap<String, Object>>>() {
            });
            if(CollectionUtils.isEmpty(list)) return Collections.emptyList();
            List<Organization> resultList = Lists.newArrayList();
            for(HashMap<String,Object> hashMap:list){
                Organization org=new Organization();

                if(hashMap.containsKey("ORGNAME")){
                    org.setOrgName((String)hashMap.get("ORGNAME"));
                }
                if(hashMap.containsKey("ORGID")){
                    org.setOrgId((String)hashMap.get("ORGID"));
                    resultList.add(org);
                }

            }
            return resultList;
        }catch (Exception ex){
            logger.error("调用 findConfigDep 失败",ex);
            return Collections.emptyList();
        }
    }
}
