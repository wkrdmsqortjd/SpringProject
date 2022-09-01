package com.dustmq.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dustmq.model.AttachImageVO;
import com.dustmq.model.BookVO;
import com.dustmq.model.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AdminMapperTests {
	
	@Autowired
	private AdminMapper mapper;
	
	/* 상품 등록 */
	@Test
	public void bookEnrollTest() throws Exception {
		
		BookVO book = new BookVO();
		
		for(int i = 0; i <= 90; i++) {
		book.setBookName("프로젝트 테스트");
		book.setAuthorId(12);
		book.setPubleYear("2021-03-18");
		book.setPublisher("출판사");
		book.setCateCode("100000");
		book.setBookPrice(20000);
		book.setBookStock(300);
		book.setBookDiscount(0.23);
		book.setBookIntro("책 소개 ");
		book.setBookContents("책 목차 ");
		
		System.out.println("Before BookVO :" + book);
		
		mapper.bookEnroll(book);
		}
		
		System.out.println("After BookVO :" + book);
	}
	
	/* 카테고리 리스트 */
	@Test
	public void cateListTest() throws Exception{
		
		System.out.println("cateList()..........." + mapper.cateList());
		
	}
	
	/* 상품 리스트 & 상품 총 갯수 */
	@Test
	public void goodsGetListTest() {
		
		Criteria cri = new Criteria();
		
		/* 검색조건 */
		cri.setKeyword("테스트");
		
		/* 검색 리스트 */
		List list = mapper.goodsGetList(cri);
		for(int i = 0; i < list.size(); i++) {
			System.out.println("result......." + i + " : " + list.get(i));
		}
		
		/* 상품 총 갯수 */
		int result = mapper.goodsGetTotal(cri);
		System.out.println("resutl.........." + result);
		
	}
	
	/* 상품 조회 페이지 */
	@Test
	public void goodsGetDetailTest() {
		
		int bookId = 50;
		
		BookVO result = mapper.goodsGetDetail(bookId);
		
		System.out.println("상품 조회 데이터 : " + result);
	}
	
	/* 상품 정보 수정 */
	@Test
	public void goodsModifyTest() {
		
		BookVO book = new BookVO();
		
		book.setBookId(102);
		book.setBookName("mapper 테스트");
		book.setAuthorId(94);
		book.setPubleYear("2021-03-18");
		book.setPublisher("출판사");
		book.setCateCode("103002");
		book.setBookPrice(20000);
		book.setBookStock(300);
		book.setBookDiscount(0.23);
		book.setBookIntro("책 소개 ");
		book.setBookContents("책 목차 ");
		
		mapper.goodsModify(book);
	}
	
	/* 수정 정보 삭제 */
	@Test
	public void goodsDeleteTest() {
		
		int bookId = 101;
		
		int result = mapper.goodsDelete(bookId);

		if(result == 1) {
			System.out.println("삭제 성공");
		}
	}
	
	/* 이미지 등록 */
	@Test
	public void imageEnrollTest() {
		
		AttachImageVO image = new AttachImageVO();
		
		image.setBookId(121);
		image.setFileName("test");
		image.setUploadPath("test");
		image.setUuid("test2");
		
		mapper.imageEnroll(image);
		
	}
	
	/* 지정한 상품 이미지 삭제 */
	@Test
	public void deleteImageAllTest() {
		
			int bookId = 158;
			
			mapper.deleteImageAll(bookId);
	}
	
	/* 어제자 날짜 이미지 리스트 */
	@Test
	public void checkImageListTest() {
		
		mapper.checkFileList();
	
	}

	/* 지정 상품 이미지 정보 얻기 */
	@Test
	public void getAttachInfoTest() {
		
		int bookId = 161;
		
		List<AttachImageVO> list = mapper.getAttachInfo(bookId);
		
		System.out.println("list : " + list);
	}

}