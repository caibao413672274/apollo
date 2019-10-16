package com.unitop.apollo.demo;

import com.ctrip.framework.apollo.Config;
import com.ctrip.framework.apollo.ConfigChangeListener;
import com.ctrip.framework.apollo.ConfigService;
import com.ctrip.framework.apollo.model.ConfigChange;
import com.ctrip.framework.apollo.model.ConfigChangeEvent;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class Demo {
    private static final Logger logger = LoggerFactory.getLogger(Demo.class);
    private String DEFAULT_VALUE = "undefined";
    private Config config;

    public Demo() {
        ConfigChangeListener changeListener = new ConfigChangeListener() {
            @Override
            public void onChange(ConfigChangeEvent changeEvent) {
                logger.info("Changes for namespace {}", changeEvent.getNamespace());
                for (String key : changeEvent.changedKeys()) {
                    ConfigChange change = changeEvent.getChange(key);
                    logger.info("Change - key: {}, oldValue: {}, newValue: {}, changeType: {}",
                            change.getPropertyName(), change.getOldValue(), change.getNewValue(),
                            change.getChangeType());
                }
            }
        };
        config = ConfigService.getAppConfig();
        config.addChangeListener(changeListener);
    }

    private String getConfig(String key) {
        String result = config.getProperty(key, DEFAULT_VALUE);
        logger.info(String.format("Loading key : %s with value: %s", key, result));
        return result;
    }
    static ApplicationContext applicationContext=null;
    public static void main(String[] args) throws Exception{

//        applicationContext= new AnnotationConfigApplicationContext();
//        ((AnnotationConfigApplicationContext) applicationContext).register(MultiDataSourceConfiguration.class,ApolloDataSourceConfig.class);
//        ((AnnotationConfigApplicationContext) applicationContext).refresh();
        applicationContext = new ClassPathXmlApplicationContext("classpath:/applicationContext.xml");

        CustomPropertiesInfo bean1=applicationContext.getBean(CustomPropertiesInfo.class);
        System.out.println(bean1.getAppname());
        CustomPropertiesInfo2 bean2=applicationContext.getBean(CustomPropertiesInfo2.class);
        System.out.println(bean2.getAppname());
        DemoService demoService= applicationContext.getBean(DemoService.class);
        while (true){
            try {
                demoService.query();
            }catch (Exception ex)
            {
                ex.printStackTrace();
            }
            Thread.sleep(2*1000);
        }

//        Demo demo=new Demo();
//        System.out.println(
//                "Apollo Config Demo. Please input key to get the value. Input quit to exit.");
//        while (true) {
//            System.out.print("> ");
//            String input = new BufferedReader(new InputStreamReader(System.in, Charsets.UTF_8)).readLine();
//            if (input == null || input.length() == 0) {
//                continue;
//            }
//            input = input.trim();
//            if (input.equalsIgnoreCase("quit")) {
//                System.exit(0);
//            }
//            demo.getConfig(input);
//        }
    }
}
