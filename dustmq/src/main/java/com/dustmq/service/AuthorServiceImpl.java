package com.dustmq.service;

import java.util.List;

import org.slf4j.Logger;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dustmq.mapper.AuthorMapper;
import com.dustmq.model.AuthorVO;
import com.dustmq.model.Criteria;

@Service
public class AuthorServiceImpl implements AuthorService {

	private static final Logger logger = LoggerFactory.getLogger(AuthorServiceImpl.class);
	
	@Autowired
	AuthorMapper authorMapper;
	
	// 작가 등록
	@Override
	public void authorEnroll(AuthorVO author) throws Exception {

		authorMapper.authorEnroll(author);
	}

	// 작가 목록
	@Override
	public List<AuthorVO> authorGetList(Criteria cri) throws Exception {
		
		logger.info("(service)authorGetList()......" + cri); 
		
		return authorMapper.authorGetList(cri);
	}

	// 작가 수
	@Override
	public int authorGetTotal(Criteria cri) throws Exception {

		logger.info("(service)authorGetTotal()......" + cri);
		
		return authorMapper.authorGetTotal(cri);
	}

	@Override
	public AuthorVO authorGetDetail(int authorId) throws Exception {

		logger.info("(service)authorGetDetail....." + authorId);
		
		return authorMapper.authorGetDetail(authorId); 
		
	}

	@Override
	public int authorModify(AuthorVO author) throws Exception {
		
		logger.info("(service) authorModify........." + author);
		
		return authorMapper.authorModify(author);
	}
	
	/* 작가 정보 삭제 */
	@Override
	public int authorDelete(int authorId) throws Exception {
		
		logger.info("authorDelete..............");
		
		return authorMapper.authorDelete(authorId);
		
	}

}
