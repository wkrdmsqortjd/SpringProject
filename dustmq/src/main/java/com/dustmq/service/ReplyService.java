package com.dustmq.service;

import com.dustmq.model.Criteria;
import com.dustmq.model.ReplyPageDTO;
import com.dustmq.model.ReplyVO;

public interface ReplyService {
	
	/* 댓글 등록 */
	public int enrollReply(ReplyVO rvo);
	
	/* 댓글 페이징 */
	public ReplyPageDTO replyList(Criteria cri);
	
	/* 댓글 존재 확인 - 댓글이 존재하면 "1" , 존재하지 않으면 "0" 을 Controller로 반환 */
	public String checkReply(ReplyVO rvo);

	/* 댓글 수정 */
	public int updateReply(ReplyVO rvo);
	
	/* 회원이 작성한 댓글정보 */
	public ReplyVO getUpdateReply(int replyId);
	
	/* 댓글 삭제 */
	public int deleteReply(ReplyVO rvo);
	
}
