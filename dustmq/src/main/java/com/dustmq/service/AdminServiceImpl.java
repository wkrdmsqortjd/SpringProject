package com.dustmq.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dustmq.mapper.AdminMapper;
import com.dustmq.model.AttachImageVO;
import com.dustmq.model.BookVO;
import com.dustmq.model.CateVO;
import com.dustmq.model.Criteria;
import com.dustmq.model.OrderVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j	// Logger 클래스를 사용하기 위한 어노테이션 (롬복)
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminMapper adminMapper;
	
	/* 상품등록 */
	@Transactional
	@Override
	public void bookEnroll(BookVO book) {
		
		log.info("(service)bookEnroll...........");
		
		adminMapper.bookEnroll(book);
		
		// 첨부한 이미지가 있는지 없는지 확인하고 없으면 bookEnroll()메서드를 조기 종료
		if(book.getImageList() == null || book.getImageList().size() <= 0) {
			return;
		}
	
		// bookVO 클래스의 imageList변수를 처리, 현재 BookVO에는 bookId의 값이 반환되어 저장되있음
		book.getImageList().forEach(attach ->{	// 람다식 활용한 for문, for(AttachImageVO attach : book.getImageList()) 와 같음
			
			// BookVO의 bookId 값을 imageList 요소에 있는 AttachImageVO의 bookId에 할당
			attach.setBookId(book.getBookId());
			
			// bookId의 정보를 알았으니 이미지의 정보를 불러올 수 있음
			adminMapper.imageEnroll(attach);
			
			
		});	// 람다식 for
	}

	@Override
	public List<CateVO> cateList() {
		
		return adminMapper.cateList();
	}

	/* 상품 리스트 */
	@Override
	public List<BookVO> goodsGetList(Criteria cri) {
		log.info("goodsGetTotalList()..........");
		return adminMapper.goodsGetList(cri);
	}

	/* 상품 총 갯수 */
	public int goodsGetTotal(Criteria cri) {
		log.info("goodsGetTotal().........");
		return adminMapper.goodsGetTotal(cri);
	}

	@Override
	public BookVO goodsGetDetail(int bookId) {
	
		log.info("(service)bookGetDetail....." + bookId);
		
		return adminMapper.goodsGetDetail(bookId);
	}

	/* 상품 수정 */
	@Transactional
	@Override
	public int goodsModify(BookVO book) {
		
		// 수정된 상품 정보를 DB에 반영하는 메서드로 호출하고 result에 대입
		int result = adminMapper.goodsModify(book);
		
		// 상품 수정 후 그 결과에 따른 이미지 정보를 수정하는 코드가 실행, 상품이 있는지 확인
		if(result == 1 && book.getImageList() != null && book.getImageList().size() > 0) {
			
			// 해당 상품의 이미지 정보가 모두 삭제
			adminMapper.deleteImageAll(book.getBookId());
			
			// List형태로 전달받은 이미지 정보를 각 요소 순서대로 이미지 정보를 DB에 저장되도록 코드 작성
			book.getImageList().forEach(attach -> {
				
				// AttachImageVO 객체에 bookId변수에 값을 할당 (넘어온 bookId의 값은 없기 때문에 할당해 줘야함)
				attach.setBookId(book.getBookId());
				adminMapper.imageEnroll(attach);
				
			});
		}
		
		return result;
	}

	/* 상품 삭제 */
	@Override
	@Transactional
	public int goodsDelete(int bookId) {

		log.info("(service)goodsDelete..............");
		
		// 이미지 정보 삭제
		adminMapper.deleteImageAll(bookId);
		
		return adminMapper.goodsDelete(bookId);
	}

	/* 지정 품 이미지 정보 얻기 */
	@Override
	public List<AttachImageVO> getAttachInfo(int bookId) {	
		
		log.info("getAttachInfo........");	
		
		return adminMapper.getAttachInfo(bookId);
	}

	/* 주문한 상품의 리스트 */
	@Override
	public List<OrderVO> getOrderList(Criteria cri) {
		
		return adminMapper.getOrderList(cri);
	}

	/* 주문 총 개수 */
	@Override
	public int getOrderTotal(Criteria cri) {
		
		return adminMapper.getOrderTotal(cri);
	}	

}
