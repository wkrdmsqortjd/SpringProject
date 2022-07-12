package com.dustmq.service;

import com.dustmq.model.CartVO;

public interface CartService {
	
	/* 장바구니 추가 */
	public int addCart(CartVO cart);

}
