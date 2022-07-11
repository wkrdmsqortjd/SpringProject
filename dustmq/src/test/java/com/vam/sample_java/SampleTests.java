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

// class로 어노테이션 경로 지정

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

// 1. 스프링 프레임워크가 시작되면 먼저 스프링이 사용하는 메모리영역을 만들게 되는데
// 	  이를 컨텍스트라 합니다. 스프링에서는 ApplicationContext라는 이름의 객체가 만들어집니다.
// 2. 스프링은 자신이 객체를 생성하고 관리해야 하는 객체들에 대한 설정이 필요합니다.
//	  root-context.xml or RootConfig.java(Java의 설정 경우)
// 3. root-context.xml에 있는 <Context:component-scan> 태그 내용을 통해 해당 패키지를 스캔
// 4. 해당 패키지에 있는 클래스들 중 @Component라는 어노테이션이 존재하는 클래스의 인스턴스를 생성
// 5. Restaurant 객체는 Chef 객체가 필요하다는 @Autowired 설정이 있으므로,
//    스프링 객체의 레퍼런스를 Restaurant 객체에 주입 
