package com.dustmq.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {
	
	// preHandle 메서드는 컨트롤 진입 전에 작업
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) 
			throws Exception {
		
		System.out.println("LoginInterceptor preHandel() 작동");
		
		HttpSession session = request.getSession();
		
		session.invalidate(); // 세션 정보 삭제
		
		return true;
	}

}
