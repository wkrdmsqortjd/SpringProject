package com.dustmq.mapper;

import java.util.List;

import com.dustmq.model.BookVO;
import com.dustmq.model.CateFilterVO;
import com.dustmq.model.CateVO;
import com.dustmq.model.Criteria;
import com.dustmq.model.SelectVO;

public interface BookMapper {
	
	/* 상품 검색 */
	public List<BookVO> getGoodsList(Criteria cri);
	
	/* 상품 총 갯수 */
	public int goodsGetTotal(Criteria cri);
	
	/* 작가 id 리스트 요청 */
	public String[] getAuthorIdList(String keyword);
	
	/* 국내 카테고리 리스트 */
	public List<CateVO> getCateCode1();
	
	/* 국외 카테고리 리스트 */
	public List<CateVO> getCateCode2();
	
	/* 상품 정보 */
	public BookVO getGoodsInfo(int bookId);
	
	/* 검색 대상 카테고리 리스트 - 코드번호를 String 배열에 담아 반환 */
	public String[] getCateList(Criteria cri);
	
	/* 카테고리 정보( 카테고리 이름, 코드 번호 + 검색대상 수 ) */
	public CateFilterVO getCateInfo(Criteria cri);
	
	/* 상품 id 이름 */
	public BookVO getBookIdName(int bookId);
	
	/* 평점 순서 상품 정보 */
	public List<SelectVO> likeSelect();
	
}
