package com.dustmq.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.dustmq.model.MemberVO;
import com.dustmq.model.OrderPageVO;
import com.dustmq.model.OrderVO;
import com.dustmq.service.MemberService;
import com.dustmq.service.OrderService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private MemberService memberService;
	
	/* order페이지로 정보 전달 */
	@GetMapping("/order/{memberId}")
	public String orderPageGET(@PathVariable("memberId")String memberId, OrderPageVO opv, Model model) {
		
		// 각 Service 메서드를 호출해서 반환받은 값들을 뷰로 전송
		model.addAttribute("orderList", orderService.getGoodsInfo(opv.getOrders()));	// 주문 상품 정보
		model.addAttribute("memberInfo", memberService.getMemberInfo(memberId));		// 사용자 정보
		
		return "/order";
	}
	
	@PostMapping("/order")
	public String orderPagePost(OrderVO ov, HttpServletRequest request) {
		
		System.out.println(ov);
		
		orderService.order(ov);
		
		/* 최신화 하기위한 회원 객체 생성 */	
		MemberVO member = new MemberVO();	
		member.setMemberId(ov.getMemberId());
		
		/* 상품 구매 후 사용자 정보를 최신화 */
		HttpSession session = request.getSession();
		
		try {
				// Service 메서드로 가져온 회원 정보를 memberLogin 변수에 저장
				MemberVO memberLogin = memberService.memberLogin(member);
				memberLogin.setMemberPw("");
				session.setAttribute("member", memberLogin);
		
		} catch (Exception e) {
				e.printStackTrace();
		}
		
		return "redirect:/main";
	}

}
