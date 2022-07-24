package com.dustmq.model;

import java.util.List;

public class OrderPageVO {

	/* 주문한 여러개의 상품 */
	private List<OrderPageItemVO> orders;

	public List<OrderPageItemVO> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderPageItemVO> orders) {
		this.orders = orders;
	}

	@Override
	public String toString() {
		return "OrderPageVO [orders=" + orders + "]";
	}
}
