package com.dustmq.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dustmq.mapper.AdminMapper;
import com.dustmq.mapper.AttachMapper;
import com.dustmq.mapper.BookMapper;
import com.dustmq.mapper.ReplyMapper;
import com.dustmq.model.AttachImageVO;
import com.dustmq.model.BookVO;
import com.dustmq.model.CateFilterVO;
import com.dustmq.model.CateVO;
import com.dustmq.model.Criteria;
import com.dustmq.model.ReplyVO;
import com.dustmq.model.SelectVO;
import com.dustmq.model.UpdateReplyVO;

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
	
	@Autowired
	private ReplyMapper replyMapper;
	
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
		
		// 상품의 정보를 goodsInfo에 저장
		BookVO goodsInfo = bookMapper.getGoodsInfo(bookId);
		
		// 받아온 상품 정보 데이터에 이미지 정보를 저장
		goodsInfo.setImageList(adminMapper.getAttachInfo(bookId));
		
		// 정보(상품 정보 + 이미지)가 담긴 BookVO 객체의 변수인 goodsInfo 리턴
		return goodsInfo;
	}

	/* 상품 id 이름 */
	@Override
	public BookVO getBookIdName(int bookId) {
		
		return bookMapper.getBookIdName(bookId);
	}

	/* 평점 순 상품 정보 - 4개 */
	@Override
	public List<SelectVO> likeSelect() {
	
		// 메인페이지에 노출시킬 상품 정보를 반환
		List<SelectVO> list = bookMapper.likeSelect();
		
		// 반환 받은 List객체에 담긴 SelectVO 객체에 해당 이미지 정보를 추가
		list.forEach(vo -> {	// for(SelectVO vo : list)
					
					int bookId = vo.getBookId();				// 회원 아이디
					double ratingAvg = vo.getRatingAvg();		// 회원 평균 점수
					
					List<AttachImageVO> imageList = attachMapper.getAttachList(bookId);
					
					vo.setImageList(imageList);
					
				});
		
		// 종합적인 정보들을 반환
		return list;
	}

	/* 검색결과 카테고리 필터 정보 */
	@Override
	public List<CateFilterVO> getCateInfoList(Criteria cri) {

		// 반환할 데이터가 담길 List<CateFilterVO>타입의 객체 생성
		List<CateFilterVO> filterInfoList = new ArrayList<CateFilterVO>();
		
		String[] typeArr = cri.getType().split("");
		String[] authorArr;
		
		// type 변수에 A가 포함된 경우 authorId 데이터가 필요
		for(String type : typeArr) {
			// type에 A가 있을경우 
			if(type.equals("A")) {
				 // 해당 검색에 필요한 authorId 데이터를 반환
				 authorArr = bookMapper.getAuthorIdList(cri.getKeyword());
				 
				 // authorArr 요소에 authorId가 없는 경우 
				 if(authorArr.length == 0) {
					 return filterInfoList;
				 }
				 
				 
				 // Criteria 객체에 authorId 데이터를 셋팅
				 cri.setAuthorArr(authorArr);
			 }
		}
		// 카테고리 리스트를 반환하여 문자열 배열인 cateList 객체에 저장
		String[] cateList = bookMapper.getCateList(cri);
		
		// 카테고리 코드(기존의 값)를 유지하기 위한 임시 변수에 카테고리 코드 저장
		String tempCateCode = cri.getCateCode();
		
		for(String cateCode : cateList) {
			cri.setCateCode(cateCode);
			CateFilterVO filterInfo = bookMapper.getCateInfo(cri);
			filterInfoList.add(filterInfo);
		}
		
		// 임시로 저장했던 카테고리 코드를 저장
		cri.setCateCode(tempCateCode);
	
		// 저장된 정보를 가진 객체 반환
		return filterInfoList;
	}
	
	/* 평점 세팅 */
	public void setRating(int bookId) {
		
		// 상품 평점 평균값을 반환 후 대입
		Double ratingAvg = replyMapper.getRatingAverage(bookId);
		
		if(ratingAvg == null) {		// 반환 값이 없으며
				ratingAvg = 0.0;	// 평균 값은 0.0
		}
		
		ratingAvg = (double) (Math.round(ratingAvg*10));
		ratingAvg = ratingAvg / 10;
		
		// 변수 저장
		UpdateReplyVO uvo = new UpdateReplyVO();
		uvo.setBookId(bookId);
		uvo.setRatingAvg(ratingAvg);
		
		// 구한 평균 평점 반영
		replyMapper.updateRating(uvo);
	}
}
