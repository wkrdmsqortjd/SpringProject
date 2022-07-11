package com.dustmq.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dustmq.model.MemberVO;
import com.dustmq.service.MemberService;

@Controller
@RequestMapping(value="/member")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired 
	private MemberService memberservice;
	
	@Autowired	
	private JavaMailSender mailSender;	// 메일 전송에 필요한 정보를 세팅

	@Autowired
    private BCryptPasswordEncoder pwEncoder;	// 스프링 시큐리티
	
	// 회원가입 페이지 이동
	@RequestMapping(value="join", method=RequestMethod.GET)
	public void loginGET() {
		
		logger.info("회원가입 페이지 진입");
		
	}
	
	// 회원가입
	@RequestMapping(value="/join", method=RequestMethod.POST)
	// join.jsp에서 전달한 데이터를 매개변수 member에 저장?
	public String joinPost(MemberVO member) throws Exception {
		
		String rawPw = ""; 		// 인코딩 전 비밀번호
		String encodePw = ""; 	// 인코딩 후 비밀번호
		
		rawPw = member.getMemberPw();		// 비밀번호 데이터를 얻음
		encodePw = pwEncoder.encode(rawPw);	// 비밀번호 인코딩
		member.setMemberPw(encodePw);		// 인코딩 한 비밀번호를 다시 member객체에 저장
		
		/* 회원가입 쿼리 실행 */
		memberservice.memberJoin(member);
		
		return "redirect:/main";	// 다시 메인페이지로 이동
	}
	
	// 아이디 중복 검사
	@RequestMapping(value="/memberIdChk", method=RequestMethod.POST)
	// 스프링에서 비동기 처리를 하는경우 @RequestBody , @ResponseBody를 사용 (json 이용)
	@ResponseBody	// 해당 메서드의 데이터들을 모두 그대로 출력
	public String memberIdChkPost(String memberId) throws Exception {
		
		/* logger.info("memberIdChk() 진입"); */
		
		int result = memberservice.idCheck(memberId);	// count(*)
		
		logger.info("결과값 = " + result);
		
		if(result != 0) {
			return "fail";	// 중복 아이디 존재
		
		} else {
			return "success";	// 중복 아이디 x
		}
		
	}
	
	// 이메일 인증
	@RequestMapping(value="/mailCheck", method=RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email) throws Exception {
		
		
		// 뷰 (VIEW)로부터 넘어온 데이터 확인
		logger.info("이메일 데이터 전송 확인");
		logger.info("인증번호 : " + email);
		
		// 인증번호(난수) 생성
		Random rd = new Random();
		int checkNum = rd.nextInt(888888) + 111111;	// 111111 ~ 999999 범위의 난수
		
		// 인증번호 생성 확인
		logger.info("인증번호" + checkNum);
		
		// 이메일 보내기
		String setFrom = "fjrzlrta@naver.com";				// root-context.xml에 삽입한 자신의 이메일 계정
		String toMail = email;								// 수신 받을 이메일, 뷰로부터 받은 이메일 주소인 변수 email 사용
		String title = "회원가입 인증 이메일 입니다.";		// 보낼 이메일 제목
		String content = 									// 보낼 이메일 내용
				"홈페이지를 방문해주셔서 감사합니다." +
				"<br><br>" +
				"인증 번호는" + checkNum + "입니다." + 
				"해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		
		// 이메일 전송을 위한 코드를 삽입
		
		  try {
		  
		  MimeMessage message = mailSender.createMimeMessage(); MimeMessageHelper
		  helper = new MimeMessageHelper(message, true, "utf-8");
		  helper.setFrom(setFrom); helper.setTo(toMail); helper.setSubject(title);
		  helper.setText(content,true); mailSender.send(message);
		  
		  }catch(Exception e) { e.printStackTrace(); }
		 
		
        String num = Integer.toString(checkNum);
        
        return num;
        
	}
	
	// 로그인 페이지 이동
	@RequestMapping(value="login", method=RequestMethod.GET)
	public void joinGET() {
		
		logger.info("로그인 페이지 진입");
		
	}
	
	// 로그인
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {
		
		// 세션 선언 및 초기화
		HttpSession session = request.getSession();
		
		// 잠시 저장하기 위한 변수
		String rawPw = "";			// 보안처리 이전 비밀번호
		String encodePw = "";		// 보안처리 된 비밀번호
		
		// lvo에 로그인한 member의 정보를 저장 ( 비밀번호는 인코딩되어있음 )
		MemberVO lvo = memberservice.memberLogin(member);
		
		if(lvo != null) {		// 일치하는 아이디 존재 o

			rawPw = member.getMemberPw();	// 사용자가 제출한 비밀번호
			encodePw = lvo.getMemberPw();	// DB에 저장한 인코딩된 비밀번호
			
			if(true == pwEncoder.matches(rawPw, encodePw)) {	// 비밀번호 일치 여부 판단, 로그인 성공 시
				
				lvo.setMemberPw("");					// 인코딩된 비밀번호 정보를 지움, 인코딩이 되었더라도 굳이 노출할 필요 x
				session.setAttribute("member", lvo);	// session에 사용자의 정보 저장
				return "redirect:/main";				// 로그인 후 메인페이지 이동
				
			} else {			// 일치하는 아이디가 존재 x
				
				rttr.addFlashAttribute("result", 0);
				return "redirect:/member/login";	// 로그인 페이지로 이동
				
			}
			
		} else {				// 일치하는 아이디가 존재하지 않을 시 (로그인 실패) 

			// RedircetAttributes 클래스는 Post방식으로 전달
			// 이 클래스는 리다이렉트가 발생하기 전에 모든 플래시 속성을 세션에 복사,
			// 리다이렉션 이후에는 저장된 플래시 속성을 세션에서 모델로 이동
			
			rttr.addFlashAttribute("result", 0);	// 리플렉션에 실패를 의미하는 데이터 저장
			return "redirect:/member/login";	   // 로그인 페이지로 이동
			
		}
	}
	
	// 메인페이지 로그아웃
	@RequestMapping(value="logout.do", method=RequestMethod.GET)
	public String logoutMainGET(HttpServletRequest request) throws Exception {
		
		logger.info("logoutMainGET메서드 진입");
		
		HttpSession session = request.getSession();
		
		session.invalidate(); // 세션정보 삭제
		
		return "redirect:/main";
		
	}
	
	// 비동기식 로그아웃 메서드
	@RequestMapping(value="logout.do", method=RequestMethod.POST)
	@ResponseBody
	public void logoutPOST(HttpServletRequest request) throws Exception {
		
		logger.info("비동기식 로그아웃 메서드 진입");
		
		HttpSession session = request.getSession();
		
		session.invalidate(); // 세션 정보 삭제
		
	}
	
}
