package com.ctrip.framework.apollo.portal.spi.unitop;

import com.ctrip.framework.apollo.portal.entity.bo.UserInfo;
import com.ctrip.framework.apollo.portal.entity.po.UTUserPO;
import com.ctrip.framework.apollo.portal.repository.UTUserRepository;
import com.ctrip.framework.apollo.portal.spi.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import java.util.concurrent.ConcurrentHashMap;

public class UnitopLocalUserService {
    private static final Logger logger = LoggerFactory.getLogger(UnitopLocalUserService.class);
    private UTUserRepository utUserRepository;
    private UserService userService;
    public UnitopLocalUserService(UTUserRepository _utUserRepository,UserService _userService){
        this.utUserRepository=_utUserRepository;
        this.userService=_userService;
    }

    /**
     * 缓存所有存在的用户
     */
    static ConcurrentHashMap<String ,UserInfo> systemUsers=new ConcurrentHashMap<String ,UserInfo>();

    public static boolean existsUser(String userId){
        return  systemUsers.containsKey(userId);
    }
    public static void putUser(String user,UserInfo userInfo){
        systemUsers.put(user,userInfo);
    }
    public static void delUser(String userId){
        systemUsers.remove(userId);
    }

    /**
     * 获取本地用户信息
     * @param userId
     * @return
     */
    public UserInfo getLocalUser(String userId){
        if(systemUsers.containsKey(userId))return systemUsers.get(userId);
        else{
            UTUserPO userPO= utUserRepository.findByUserId(userId);
            UserInfo localUserInfo=null;
            if(userPO==null|| StringUtils.isEmpty(userPO.getUserId())){
                //如果本地没有，从远程获取同步进来
                localUserInfo= userService.findByUserId(userId);
            }
            else{
                localUserInfo= userPO.toUserInfo();
            }
            if(localUserInfo!=null&&!systemUsers.containsKey(userId)) {
                putUser(userId, localUserInfo);
                saveToLocal(localUserInfo);
            }
            if(systemUsers.containsKey(userId))return systemUsers.get(userId);
            else
            return null;
        }

    }

    /**
     * 添加用户到本地数据库
     * @param userInfo
     */
    public void addUserToLocal(UserInfo userInfo){
        putUser(userInfo.getUserId(),userInfo);
        //插入用户进表
        UTUserPO userPO= utUserRepository.findByUserId(userInfo.getUserId());
        if(userPO==null|| StringUtils.isEmpty(userPO.getUserId())){
            saveToLocal(userInfo);
        }
    }
    private void saveToLocal(UserInfo userInfo){

                UTUserPO adduser=new UTUserPO();
        adduser.setEmail(userInfo.getEmail());
        adduser.setUserId(userInfo.getUserId());
        adduser.setUsername(userInfo.getName());
        adduser.setOrgName(userInfo.getOrgName());
        adduser.setOrgNo(userInfo.getOrgNo());
        adduser.setStationName(userInfo.getStationName());
        adduser.setStationNo(userInfo.getStationNo());
        try {
            UTUserPO    userPO = utUserRepository.save(adduser);
            if (userPO == null || userPO.getId() == 0)
                systemUsers.remove(userInfo.getUserId());
            logger.debug("保存用户成功：{}",userPO);
        }catch (Exception ex){
            logger.error("保存用户失败，",ex);
        }
    }
}
