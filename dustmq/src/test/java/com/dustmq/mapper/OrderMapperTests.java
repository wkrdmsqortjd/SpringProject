package com.dustmq.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dustmq.model.BookVO;
import com.dustmq.model.MemberVO;
import com.dustmq.model.OrderItemVO;
import com.dustmq.model.OrderVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class OrderMapperTests {

	@Autowired
	private OrderMapper orderMapper;
	
	/* 상품 정보 - 주문 처리 */
	@Test
	public void getOrderInfoTest() {
		
		OrderItemVO orderInfo = orderMapper.getOrderInfo(61);
		
		System.out.println("result : " + orderInfo);
	}
	
	/* vam_order 테이블 등록 */
	@Test
	public void enrollOrderTest() {
		
		OrderVO ord = new OrderVO();
		List<OrderItemVO> orders = new ArrayList();
		
		OrderItemVO order1 = new OrderItemVO();
		
		order1.setBookId(285);
		order1.setBookCount(5);
		order1.setBookPrice(70000);
		order1.setBookDiscount(0.1);
		order1.initSaleTotal();
		
		ord.setOrders(orders);
		
		ord.setOrderId("2022_test1");
		ord.setCustomer("test");
		ord.setMemberId("wkrdmsqortjd");
		ord.setMemberAddr1("test");
		ord.setMemberAddr2("test");
		ord.setMemberAddr3("test");
		ord.setOrderState("배송중비");
		ord.getOrderPriceInfo();
		ord.setUsePoint(1000);
		
		orderMapper.enrollOrder(ord);		
		
	}
	
	/* vam_orderItem 테이블 등록 */
	@Test
	public void enrollOrderItemTest() {
		
		OrderItemVO ovo = new OrderItemVO();
		
		ovo.setOrderId("2022_test1");
		ovo.setBookId(285);
		ovo.setBookCount(1);
		ovo.setBookPrice(70000);
		ovo.setBookDiscount(0.1);
				
		ovo.initSaleTotal();
		
		orderMapper.enrollOrderItem(ovo);
		
	}	
	
	/* 회원이 가진 돈 과 포인트 차감 */
	@Test
	public void deductMoneyTest() {
		
		MemberVO member = new MemberVO();
		
		member.setMemberId("wkrdmsqortjd");
		member.setMoney(500000);
		member.setPoint(10000);
		
		orderMapper.deductMoney(member);
	}
	
	/* 상품 재고 변경 */
	@Test
	public void deductStockTest() {
		BookVO book = new BookVO();
		
		book.setBookId(285);
		book.setBookStock(77);
		
		orderMapper.deductStock(book);
	}
}
