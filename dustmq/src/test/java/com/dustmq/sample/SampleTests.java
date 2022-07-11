package com.dustmq.sample;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

// xml�� ������̼� ��� ����

@RunWith(SpringJUnit4ClassRunner.class)	// �ش� Ŭ������ �ִ� �׽�Ʈ�ڵ尡 �������� �����ϴ� �����̶�� ���� ǥ��
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") // ������ Ŭ������ ���ڿ��� �̿��ؼ� �ʿ��� ��ü���� �����γ� ������ ���
@Log4j	// Lombok�� �̿��ؼ� �α׸� ����ϴ� Logger�� ������ ����
public class SampleTests {
 
	// �ڵ� ����
	@Autowired
	private Restaurant restaurant;
	 
	// �׽�Ʈ �ڵ�
	@Test	
	public void textExist() {
	 
	// �����ϴ� Assert�޼��� 
	assertNotNull(restaurant);
	 
	// Lombok�� @Log4j�� �̿��Ͽ� �α׸� ���
	log.info(restaurant);
	log.info("--------------------------------------");
	log.info(restaurant.getChef());	// lombok���� @Data�� �س��� ������ setter & getter�� �ڵ����� ����
	 
		}
	}