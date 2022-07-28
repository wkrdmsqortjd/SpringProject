package com.dustmq.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dustmq.mapper.AttachMapper;
import com.dustmq.mapper.BookMapper;
import com.dustmq.mapper.CartMapper;
import com.dustmq.mapper.MemberMapper;
import com.dustmq.mapper.OrderMapper;
import com.dustmq.model.AttachImageVO;
import com.dustmq.model.BookVO;
import com.dustmq.model.CartVO;
import com.dustmq.model.MemberVO;
import com.dustmq.model.OrderCancelVO;
import com.dustmq.model.OrderItemVO;
import com.dustmq.model.OrderPageItemVO;
import com.dustmq.model.OrderVO;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private BookMapper bookMapper;
	
	/* 주문 정보 */
	public List<OrderPageItemVO> getGoodsInfo(List<OrderPageItemVO> orders) {
		
		List<OrderPageItemVO> result = new ArrayList<OrderPageItemVO>();
		
		// for문을 통해 생성해 전달받은 주문상품의 데이터를 orv의 요소에 하나씩 저장
		for(OrderPageItemVO orv : orders) {
			
				// 받아온 정보를 goodsInfo에 저장
				OrderPageItemVO goodsInfo = orderMapper.getGoodsInfo(orv.getBookId());
				
				// 받아온 정보를 토대로 수량을 할당
				goodsInfo.setBookCount(orv.getBookCount());
				
				// 받아온 정보를 활용해 계산 정보 메서드를 호출 ( 계산금액 , 포인트 관련 세팅 ) 
				goodsInfo.initSaleTotal();
				
				// 상품 이미지 정보를 받아 저장
				List<AttachImageVO> imageList = attachMapper.getAttachList(goodsInfo.getBookId());	
				
				goodsInfo.setImageList(imageList);
				
				// 만들어야 할 상품정보가 모두 세팅된 result 객체 요소에 추가
				result.add(goodsInfo);
		}
		
		// 상품정보들이 요소로 추가된 List객체인 result 반환
		return result;
	}

	/* 주문 */
	@Override
	@Transactional	// 주문을 하려면 여러가지의 쿼리를 수행해야함
	public void order(OrderVO ovo) {

		/* 사용할 데이터 가져오기 */
		
		/* 회원 정보 */
		MemberVO member = memberMapper.getMemberInfo(ovo.getMemberId());
		
		List<OrderItemVO> orders = new ArrayList<>();	// 주문 상품들을 담을 List객체 생성
	
		/* 주문 정보 세팅*/
		for(OrderItemVO oiv : ovo.getOrders()) {
				OrderItemVO orderItem = orderMapper.getOrderInfo(oiv.getBookId());
				
				/* 수량 */
				orderItem.setBookCount(oiv.getBookCount());
				
				/* 기본 정보 */
				orderItem.initSaleTotal();
				
				/* List 객체에 추가 */
				orders.add(orderItem);
		}
		
		/* OrderVO 세팅 */
		ovo.setOrders(orders);
		ovo.getOrderPriceInfo();
		
		/* DB에 주문, 배송 정보, 주문 상품 삽입 */
		
		/* orderId 생성 , OrderVO 객체의 orderId에 대입 */
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("_yyyyMMddmm");
		String orderId = member.getMemberId() + format.format(date);
		ovo.setOrderId(orderId);
		
		/* 세팅된 주문 객체의 데이터를 등록 */
		orderMapper.enrollOrder(ovo);				// vam_order에 등록
		
		for(OrderItemVO oiv : ovo.getOrders()) {	// vam_orderItem에 등록
					oiv.setOrderId(orderId);
					orderMapper.enrollOrderItem(oiv);
		}
		
		/* 비용 변동 */
		int fluMoney = member.getMoney();			// 가지고 있는 돈
		fluMoney -= ovo.getOrderFinalSalePrice();	// 가지고 있는 금액에서 최종 금액을 차감
		member.setMoney(fluMoney);					// 변경된 돈 정보 삽입
		
		/* 포인트 변동 */
		int fluPoint = member.getPoint();			// 가지고 있는 포인트
		fluPoint = fluPoint - ovo.getUsePoint() + ovo.getOrderSavePoint();	// 사용포인트와 구매 시 획득하는 포인트를 계산
		member.setPoint(fluPoint);
		
		/* 변동된 돈, 포인트를 DB에 저장 */
		orderMapper.deductMoney(member);
		
		/* 재고 변동 */
		for(OrderItemVO oiv : ovo.getOrders()) {
			
				BookVO book = bookMapper.getGoodsInfo(oiv.getBookId());
				book.setBookStock(book.getBookStock() - oiv.getBookCount());
				
				/* 변동된 재고 DB에 저장 */
				orderMapper.deductStock(book);
		}
		
		/* 주문 후 장바구니 제거 */
		for(OrderItemVO oiv : ovo.getOrders()) {
				
				CartVO cart = new CartVO();
				cart.setMemberId(ovo.getMemberId());
				cart.setBookId(oiv.getBookId());
				
				cartMapper.deleteOrderCart(cart);
		}
	}

	/* 주문 취소 */
	@Override
	@Transactional
	public void orderCancle(OrderCancelVO ocvo) {

		MemberVO member = memberMapper.getMemberInfo(ocvo.getMemberId());	// 회원 정보
		
		/* 주문 상품 */
		List<OrderItemVO> orders = orderMapper.getOrderItemInfo(ocvo.getOrderId());	// 주문 상품 정보
		for(OrderItemVO order : orders) {
				order.initSaleTotal();		// 가격 정보
		}
		
		/* 주문 */
		OrderVO ords = orderMapper.getOrder(ocvo.getOrderId());	// 주문 정보
		ords.setOrders(orders);

		ords.getOrderPriceInfo();	// 주문에 필요한 데이터 세팅 (비용 , 포인트)
		
		/* 주문 상품 취소 DB 데이터(배송준비 -> 주문취소) */
		orderMapper.orderCancle(ocvo.getOrderId());
		
		/* 돈 */
		int fluMoney = member.getMoney();
		fluMoney += ords.getOrderFinalSalePrice();
		member.setMoney(fluMoney);
		
		/* 포인트 */
		int fluPoint = member.getPoint();
		fluPoint = fluPoint + ords.getUsePoint() - ords.getOrderSavePoint();
		member.setPoint(fluPoint);
		
		/* 재고 */
		orderMapper.deductMoney(member);
		
		// 주문한 상품들을 하나씩 order에 대입
		for(OrderItemVO order : ords.getOrders()) {
			
				BookVO book = bookMapper.getGoodsInfo(order.getBookId());
				book.setBookStock(book.getBookStock() + order.getBookCount());
				orderMapper.deductStock(book);
		}
	}

}
