package com.dustmq.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dustmq.model.BookVO;
import com.dustmq.model.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BookServiceTests {
	
	@Autowired
	public BookService bookService;

	/* 상품 상세 정보 */
	@Test
	public void getGoodsInfoTest() {
		int bookId = 285;
		
		BookVO goodsInfo = bookService.getGoodsInfo(bookId);
	
		System.out.println("==결과==");
		System.out.println("전체 : " + goodsInfo);
		System.out.println("bookId : " + goodsInfo.getBookId() );
		System.out.println("이미지 정보 : " + goodsInfo.getImageList().isEmpty());
	}
	
	/* 카테고리 정보 - TC */
	@Test
	public void getCateInfoListTest1() {
		Criteria cri = new Criteria();
	
		String type = "TC";
		String keyword = "테스트";
//		String keyword = "없음";	
		String cateCode="103002";

		cri.setType(type);
		cri.setKeyword(keyword);
		cri.setCateCode(cateCode);
		
		System.out.println("List<CateFilterDTO> : " + bookService.getCateInfoList(cri));
		
	}
	
	/* 카테고리 정보 - AC */
	@Test
	public void getCateInfoListTest2() {
		Criteria cri = new Criteria();
	
		String type = "AC";
//		String keyword = "유홍준";	
		String keyword = "김승현";	
		String cateCode = "103002";

		cri.setType(type);
		cri.setKeyword(keyword);
		cri.setCateCode(cateCode);
		
		System.out.println("List<CateFilterDTO> : " + bookService.getCateInfoList(cri));
		
	}	

	/* 카테고리 정보 - T */
	@Test
	public void getCateInfoListTest3() {
		Criteria cri = new Criteria();
	
		String type = "T";
		String keyword = "테스트";
		//String keyword = "없음";	
		

		cri.setType(type);
		cri.setKeyword(keyword);
		
		System.out.println("List<CateFilterDTO> : " + bookService.getCateInfoList(cri));
		
	}	
	
	/* 카테고리 정보 - A */
	@Test
	public void getCateInfoListTest4() {
		Criteria cri = new Criteria();
	
		String type = "AC";
		//String keyword = "유홍준";	
		String keyword = "머스크";	
		

		cri.setType(type);
		cri.setKeyword(keyword);
		
		System.out.println("List<CateFilterDTO> : " + bookService.getCateInfoList(cri));
		
	}
	
}
