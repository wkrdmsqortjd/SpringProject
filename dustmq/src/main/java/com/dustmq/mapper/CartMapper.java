package com.dustmq.mapper;

import java.util.List;

import com.dustmq.model.CartVO;

public interface CartMapper {
	
	/* 카트 추가 */
	public int addCart(CartVO cart) throws Exception;
	
	/* 카트 삭제 */
	public int deleteCart(int cartId);
	
	/* 카트 수량 수정 */
	public int modifyCart(CartVO cart);
	
	/* 카트 목록 */
	public List<CartVO> getCart(String membetId);
	
	/* 카트 확인 */ // 조건에 맞는 row의 컬럼값을 가져오도록 반환타입 지정
	public CartVO checkCart(CartVO cart);
	
	/* 카트 제거 - 주문 후 카트에 있던 상품들 삭제 */
	public int deleteOrderCart(CartVO cvo);
}
