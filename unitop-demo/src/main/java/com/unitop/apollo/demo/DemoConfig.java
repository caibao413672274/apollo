package com.unitop.apollo.demo;

import com.ctrip.framework.apollo.spring.annotation.EnableApolloConfig;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableApolloConfig
public class DemoConfig {
    @Bean
    public CustomPropertiesInfo2 customPropertiesInfo2() {
        return new CustomPropertiesInfo2();
    }
}
