package com.dustmq.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.dustmq.model.MemberVO;

public class AdminInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		// 요청 받은 member 데이터의 세션을 MemberVO 타입의 lvo 변수에 저장
		MemberVO lvo = (MemberVO) session.getAttribute("member");
		
		if(lvo == null || lvo.getAdminCk() == 0) {	// 관리자 계정 x
			
			response.sendRedirect("/main");		// 메인페이지로 리다이렉트
			
			return false;
			
		}
		
		return true;	// 관리자 계정 로그인 경우 (lvo != null || member.getAdminCk() == 1)
	
	}

}
