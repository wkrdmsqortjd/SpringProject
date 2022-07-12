package com.dustmq.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dustmq.model.AttachImageVO;
import com.dustmq.model.BookVO;
import com.dustmq.model.Criteria;
import com.dustmq.model.PageDTO;
import com.dustmq.service.AttachService;
import com.dustmq.service.BookService;

// 메인페이지, 이동, 상품 검색 등의 요청을 관리

//@Log4j
@Controller
public class BookController {

	// 로그 기록을 남기기 위해 Logger 클래스 선언 (롬복은 @Log4j 선언해주면 된다)
	private static final Logger logger = LoggerFactory.getLogger(BookController.class);
	
	@Autowired
	private AttachService attachService;
	
	@Autowired
	private BookService bookService;
	
	/*  이미지 정보 반환 */			// 반환해주는 데이터가 JSON 형식이 되도록 produces 속성 추가
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> getAttachList(int bookId) {
		
		logger.info("getAttachList.........." + bookId);
		
		// 이미지 정보와 상태코드 데이터를 담고 있는 ResponseEntity 객체를 반환
		return new ResponseEntity(attachService.getAttachList(bookId), HttpStatus.OK);
	}
	
	
	/* 메인 페이지 이동 */
	@RequestMapping(value="/main", method = RequestMethod.GET)
	public void mainPageGET(Model model) {
		
		logger.info("메인 페이지 진입");
		
		// main.jsp에 카테고리 정보 전달
		model.addAttribute("cate1", bookService.getCateCode1());
		model.addAttribute("cate2", bookService.getCateCode2());
	}
	
	/* 이미지 출현 관련 */
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName) {	// fileName = '유동 경로' + '파일 이름'
		
		logger.info("getImage().............." + fileName);
		
		// 기본 경로 문자열 데이터와 전달받은 '유동 경로' + '파일 이름'을 활용하여 File 객체를 생성 후 대입
		File file = new File("C:\\upload\\" + fileName);
		
		// 뷰로 반환할 ResponseEntity 객체의 주소를 저장할 참조 변수 선언
		ResponseEntity<byte[]> result = null;
		
		try {
				
				// 응답 객체인 response의 header와 관련된 설정의 객체를 추가해주기 위해 HttpHeaders 생성
				HttpHeaders header = new HttpHeaders();
				
				// header의 Content-type에 대상 파일의 MIME TYPE을 부여해주는 코드 추가. add("속성명", 속성명의 값);
				header.add("Content-type", Files.probeContentType(file.toPath()));	
				
										  // ( 대상 이미지 파일, header 객체 , 상태코드 )
 				result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		} catch (IOException e) {
				e.printStackTrace();
		}
		
		return result;
	}
	
	/* 상품 검색 */
	@GetMapping("/search")
	public String searchGoodsGET(Criteria cri, Model model) {
		
		logger.info("cri : " + cri);
		
		// 상품 리스트를 가져옴
		List<BookVO> list = bookService.getGoodsList(cri);
		
		logger.info("pre list : " + list);
		
		if(!list.isEmpty()) {	// 상품이 존재한다면
			
			model.addAttribute("list", list);
			
			logger.info("list : " + list);
			
		} else {
			
			model.addAttribute("listcheck", "empty");
			
			return "search";
		}
		
		// pageMaker라는 키에 PageDTO객체를 값으로함(한 페이지에 총 게시물 수)
		model.addAttribute("pageMaker", new PageDTO(cri, bookService.goodsGetTotal(cri)));
		
		return "search";
	}
	
	/* 상품 상세 */
	@GetMapping("/goodsDetail/{bookId}") // 사용자가 전송한 식별자 값을 변수로 인식하도록 템플릿 변수 {bookId} 작성
	public String goodsDetailGET(@PathVariable("bookId")int bookId, Model model) {
		
		logger.info("goodsDetailGET().............");
		
		// 받아온 상품의 정보를 Model을 이용해 goodsDetail.jsp(view)로 반환
		model.addAttribute("goodsInfo", bookService.getGoodsInfo(bookId));
		
		return "/goodsDetail";
	}
}
