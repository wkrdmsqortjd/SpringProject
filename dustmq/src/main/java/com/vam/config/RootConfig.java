package com.vam.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
 
// Configuration�� ������ �����̳ʿ� �ش� Ŭ������ Bean ���� Class���� �˷��ִ� ������̼�
@Configuration
// Component-scan base-package �� ���� ȿ��
@ComponentScan(basePackages= {"com.dustmq.sample"})
public class RootConfig {
 
}
