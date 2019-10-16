package com.ctrip.framework.apollo.portal.spi.unitop;

import com.ctrip.framework.apollo.portal.component.config.PortalConfig;
import com.ctrip.framework.apollo.portal.spi.LogoutHandler;
import com.unitop.cache.config.redis.RedisOperate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.MessageFormat;

public class UTLogoutHandler  implements LogoutHandler{
    private static final Logger logger = LoggerFactory.getLogger(UTLogoutHandler.class);
    @Autowired
    private PortalConfig portalConfig;
    @Override
    public void logout(HttpServletRequest request, HttpServletResponse response) {
        //将session销毁
        HttpSession session = request.getSession(false);
        if (session != null) {
            try {
                String uid = session.getId();
                RedisOperate.delKey(uid);
            }catch (Exception ex){
                logger.error("删除配置中心会话失败,",ex);
            }
            session.invalidate();
        }

        Cookie cookie = new Cookie("sso_sessionid", null);
        //将cookie的有效期设置为0，命令浏览器删除该cookie
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);

        //重定向到SSO的logout地址
        String ssoServerUrlPrefix = portalConfig.utSSOServerUrlPrefix();
        String logoutUrl = portalConfig.utSSOLogoutUrl();

        try {
String service=MessageFormat.format("{0}://{1}:{2}/{3}",request.getScheme(),request.getServerName(),String.valueOf(request.getServerPort()),request.getContextPath());
            response.sendRedirect(ssoServerUrlPrefix + logoutUrl+"?service="+service);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
