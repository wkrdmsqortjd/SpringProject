package com.dustmq.mapper;

import java.util.List;

import com.dustmq.model.Criteria;
import com.dustmq.model.ReplyVO;
import com.dustmq.model.UpdateReplyVO;

public interface ReplyMapper {

	/* 댓글 등록 */
	public int enrollReply(ReplyVO rvo);
	
	/* 댓글 페이징 정보 */
	public List<ReplyVO> getReplyList(Criteria cri);

	/* 댓글 총 개수(페이징) */
	public int getReplyTotal(int bookId);
	
	/* 댓글 존재 확인 */
	public Integer checkReply(ReplyVO rvo);
	
	/* 댓글 수정 */
	public int updateReply(ReplyVO rvo);
	
	/* 댓글 삭제 */
	public int deleteReply(ReplyVO rvo);
	
	/* 회원이 작성한 댓글정보 */
	public ReplyVO getUpdateReply(int replyId);
	
	/* 평균 평점 구하기 */
	public Double getRatingAverage(int bookId);
	
	/* 평균 평점 반영 */
	public int updateRating(UpdateReplyVO uvo);
}
