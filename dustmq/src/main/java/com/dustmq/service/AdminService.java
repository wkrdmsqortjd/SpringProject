package com.dustmq.service;

import java.util.List;

import com.dustmq.model.AttachImageVO;
import com.dustmq.model.BookVO;
import com.dustmq.model.CateVO;
import com.dustmq.model.Criteria;
import com.dustmq.model.OrderVO;

public interface AdminService {
	
	/* 상품등록 */
	public void bookEnroll(BookVO book);		

	/* 카테고리 리스트 */
	public List<CateVO> cateList();
	
	/* 상품 리스트 */
	public List<BookVO> goodsGetList(Criteria cri);
	
	/* 상품 총 개수 */
	public int goodsGetTotal(Criteria cri);	
	
	/* 상품 조회 페이지 */
	public BookVO goodsGetDetail(int bookId);
	
	/* 상품 수정 */
	public int goodsModify(BookVO book);
	
	/* 상품 수정 삭제 */
	public int goodsDelete(int bookId);
	
	/* 지정 상픔 이미지 정보 얻기 */
	public List<AttachImageVO> getAttachInfo(int bookId);
	
	/* 주문한 상품의 리스트 */
	public List<OrderVO> getOrderList(Criteria cri);
	
	/* 주문 총 개수 */
	public int getOrderTotal(Criteria cri);
	
}
