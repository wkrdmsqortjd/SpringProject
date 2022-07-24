package com.dustmq.mapper;

import java.util.List;

import com.dustmq.model.AttachImageVO;
import com.dustmq.model.BookVO;
import com.dustmq.model.CateVO;
import com.dustmq.model.Criteria;
import com.dustmq.model.OrderVO;

public interface AdminMapper {
	
	/* 상품 등록 */
	public void bookEnroll(BookVO book);

	/* 카테고리 리스트 */
	public List<CateVO> cateList();
	
	/* 상품 리스트 */
	public List<BookVO> goodsGetList(Criteria cri);	// 상품 목록 페이지에 출력될 페이징화 된 상품 데이턴
	
	/* 상품 총 개수 */
	public int goodsGetTotal(Criteria cri);	// 페이지 이동 인터페이스 객체를 인스턴스화 하는데 필요한 총 상품 개수
	
	/* 상픔 조회 페이지 */
	public BookVO goodsGetDetail(int bookId);
	
	/* 상품 수정 */
	public int goodsModify(BookVO book);

	/* 상품 정보 삭제 */
	public int goodsDelete(int bookId);
	
	/* 이미지 등록 */
	public void imageEnroll(AttachImageVO image);
	
	/* 지정 상품 이미지 전체 삭제 */
	public void deleteImageAll(int bookId);
	
	/* 어제자 날짜 이미지 리스트 */
	public List<AttachImageVO> checkFileList();
	
	/* 지정 상품 이미지 정보 얻기 */
	public List<AttachImageVO> getAttachInfo(int bookId);
	
	/* 주문한 상품 리스트 */
	public List<OrderVO> getOrderList(Criteria cri);
	
	/* 주문 총 개수 */
	public int getOrderTotal(Criteria cri);
	
	
}
