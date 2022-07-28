package com.dustmq.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dustmq.model.ReplyVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ReplyMapperTests {

	@Autowired
	private ReplyMapper mapper;
	
	/* 댓글 등록 */
	@Test
	public void enrollReplyTest() {
		
		String id = "admin";
		int bookId = 285;
		double rating = 3.5;
		String content = "댓글 테스트";
		
		ReplyVO rvo = new ReplyVO();
		
		rvo.setBookId(bookId);
		rvo.setMemberId(id);
		rvo.setRating(rating);
		rvo.setContent(content);
		
		mapper.enrollReply(rvo);
	}
}
