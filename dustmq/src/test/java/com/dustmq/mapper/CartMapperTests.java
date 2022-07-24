package com.dustmq.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dustmq.model.CartVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CartMapperTests {

	@Autowired
	private CartMapper cartMapper;
	
	/* 카트 추가 */
	@Test
	public void addCartTest() throws Exception {
			
		String memberId = "wkrdmsqortjd";
		int bookId = 282;
//		int bookId2 = 283;
//		int bookId3 = 284;
		int count = 2;
		
		CartVO cart = new CartVO();
		cart.setMemberId(memberId);
		cart.setBookId(bookId);
		cart.setBookCount(count);
		
		int result = 0;
		result = cartMapper.addCart(cart);
		
		System.out.println("결과 : " + result);
	}
	
	/* 카트 삭제 */
	@Test
	public void deleteCartTest() {
		
		int cartId = 4;
		
		cartMapper.deleteCart(cartId);
	}

	/* 카트 수량 수정 */
	@Test
	public void modifyCartTest() {
		
		int cartId = 5;
		int count = 10;
		
		CartVO cart = new CartVO();
		cart.setCartId(cartId);
		cart.setBookCount(count);
		
		cartMapper.modifyCart(cart);
	}
	
	/* 카트 목록 */ 
	@Test
	public void getCartTest() {
		
		String memberId = "wkrdmsqortjd";
		
		List<CartVO> list = cartMapper.getCart(memberId);
		
		for(CartVO cart : list) {
			System.out.println(cart);
			cart.initSaleTotal();
			System.out.println("init cart : " + cart);
		}
	}

	/* 카트 확인 */
	@Test
	public void checkCartTest() {
		
		String memberId = "wkrdmsqortjd";
		int bookId = 282;
		
		CartVO cart = new CartVO();
		cart.setMemberId(memberId);
		cart.setBookId(bookId);
		
		CartVO resutlCart = cartMapper.checkCart(cart);
		System.out.println("결과 : " + resutlCart);
		
	}
	
	/* 장바구니 제거 - 주문 처리 */
	@Test
	public void deleteOrderCart() {
		
		String memberId = "admin";
		int bookId = 285;
		
		CartVO cvo = new CartVO();
		cvo.setMemberId(memberId);
		cvo.setBookId(bookId);
		
		cartMapper.deleteOrderCart(cvo);
	}
}
