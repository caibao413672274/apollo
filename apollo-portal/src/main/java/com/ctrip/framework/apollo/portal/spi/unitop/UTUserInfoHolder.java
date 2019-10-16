package com.ctrip.framework.apollo.portal.spi.unitop;

import com.ctrip.framework.apollo.portal.entity.bo.UserInfo;
import com.ctrip.framework.apollo.portal.entity.po.UTUserPO;
import com.ctrip.framework.apollo.portal.repository.UTUserRepository;
import com.ctrip.framework.apollo.portal.spi.UserInfoHolder;
import com.unitop.sso.core.context.SSOContextHolder;
import com.unitop.sso.core.entity.UnitopUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import java.util.concurrent.ConcurrentHashMap;

public class UTUserInfoHolder  implements UserInfoHolder {
    private static final Logger logger = LoggerFactory.getLogger(UTUserInfoHolder.class);

    private UnitopLocalUserService localUserService;
    public UTUserInfoHolder(UnitopLocalUserService _localUserService){
        this.localUserService=_localUserService;

    }
    @Override
    public UserInfo getUser() {
        try{
        UnitopUser unitopUser= SSOContextHolder.getContextSSOUser();
        UserInfo userInfo = new UserInfo();
        if(unitopUser!=null) {
            userInfo.setUserId(unitopUser.getEmployeeID());
            userInfo.setName(unitopUser.getName());
            userInfo.setEmail(unitopUser.getEmail());
            userInfo.setOrgNo(unitopUser.getDeptCode());
            userInfo.setOrgName(unitopUser.getDeptName());
            userInfo.setStationName(unitopUser.getStationName());
            userInfo.setStationNo(unitopUser.getStationNo());
            if(!UnitopLocalUserService.existsUser(userInfo.getUserId())){

                //插入用户进表
               localUserService.addUserToLocal(userInfo);

            }
        }
        return userInfo;
        } catch (Exception e) {
            throw new RuntimeException("get user info from SSOContextHolder holder error", e);
        }
    }
}
