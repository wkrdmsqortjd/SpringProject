package com.dustmq.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dustmq.model.Criteria;
import com.dustmq.model.ReplyPageDTO;
import com.dustmq.model.ReplyVO;
import com.dustmq.service.ReplyService;

@RestController	// @Controller + @ResponseBody : Jason형태로 객체 데이터를 반환할 때 사용
				// 모든 메소드가 뷰 대신 객체로 작성
@RequestMapping("/reply")
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	
	/* 댓글 등록 */
	@PostMapping("/enroll")
	public void enrollReplyPOST(ReplyVO rvo) {
		replyService.enrollReply(rvo);
	}
	
	/* 댓글 페이징 정보, 페이지 정보 */
	@GetMapping(value="/list", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ReplyPageDTO replyListPOST(Criteria cri) {
		return replyService.replyList(cri);
	}
	
	/* 댓글 존재 확인 - 존재하면 Service에서 댓글이 존재하면 "1"을 존재하지않으면 "0"을 반환 */
	@PostMapping("/check")
	public String replyCheckPOST(ReplyVO rvo) {
		return replyService.checkReply(rvo);
	}
	
	/* 댓글 수정 */
	@PostMapping("/update")
	public void replyModifyPOST(ReplyVO rvo) {
		replyService.updateReply(rvo);
	}
	
	/* 댓글 삭제 */
	@PostMapping("/delete")
	public void replyDeletePOST(ReplyVO rvo) {
		replyService.deleteReply(rvo);
	}
}
