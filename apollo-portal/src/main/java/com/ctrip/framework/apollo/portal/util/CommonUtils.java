package com.ctrip.framework.apollo.portal.util;

import com.ctrip.framework.apollo.portal.spi.UserInfoHolder;

import java.text.MessageFormat;

public class CommonUtils {

    public static String getOperator(UserInfoHolder userInfoHolder){
        if(userInfoHolder==null||userInfoHolder.getUser()==null)return "System";
        else {
            return MessageFormat.format("{0}({1})", userInfoHolder.getUser().getName(), userInfoHolder.getUser().getUserId());
        }
    }
}
