package com.dustmq.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dustmq.model.CartVO;
import com.dustmq.model.MemberVO;
import com.dustmq.service.CartService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CartController {

	@Autowired
	private CartService cartService;
	
	/* 장바구니에 상품 등록 */
	@PostMapping("/cart/add")
	@ResponseBody	// 화면을 반환하는 것이 아닌 데이터를 바로 반환할 때 사용하는 어노테이션
	public String addCartPOST(CartVO cart, HttpServletRequest request) {	// 데이터 전달받기 위해 cart를 , 로그인 여부를 확인하기 위해 request를
		
		/* 로그인 체크 */
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("member");
		
		if(mvo == null) {
				return "5";	// 로그인이 안되어있으면 문자열 "5" 반환
		}
		
		/* 카트 등록 */
		int result = cartService.addCart(cart);
		
		return result + "";
		
	}
	
	/* 장바구니 뷰 페이지 이동 */
	@GetMapping("/cart/{memberId}")
	public String cartPageGet(@PathVariable("memberId") String memberId, Model model) {
		
		// 조회한 장바구니 데이터를 model에 "cartInfo"라는 키로 지정해 view로 전달
		model.addAttribute("cartInfo", cartService.getCartList(memberId));
		
		return "/cart";
	}
	
}
