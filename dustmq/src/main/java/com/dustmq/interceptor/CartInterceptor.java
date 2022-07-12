package com.dustmq.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.dustmq.model.MemberVO;

// 로그인을 해야 장바구니에 들어갈 수 있게 interceptor 적용

public class CartInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		
		// mvo에 로그인시 session "member"라는 키로 사용자 정보 데이터를 저장
		MemberVO mvo = (MemberVO)session.getAttribute("member");	
		
		if(mvo == null) {	// member 키가 없으면
				response.sendRedirect("/main");
				return false;
		} else {
				return true;
		}
	}
}
