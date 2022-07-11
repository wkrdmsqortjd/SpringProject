package com.vam.sample_java;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dustmq.sample.Restaurant;
import com.vam.config.RootConfig;

import lombok.extern.log4j.Log4j;

// class�� ������̼� ��� ����

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={RootConfig.class})
@Log4j
public class SampleTests {
 
	@Autowired
	private Restaurant restaurant;
	 
	@Test
	public void textExist() {
	 
	assertNotNull(restaurant);
	 
	log.info(restaurant);
	log.info("--------------------------------------");
	log.info(restaurant.getChef());
	 
	}
}

// 1. ������ �����ӿ�ũ�� ���۵Ǹ� ���� �������� ����ϴ� �޸𸮿����� ����� �Ǵµ�
// 	  �̸� ���ؽ�Ʈ�� �մϴ�. ������������ ApplicationContext��� �̸��� ��ü�� ��������ϴ�.
// 2. �������� �ڽ��� ��ü�� �����ϰ� �����ؾ� �ϴ� ��ü�鿡 ���� ������ �ʿ��մϴ�.
//	  root-context.xml or RootConfig.java(Java�� ���� ���)
// 3. root-context.xml�� �ִ� <Context:component-scan> �±� ������ ���� �ش� ��Ű���� ��ĵ
// 4. �ش� ��Ű���� �ִ� Ŭ������ �� @Component��� ������̼��� �����ϴ� Ŭ������ �ν��Ͻ��� ����
// 5. Restaurant ��ü�� Chef ��ü�� �ʿ��ϴٴ� @Autowired ������ �����Ƿ�,
//    ������ ��ü�� ���۷����� Restaurant ��ü�� ���� 
