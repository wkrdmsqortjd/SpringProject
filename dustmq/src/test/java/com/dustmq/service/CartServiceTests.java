package com.dustmq.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dustmq.model.CartVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CartServiceTests {

	@Autowired
	private CartService cartService;
	
		/* 등록 테스트 */
		@Test
		public void addCartTest() {
				
				//given
				String memberId = "admin";
				int bookId = 147;
				int count = 5;
				
				CartVO cvo = new CartVO(); 
				cvo.setMemberId(memberId);
				cvo.setBookId(bookId);
				cvo.setBookCount(count);
			
				//when
				int result = cartService.addCart(cvo);
			
				//then
				System.out.println("** result : " + result);
			
			
		}
}
