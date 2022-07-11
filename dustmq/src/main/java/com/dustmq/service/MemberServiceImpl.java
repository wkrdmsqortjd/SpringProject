package com.dustmq.service;

import org.slf4j.Logger;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dustmq.controller.MemberController;
import com.dustmq.mapper.MemberMapper;
import com.dustmq.model.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberMapper membermapper;
	
	// 회원가입 
	@Override
	public void memberJoin(MemberVO member) throws Exception {

		logger.info("memberService의 memberJoin메서드 호출");
		
		// 회원가입 서비스 실행 (mapper 메서드 호출)
		membermapper.memberJoin(member);
		
		logger.info("완료 후 돌아가는 길");
		
	}

	// 아이디 중복확인
	@Override
	public int idCheck(String memberId) throws Exception {
		// membermapper로 sql문 메서드를 리턴
		return membermapper.idCheck(memberId);
	}

	// 로그인
	@Override
	public MemberVO memberLogin(MemberVO member) throws Exception {
		
		return membermapper.memberLogin(member);
	}

	
	
}
