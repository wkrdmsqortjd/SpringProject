package com.dustmq.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dustmq.model.BookVO;
import com.dustmq.model.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BookMapperTests {
	
	@Autowired
	private BookMapper bookMapper;
	
	/* 상품 검색 테스트 */
	@Test
	public void getGoodListTest() {
		 
		Criteria cri = new Criteria();
		
		// 테스트 키워드
		cri.setKeyword("상세");
		
		System.out.println("cri : " + cri);
		
		List<BookVO> list = bookMapper.getGoodsList(cri);
		System.out.println("list : " + list);
		
		System.out.println("===========");
		int goodsTotal = bookMapper.goodsGetTotal(cri);
		System.out.println("total : " + goodsTotal);
	}
	
	/* 작가 id 리스트 요청 */
	@Test
	public void getAuthorId() {
		
		String Keyword = "테";
		
		String[] list = bookMapper.getAuthorIdList(Keyword);
		
		System.out.println("결과 : " + list.toString());
		
		for(String id : list) {
			System.out.println("개별 결과 : " + id);
		}
	}
	
	/* 검색(동적 쿼리 적용) - 작가 */
	@Test
	public void getGoodsListTest1() {
		
		Criteria cri = new Criteria();
		
		String type = "A";
//		String keyword = "김승현";	// DB에 등록된 작가
		String keyword = "없음";	// DB에 등록되지 않은 작가
		String catecode = "";
		
		cri.setType(type);
		cri.setKeyword(keyword);
		cri.setAuthorArr(bookMapper.getAuthorIdList(keyword));	// 작가의 authorId를 반환해서 AuthorArr에 대입
		cri.setCateCode(catecode);
		
		// 상품
		List<BookVO> list = bookMapper.getGoodsList(cri); 
		
		System.out.println("cri : " + cri);
		System.out.println("list : " + list);
		
	}
	
	/* 검색(동적 쿼리 적용) - 책 제목 */
	@Test
	public void getGoodsListTest2() {
		
		Criteria cri = new Criteria();
		String type = "T";
		String keyword = "테스트";
		String catecode = "";
		
		cri.setType(type);
		cri.setKeyword(keyword);
		cri.setAuthorArr(bookMapper.getAuthorIdList(keyword));
		cri.setCateCode(catecode);
		
		List<BookVO> list = bookMapper.getGoodsList(cri);
		
		System.out.println("cri : " + cri);
		System.out.println("list : " + list);
		
	}
	
	/* 검색(동적 쿼리 적용) - 카테고리 */
	@Test
	public void getGoodsListTest3() {
		
		Criteria cri = new Criteria();
		String type = "C";
		String keyword = "";
		String catecode = "101001";
		
		cri.setType(type);
		cri.setKeyword(keyword);
		cri.setAuthorArr(bookMapper.getAuthorIdList(keyword));
		cri.setCateCode(catecode);
		
		List<BookVO> list = bookMapper.getGoodsList(cri);
		
		System.out.println("cri : " + cri);
		System.out.println("list : " + list);
		
	}
	
	/* 검색(동적 쿼리 적용) - 카테고리 + 작가 */
	@Test
	public void getGoodsListTest4() {
		
		Criteria cri = new Criteria();
		String type = "AC";
//		String keyword = "테스트";		// 카테고리에 존재하는 작가
		String keyword = "일론머스크";	// 카테고리에 존재하지 않는 작가
		String catecode = "102001";
		
		cri.setType(type);
		cri.setKeyword(keyword);
		cri.setAuthorArr(bookMapper.getAuthorIdList(keyword));
		cri.setCateCode(catecode);
		
		List<BookVO> list = bookMapper.getGoodsList(cri);
		
		System.out.println("cri : " + cri);
		System.out.println("list : " + list);	
	}
	
/* 검색 (동적 쿼리 적용) - 카테고리 + 책 제목 */
	
	@Test 
	public void getGoodsListTest5() {
		
		Criteria cri = new Criteria();
		String type = "CT";			// 카테고리에 존재하는 책
		String keyword = "테스트";	// 카테고리에 존재하지 않는 책
		//String keyword = "없음";
		String catecode = "102001";
		
		cri.setType(type);
		cri.setKeyword(keyword);
		cri.setAuthorArr(bookMapper.getAuthorIdList(keyword));
		cri.setCateCode(catecode);
		
		List<BookVO> list = bookMapper.getGoodsList(cri);
		
		System.out.println("cri : " + cri);
		System.out.println("list : " + list);	
		
	}
	
	/* 카테고리 리스트 */
	@Test
	public void getCateListTest1() {
		
		Criteria cri = new Criteria();
		
		String type = "TC";
		String keyword = "테스트";
		// String type = "A";
		// String keyword = "아르마딜로";
		
		cri.setType(type);
		cri.setKeyword(keyword);
		// cri.setAuthorArr(bookMapper.getAuthorIdList(keyword));
		
		String[] cateList = bookMapper.getCateList(cri);
		
		for(String codeNum : cateList) {
				System.out.println("codeNum :::::::" + codeNum);
		}
	}
	
	/* 카테고리 정보 얻기 */	
	@Test
	public void getCateInfoTest1() {
		
		Criteria cri = new Criteria();
		
		String type = "TC";
		String keyword = "테스트";	
		String cateCode="101001";

		cri.setType(type);
		cri.setKeyword(keyword);
		cri.setCateCode(cateCode);
		
		bookMapper.getCateInfo(cri);
		
	}
	
	/* 상품 정보 */
	@Test
	public void getGoodsInfo() {
		int bookId = 280;
		BookVO goodsInfo = bookMapper.getGoodsInfo(bookId);
		
		System.out.println("===========================");
		System.out.println(goodsInfo);
		System.out.println("===========================");
	}
	
}
