package com.dustmq.service;

import java.util.List;

import com.dustmq.model.BookVO;
import com.dustmq.model.CateFilterVO;
import com.dustmq.model.CateVO;
import com.dustmq.model.Criteria;
import com.dustmq.model.ReplyVO;
import com.dustmq.model.SelectVO;

public interface BookService {
	
	/* 상품 검색 */
	public List<BookVO> getGoodsList(Criteria cri);
	
	/* 상품 총 갯수 */
	public int goodsGetTotal(Criteria cri);
	
	/* 국내 카테고리 리스트 */
	public List<CateVO> getCateCode1();
	
	/* 국외 카테고리 리스트 */
	public List<CateVO> getCateCode2();
	
	/* 검색결과 카테고리 필터 정보 */
	public List<CateFilterVO> getCateInfoList(Criteria cri);
	
	/* 상품 정보 */
	public BookVO getGoodsInfo(int bookId);
	
	/* 상품 id 이름 */
	public BookVO getBookIdName(int bookId);
	
	/* 평점 순 상품 정보 */
	public List<SelectVO> likeSelect();

}
