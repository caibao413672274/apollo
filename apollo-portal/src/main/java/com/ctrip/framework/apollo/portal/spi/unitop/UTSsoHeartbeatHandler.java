package com.ctrip.framework.apollo.portal.spi.unitop;

import com.ctrip.framework.apollo.portal.spi.SsoHeartbeatHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UTSsoHeartbeatHandler  implements SsoHeartbeatHandler {
    @Override
    public void doHeartbeat(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.sendRedirect("unitop_sso_heartbeat.html");
        } catch (IOException e) {
        }
    }

}
