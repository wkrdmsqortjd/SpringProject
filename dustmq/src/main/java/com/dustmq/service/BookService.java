package com.dustmq.service;

import java.util.List;

import com.dustmq.model.BookVO;
import com.dustmq.model.CateVO;
import com.dustmq.model.Criteria;

public interface BookService {
	
	/* 상품 검색 */
	public List<BookVO> getGoodsList(Criteria cri);
	
	/* 상품 총 갯수 */
	public int goodsGetTotal(Criteria cri);
	
	/* 국내 카테고리 리스트 */
	public List<CateVO> getCateCode1();
	
	/* 국외 카테고리 리스트 */
	public List<CateVO> getCateCode2();
	
	/* 상품 정보 */
	public BookVO getGoodsInfo(int bookId);
}
