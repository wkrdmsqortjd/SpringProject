package com.dustmq.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dustmq.mapper.AdminMapper;
import com.dustmq.mapper.AttachMapper;
import com.dustmq.mapper.BookMapper;
import com.dustmq.model.AttachImageVO;
import com.dustmq.model.BookVO;
import com.dustmq.model.CateVO;
import com.dustmq.model.Criteria;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BookServiceImpl implements BookService {
	
	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private AdminMapper adminMapper;
	
	/* 상품 검색 */
	@Override
	public List<BookVO> getGoodsList(Criteria cri) {
		
		log.info("getGoodsList().......");
		
		String type = cri.getType();
		String[] typeArr = type.split("");
		String[] authorArr = bookMapper.getAuthorIdList(cri.getKeyword()); // 작가 조회
		
		
		if(type.equals("A") || type.equals("AC") || type.equals("AT") || type.equals("ACT")) {	// 작가 관련 검색
			if(authorArr.length == 0) {	// 찾는 작가가 없다면
				return new ArrayList();	// 빈 ArrayList를 반환
			}
		}
		
		for(String t : typeArr) {
			if(t.equals("A")) {					// 작가이면
				cri.setAuthorArr(authorArr);	// 작가 리스트에 set하게 됨
			}
		}		
		
		// 상품의 정보를 담고있는 BookVO객체가 List의 요소에 저장
		List<BookVO> list = bookMapper.getGoodsList(cri);
		
		// BookVO 객체 하나하나에 이미지 정보를 추가
		list.forEach(book -> {	// for( BookVO book : list ) 
			
				int bookId = book.getBookId();
				
				// 해당하는 bookId 번의 상품 이미지를 가져와 imageList 변수에 저장
				List<AttachImageVO> imageList = attachMapper.getAttachList(bookId);
				
				// 이미지를 저장
				book.setImageList(imageList);
		});
		
		return list;	// book; 아닌가 ?
	}
	
	/* 상품 총 갯수 */
	@Override
	public int goodsGetTotal(Criteria cri) {
		
		log.info("goodsGetTotal().......");
		
		return bookMapper.goodsGetTotal(cri);
	}

	/* 국내 카테고리 리스트 */
	@Override
	public List<CateVO> getCateCode1() {
		
		log.info("getCateCode1()..............");
		
		return bookMapper.getCateCode1();
	}

	/* 국외 카테고리 리스트 */
	@Override
	public List<CateVO> getCateCode2() {

		log.info("getCateCode2().........");
		
		return bookMapper.getCateCode2();
	}

	/* 상품 정보 */
	@Override
	public BookVO getGoodsInfo(int bookId) {

		BookVO goodsInfo = bookMapper.getGoodsInfo(bookId);
		
		// 받아온 상품 정보 데이터에 이미지 정보를 저장
		goodsInfo.setImageList(adminMapper.getAttachInfo(bookId));
		
		// 정보(상품 정보 + 이미지)가 담긴 BookVO 객체의 변수인 goodsInfo 리턴
		return goodsInfo;
	}

}
