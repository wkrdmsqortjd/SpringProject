package com.dustmq.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dustmq.model.BookVO;

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
}
