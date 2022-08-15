package com.dustmq.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dustmq.model.AttachImageVO;
import com.dustmq.model.AuthorVO;
import com.dustmq.model.BookVO;
import com.dustmq.model.Criteria;
import com.dustmq.model.MemberVO;
import com.dustmq.model.OrderCancelVO;
import com.dustmq.model.OrderVO;
import com.dustmq.model.PageDTO;
import com.dustmq.service.AdminService;
import com.dustmq.service.AuthorService;
import com.dustmq.service.MemberService;
import com.dustmq.service.OrderService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	private AuthorService authorService;

	@Autowired
	private AdminService adminService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private MemberService memberService;

	/* 관리자 메인 페이지 이동 */
	@RequestMapping(value = "main", method = RequestMethod.GET)
	public void adminMainGET() throws Exception {

		logger.info("관리자 페이지 이동");
	}

	/* 상품 관리(상품목록) 페이지 접속 */
	@RequestMapping(value = "goodsManage", method = RequestMethod.GET)
	public void goodsManageGET(Criteria cri, Model model) throws Exception {

		logger.info("상품 관리(상품 목록) 페이지 접속");

		/* 상품 리스트 데이터 */
		List list = adminService.goodsGetList(cri);

		if (!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
			return;
		}

		/* 페이지 인터페이스 데이터 */
		model.addAttribute("pageMaker", new PageDTO(cri, adminService.goodsGetTotal(cri)));
	}

	/* 상품 등록 페이지 접속 */
	@RequestMapping(value = "goodsEnroll", method = RequestMethod.GET)
	public void goodsEnrollGET(Model model) throws Exception {

		logger.info("상품 등록 페이지 접속");

		// JaKson-databind를 사용하기 위해 객체 생성
		ObjectMapper objm = new ObjectMapper();

		List list = adminService.cateList();

		// Java 객체인 list를 String 타입의 JSON 형식으로 데이터 변환
		String cateList = objm.writeValueAsString(list);

		model.addAttribute("cateList", cateList);

		// 변경 상태 확인
		logger.info("변경 전 .........." + list);
		logger.info("변경 후 .........." + cateList);

	}

	/* 작가 관리 페이지 접속 */
	// Criteria는 사용자가 요청하는 몇 페이지(pageNum), 몇 개의 작가 정보(amount)에 대한 정보를 받는데 사용
	@RequestMapping(value = "authorManage", method = RequestMethod.GET)
	public void authorManageGET(Criteria cri, Model model) throws Exception {

		logger.info("작가 관리 페이지 접속............" + cri);

		// 작가 목록 출력 데이터
		List list = authorService.authorGetList(cri); // 1 or 10

		if (!list.isEmpty()) {
			model.addAttribute("list", list); // List에 객체가 있으면, 작가 존재 o
		} else {
			model.addAttribute("listCheck", "empty"); // List에 객체가 없으면, 작가 존재 x
		}

		// 페이지 이동 인터페이스 데이터
//		int total = authorService.authorGetTotal(cri); 
//		PageDTO pageMaker = new PageDTO(cri, total);
//		System.out.println("pageMaker = " + pageMaker);
//		model.addAttribute("pageMaker", pageMaker);

		model.addAttribute("pageMaker", new PageDTO(cri, authorService.authorGetTotal(cri)));

	}

	/* 작가 등록 페이지 접속 */
	@RequestMapping(value = "authorEnroll", method = RequestMethod.GET)
	public void authorEnrollGET() throws Exception {

		logger.info("작가 등록 페이지 접속");
	}

	/* 작가 등록 */
	// 요청 받은 작가 관련 데이터를 받기 위해 매개변수로 추가
	// RedirectAttributes 객체는 해당 메서드가 종료된 뒤 리다이렉트 방식으로 다른 페이지로
	// 전송할 때 성공메세지를 전송하기 위해 추가
	// ( 리다이렉트 방식으로 이동할 때 데이터 전송을 위해 사용하는 Model 객체라고 생각하면 됨 )
	@RequestMapping(value = "authorEnroll.do", method = RequestMethod.POST)
	public String authorEnrollPOST(AuthorVO author, RedirectAttributes rttr) throws Exception {

		// 메서드에 들어온 기록과 VIEW로부터 전달받은 데이터를 확인하기 위한 로그 코드
		logger.info("authorEnroll :" + author);

		// 작가 등록 쿼리 수행
		authorService.authorEnroll(author);

		// 등록 성공을 알리는 데이터를 전송해주는 코드 추가, 1회성 사용 addFlashAttribute 메서드 사용
		rttr.addFlashAttribute("enroll_result", author.getAuthorName());

		return "redirect:/admin/authorManage"; // 작가 목록 페이지로 이동

	}

	/* 작가 상세, 정보 페이지 */
	@GetMapping({ "/authorDetail", "/authorModify" }) // Criteria는 상세페이지 이동 전 작가 관리 페이지의 정보.
														// 후에 상세 페이지에서 작가 관리 페이지로 다시 이동할 때 사용, 없으면 무조건 1페이지로 이동한다.
	public void authorGetInfoGET(int authorId, Criteria cri, Model model) throws Exception {

		logger.info("authorDetail......" + authorId);

		/* 작가 관리 페이지 정보 */
		model.addAttribute("cri", cri);

		/* 선택 작가 정보 */
		model.addAttribute("authorInfo", authorService.authorGetDetail(authorId));

	}

	/* 작가 정보 수정 */
	@PostMapping("/authorModify")
	public String authorModifyPOST(AuthorVO author, RedirectAttributes rttr) throws Exception {

		logger.info("authorModifyPost.........." + author);

		int result = authorService.authorModify(author);

		rttr.addFlashAttribute("modify_result", result);

		return "redirect:/admin/authorManage"; // 작가 관리 페이지로 이동

	}

	/* 작가 정보 삭제 */
	@PostMapping("/authorDelete")
	public String authorDeletePOST(int authorId, RedirectAttributes rttr) {

		logger.info("authorDeletePOST..........");

		int result = 0;

		try {

			result = authorService.authorDelete(authorId);

		} catch (Exception e) {

			e.printStackTrace();
			result = 2;
			rttr.addFlashAttribute("delete_result", result);

			return "redirect:/admin/authorManage";

		}

		rttr.addFlashAttribute("delete_result", result);

		return "redirect:/admin/authorManage";
	}

	/* 상품 조회 페이지 */
	@GetMapping({ "/goodsDetail", "/goodsModify" })
	public void goodsGetInfoGet(int bookId, Criteria cri, Model model) throws JsonProcessingException {

		logger.info("goodsGetInfo()........" + bookId);

		ObjectMapper mapper = new ObjectMapper(); // jackson 사용 객체

		/* 카테고리 리스트 데이터 */
		model.addAttribute("cateList", mapper.writeValueAsString(adminService.cateList()));

		/* 목록 페이지 조건 정보 */
		model.addAttribute("cri", cri);

		/* 조회 페이지 정보 */
		model.addAttribute("goodsInfo", adminService.goodsGetDetail(bookId));
	}

	/* 상품 등록 */
	@PostMapping("/goodsEnroll")
	public String goodsEnrollPOST(BookVO book, RedirectAttributes rttr) {

		logger.info("goodsEnrollPOST......" + book);

		adminService.bookEnroll(book);

		rttr.addFlashAttribute("enroll_result", book.getBookName()); // 상품 이름을 전달

		return "redirect:/admin/goodsManage";
	}

	/* 상품 정보 수정 */
	@PostMapping("/goodsModify")
	public String goodsModifyPOST(BookVO book, RedirectAttributes rttr) {

		logger.info("goodsModifyPOST....." + book);

		int result = adminService.goodsModify(book);

		rttr.addFlashAttribute("modify_result", result);

		return "redirect:/admin/goodsManage"; // 상품 관리 페이지로 이동

	}

	/* 상품 정보 삭제 */
	@PostMapping("/goodsDelete")
	public String goodsDeletePOST(int bookId, RedirectAttributes rttr) {

		logger.info("goodsDDeletePOST..............");

		// 서버에 있는 파일을 먼저 삭제를 제일 먼저 하기 위해 최상단에 구성

		// 이미지 정보 반환
		List<AttachImageVO> fileList = adminService.getAttachInfo(bookId);

		// 이미지 파일이 있다면
		if (fileList != null) {

			// 이미지 정보들을 보관할 참조변수 pathList
			List<Path> pathList = new ArrayList();

			fileList.forEach(vo -> {

				// 원본 이미지
				Path path = Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
				pathList.add(path);

				// 섬네일 이미지
				path = Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName());
				pathList.add(path);

			});

			pathList.forEach(path -> { // for( Path path : pathList )

				// 이미지 정보들을 파일화 해서 삭제
				path.toFile().delete();
			});
		}

		int result = adminService.goodsDelete(bookId);

		rttr.addFlashAttribute("delete_result", result);

		return "redirect:/admin/goodsManage";
	}

	/* 작가 검색 팝업창 */
	@GetMapping("/authorPop")
	public void authorPopGET(Criteria cri, Model model) throws Exception { // 작가 리스트 구현에 필요한 Criteria, Model을 매개변수로 받음

		logger.info("authorPopGET...........");

		// 팝업창의 크기가 작기 때문에 좀 더 작은 단위로 작가 데이터를 전송
		cri.setAmount(5);

		// 게시물 출력 데이터
		List list = authorService.authorGetList(cri);

		if (!list.isEmpty()) {
			model.addAttribute("list", list); // 작가 존재 o
		} else {
			model.addAttribute("listCHeck", "empty"); // 작가 존재 x
		}

		/* 페이지 이동 인터페이스 데이터 */
		model.addAttribute("pageMaker", new PageDTO(cri, authorService.authorGetTotal(cri)));
//		int total = authorService.authorGetTotal(cri); 
//		PageDTO pageMaker = new PageDTO(cri, total);
//		System.out.println("pageMaker = " + pageMaker);
//		model.addAttribute("pageMaker", pageMaker);

	}

	// =========================================================== 첨부파일
	// ================================================================

	/* 첨부 파일 업로드 */

	// 반환타입은 ResponseEntity 객체이고 Http의 Body에 추가될 데이터는 List<AttachImageVO>라는 의미
	// produces 속성은 서버에서 뷰로 전송되는 Response의 Content-type을 제어할 수 있는 속성 ( json데이터가
	// utf-8 인코딩 된 채로 속성값을 부여해야함 )
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile) { // 첨부파일 데이터를 전달받기 위해
																									// 매개변수 설정

		logger.info("uploadAjaxActionPOST.................");

		// ============================== 이미지 파일 체크 ===========================

		// 파일 유형을 체크하는 코드는 업로드를 수행하기 이전에 실행 되어야함
		for (MultipartFile multipartFile : uploadFile) {

			// 전달받은 파일(uploadFile)을 File 객체로 만들고 참조변수 checkfile에 대입
			File checkfile = new File(multipartFile.getOriginalFilename());

			// MIME TYPE을 저장할 String 타입의 type 변수를 선언하고 null로 초기화
			String type = null;

			try {
				type = Files.probeContentType(checkfile.toPath()); // probeContentType은 파라미터로 전달받은 파일의 MIME TYPE을
																	// 문자열(Stirng) 반환해주는 메서드
																	// 매개변수로 Path 객체를 전달받음. toPath()는 Path 객체로 만들기 위한
																	// 메서드
				logger.info("MIME TYPE : " + type);

			} catch (IOException e) {
				e.printStackTrace();
			}

			// MIME TYPE 이 image가 아닌 경우 구현부가 실행이 되는 if문 - image/gif, image/png, image/jpeg,
			// image/bmp, image/webp ( 앞이 image로 시작 )
			if (!type.startsWith("image")) {

				List<AttachImageVO> list = null; // 전달 해줄 파일의 정보는 없지만 반환타입 때문에 작성 null 값으로 초기화
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST); // 정보없이 400에러로 설정

			} // if

		} // for

		// ============================= 폴더 생성 부분 ================================

		String uploadFolder = "C:\\upload"; // 파일을 저장할 기본적 경로

		/* 날짜 폴더 경로 */
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Date를 통해 얻은 오늘의 날짜를 지정된 형식의 문자열 데이터로 생성하기 위해 사용

		Date date = new Date(); // 오늘의 날짜를 얻기 위해서 사용

		String str = sdf.format(date); // 오늘 날짜의 데이터를 가진 date변수를 "yyyy-MM-dd"형식의 문자열로 변환해주기 위해 format 메서드 사용

		String datePath = str.replace("-", File.separator); // 구분자 '-' 를 해당 운영체재에 맞게 변경하는 정적 변수인 separator 사용

		File uploadPath = new File(uploadFolder, datePath); // 원하는 경로를 객체 uploadPath 변수에 초기화
		System.out.println("uploadPath : " + uploadPath);

		// 폴더가 없으면
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs(); // 폴더를 생성(여러개) , mkdir은 한개
		}

		// ============================= 폴더 안에 이미지 파일 생성 부분
		// ====================================

		/* 이미지 정보를 담는 객체 (매개변수가 배열이므로 ArrayList 사용) */
		List<AttachImageVO> list = new ArrayList();

		// 향상된 for
		for (MultipartFile multipartFile : uploadFile) { // 업로드된 파일들을 string 형식으로 나열

			/* 이미지 정보 객체 */
			AttachImageVO vo = new AttachImageVO();

			/* 파일 이름 */
			String uploadFileName = multipartFile.getOriginalFilename();
			System.out.println("uploadFileName = " + uploadFileName);

			vo.setFileName(uploadFileName); // 원본 이름
			vo.setUploadPath(datePath); // 유동 경로

			/* uuid 적용 파일 이름 */
			String uuid = UUID.randomUUID().toString(); // UUID 타입이라 toString으로 문자열화 시킴
			vo.setUuid(uuid); // uuid

			uploadFileName = uuid + "_" + uploadFileName; // 구분자를 통해 일종의 일련번호인 uuid를 더해줌

			/* 파일 위치, 파일 이름을 합친 File 객체 */
			File saveFile = new File(uploadPath, uploadFileName);
			System.out.println("saveFile : " + saveFile);

			try {
				// 이미지들을 파일에 전송
				multipartFile.transferTo(saveFile);

				/* 썸네일 생성 */

				/*
				 * // 썸네일을 만들기 위해 File 객체 생성, 해당 날짜 폴더에 s_uuid_원본파일.png 형식으로 파일 생성 File
				 * thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				 * 
				 * // ImageIO의 read() 메서드를 호출하여 BufferedImage 타입으로 변경 후 변수에 대입, 원본 버퍼 이미지
				 * BufferedImage bo_image = ImageIO.read(saveFile);
				 * 
				 * // 비율 (소수점으로도 지정할 수 있도록 double타입) double ratio = 3;
				 * 
				 * // 넓이, 높이 int width = (int)(bo_image.getWidth() / ratio); // BuffedImage 클래스의
				 * 메서드 int height = (int) (bo_image.getHeight() / ratio); // BuffedImage 클래스의
				 * 메서드
				 * 
				 * // 썸네일 이미지 BufferedImage 객체를 생성해주고 참조 변수에 대입. 매개변수 ( 넓이 , 높이 , 생성될 이미지 타입 ),
				 * BufferedImage bt_image = new BufferedImage(width, height,
				 * BufferedImage.TYPE_3BYTE_BGR); // 일종의 크기를 지정해 흰색 도화지를 만드는 느낌
				 * 
				 * // 만든 도화지에 그림을 그리기 위해 Graphic2D 객체를 생성 Graphics2D graphic =
				 * bt_image.createGraphics();
				 * 
				 * // 도화지에 그림을 그리는 과정 graphic.drawImage(bo_image, 0, 0, width, height, null); //
				 * ( 목표 이미지, 좌표 x, 좌표 y , 넓이 , 높이 )
				 * 
				 * // 제작한 썸네일 이미지 (bt_image)를 파일로 만들어줌 ImageIO.write(bt_image, "png",
				 * thumbnailFile); // ( 파일로 저장할 이미지, 어떤 형식, 썸네일 이미지가 저장될 경로 )
				 */

				/* 방법 2 */
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);

				BufferedImage bo_image = ImageIO.read(saveFile);

				// 비율
				double ratio = 3;

				// 높이, 넓이
				int height = (int) (bo_image.getHeight() / ratio);
				int width = (int) (bo_image.getWidth() / ratio);

				Thumbnails.of(saveFile) // 지정된 파일에서 썸네일을 만들도록 지정
						.size(width, height).toFile(thumbnailFile); // 파일에다 썸넬 이미지를 만듦

			} catch (Exception e) {

				e.printStackTrace();

			}

			// 이미지 정보가 저장된 AttachImageVO 객체를 List의 요소로 추가
			list.add(vo);

		} // for

		ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK);
		return result;
	}

	/* 이미지 파일 삭제 */
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName) {

		logger.info("deleteFile.........." + fileName);

		File file = null;

		try {

			// 문자열 데이터에서 슬래시 혹은 역슬래시를 구분자로 하는 경로인데, 해당 구분자들은 encodeURIComponent()를 통해 인코딩되어
			// "%5", "%2F" 따위로
			// 변경되어 있기 때문에 이를 다시 디코딩 해주어 슬래시, 역슬래시를 설정 (File 객체를 생성하기 위해서 /, \ 필요)
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8")); // decode(대상, 어떠한 타입으로 인코딩 되었는지 정보
																					// 부여)

			// 파일 삭제
			file.delete();

			/* 원본 파일 삭제 */
			String originFileName = file.getAbsolutePath().replace("s_", "");

			logger.info("originFileName : " + originFileName);

			file = new File(originFileName);

			file.delete();

		} catch (Exception e) {

			e.printStackTrace();

			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);

		} // catch

		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	/* 주문 현황 페이지 */
	@GetMapping("/orderList")
	public String orderListGET(Criteria cri, Model model) {

		List<OrderVO> list = adminService.getOrderList(cri);
		
		if (!list.isEmpty()) { // List의 요소에 객체가 있다면
			model.addAttribute("list", list); // list의 정보를 뷰로 보내줌
			model.addAttribute("pageMaker", new PageDTO(cri, adminService.getOrderTotal(cri))); // 페이지 정보를 뷰로 전달
	
		} else { // 요소에 객체가 있다면
			model.addAttribute("listCheck", "empty");
		}

		return "/admin/orderList";
	}

	/* 주문 취소 (삭제) */
	@PostMapping("/orderCancel")
	public String orderCanclePOST(OrderCancelVO vo, HttpServletRequest request) {

		orderService.orderCancle(vo);

		/* 주문 취소시 해당 회원의 아이디로 로그인 되어서 있음
		 * 최신화 하기위한 회원 객체 생성 MemberVO member = new MemberVO();
		 * member.setMemberId(vo.getMemberId()); // 상품 취소한 회원 아이디를 세팅
		 * 
		 * 상품 취소 후 사용자 정보를 최신화
		 * 
		 * // 세션을 이용하기위해 선언 및 session을 가져옴 HttpSession session = request.getSession();
		 * 
		 * try { // 상품 취소한 회원의 로그인 정보를 memberLogin에 저장 MemberVO memberLogin =
		 * memberService.memberLogin(member);
		 * 
		 * // 비밀 번호는 그대로 유지하기 위해 "" 빈 칸을 저장(빈 칸을 저장하면 원래 비밀번호가 유지)
		 * memberLogin.setMemberPw("");
		 * 
		 * // session에 해당 회원의 정보를 저장 session.setAttribute("member", memberLogin);
		 * 
		 * } catch (Exception e) { e.printStackTrace(); }
		 */

		// 원래 있었던 페이지에 redirect 형식으로 이동
		return "redirect:/admin/orderList?keyword=" + vo.getKeyword() + "&amount=" + vo.getAmount() + "&pageNum="
				+ vo.getPageNum();
	}

}
