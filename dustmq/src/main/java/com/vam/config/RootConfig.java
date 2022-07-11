package com.vam.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
 
// Configuration은 스프링 컨테이너에 해당 클래스를 Bean 구성 Class임을 알려주는 어노테이션
@Configuration
// Component-scan base-package 와 같은 효과
@ComponentScan(basePackages= {"com.dustmq.sample"})
public class RootConfig {
 
}
