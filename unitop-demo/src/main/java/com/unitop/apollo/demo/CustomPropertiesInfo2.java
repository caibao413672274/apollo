package com.unitop.apollo.demo;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "app")
public class CustomPropertiesInfo2 {


    private String appname;

    private String jobadmin;

    public String getAppname() {
        return appname;
    }

    public void setAppname(String appname) {
        this.appname = appname;
    }

    public String getJobadmin() {
        return jobadmin;
    }

    public void setJobadmin(String jobadmin) {
        this.jobadmin = jobadmin;
    }
}
