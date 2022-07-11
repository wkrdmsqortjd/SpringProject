package com.dustmq.sample;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

// xml로 어노테이션 경로 지정

@RunWith(SpringJUnit4ClassRunner.class)	// 해당 클래스에 있는 테스트코드가 스프링을 실행하는 역할이라는 것을 표시
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") // 지정된 클래스나 문자열을 이용해서 필요한 객체들을 스프핑내 빈으로 등록
@Log4j	// Lombok을 이용해서 로그를 기록하는 Logger를 변수로 생성
public class SampleTests {
 
	// 자동 주입
	@Autowired
	private Restaurant restaurant;
	 
	// 테스트 코드
	@Test	
	public void textExist() {
	 
	// 검증하는 Assert메서드 
	assertNotNull(restaurant);
	 
	// Lombok의 @Log4j를 이용하여 로그를 기록
	log.info(restaurant);
	log.info("--------------------------------------");
	log.info(restaurant.getChef());	// lombok으로 @Data를 해놨기 때문에 setter & getter가 자동으로 생성
	 
		}
	}