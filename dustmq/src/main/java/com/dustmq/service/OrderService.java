package com.dustmq.service;

import java.util.List;

import com.dustmq.model.OrderPageItemVO;
import com.dustmq.model.OrderVO;

public interface OrderService {
	
	/* 주문 상품 정보 */
	public List<OrderPageItemVO> getGoodsInfo(List<OrderPageItemVO> orders);

	/* 주문 */
	public void order(OrderVO ovo);
	
}
