 package com.dustmq.mapper;

import java.util.List;

import com.dustmq.model.BookVO;
import com.dustmq.model.MemberVO;
import com.dustmq.model.OrderItemVO;
import com.dustmq.model.OrderPageItemVO;
import com.dustmq.model.OrderVO;

public interface OrderMapper {

	/* 주문 상품 정보 - 페이지 */
	public OrderPageItemVO getGoodsInfo(int bookId);
	
	/* 주문 상품 정보 - 주문 처리 */
	public OrderItemVO getOrderInfo(int bookId);
	
	/* 주문 테이블 등록 - vam_order 테이블에 데이터 등록 */
	public int enrollOrder(OrderVO ovo);
	
	/* 주문 아이템 테이블에 등록 - vam_orderItem 테이블에 데이터 등록 */
	public int enrollOrderItem(OrderItemVO oriv);
	
	/* 주문 금액 차감 */
	public int deductMoney(MemberVO member);
	
	/* 상품 재고 차감 */
	public int deductStock(BookVO book);
	
	/* 주문 취소 */
	public int orderCancle(String orderId);

	/* 주문 상품 정보 - 주문 취소 */
	public List<OrderItemVO> getOrderItemInfo(String orderId);
	
	/* 주문 정보 - 주문 취소 */
	public OrderVO getOrder(String orderId);
	
	
}
