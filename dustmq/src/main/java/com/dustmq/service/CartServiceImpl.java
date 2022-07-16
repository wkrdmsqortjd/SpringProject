package com.dustmq.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dustmq.mapper.AttachMapper;
import com.dustmq.mapper.CartMapper;
import com.dustmq.model.AttachImageVO;
import com.dustmq.model.CartVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CartServiceImpl implements CartService{
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	/* 장바구니 추가 */
	@Override
	public int addCart(CartVO cart) {
		
		// 장바구니 데이터 체크
		CartVO checkCart = cartMapper.checkCart(cart);
		
		if(checkCart != null) 	// 장바구니에 데이터가 있으면
				return 2;		// 2를 반환
		
		// 장바구니 등록 & 에러 시 0 반환
		try {
				return cartMapper.addCart(cart);	// 장바구니 등록
		} catch (Exception e) {
				return 0;							// 에러 발생 시 0반환
		}
	}

	/* 장바구니 정보 리스트 */
	@Override
	public List<CartVO> getCartList(String memberId) {
		
		List<CartVO> cart = cartMapper.getCart(memberId);
		
		for(CartVO vo : cart) {
				
				vo.initSaleTotal(); 
				
				/* 이미지 정보 얻기 */
				int bookId = vo.getBookId();
				
				List<AttachImageVO> imageList = attachMapper.getAttachList(bookId);
				
				vo.setImageList(imageList);
				
		}
		return cart;
	}
}
