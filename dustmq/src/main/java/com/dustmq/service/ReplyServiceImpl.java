package com.dustmq.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dustmq.mapper.ReplyMapper;
import com.dustmq.model.Criteria;
import com.dustmq.model.PageDTO;
import com.dustmq.model.ReplyPageDTO;
import com.dustmq.model.ReplyVO;
import com.dustmq.model.SelectVO;
import com.dustmq.model.UpdateReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	private ReplyMapper replyMapper;
	
	/* 댓글 등록 */
	@Override
	public int enrollReply(ReplyVO rvo) {
		
		int result = replyMapper.enrollReply(rvo);
		
		setRating(rvo.getBookId());
		
		return result;
	}
	
	/* 댓글 페이징 */
	@Override
	public ReplyPageDTO replyList(Criteria cri) {
		
		// 댓글 페이징 데이터를 세팅하기 위해 생성
		ReplyPageDTO dto = new ReplyPageDTO();
		
		// 페이징 댓글 
		dto.setList(replyMapper.getReplyList(cri));
		
		// 페이징 정보
		dto.setPageInfo(new PageDTO(cri, replyMapper.getReplyTotal(cri.getBookId())));
	
		return dto;
	}

	/* 댓글 체크 */
	@Override
	public String checkReply(ReplyVO rvo) {

		/* 댓글을 체크하는 Mapper문의 결과값을 result에 대입 */
		Integer result = replyMapper.checkReply(rvo);
		
		if(result == null) {
				return "0";		// 댓글이 존재하지 않으면 "0"
		} else {
				return "1";		// 댓글이 존재하면 "1"
		}
	}

	/* 댓글 수정 */
	@Override
	public int updateReply(ReplyVO rvo) {
		
		int result = replyMapper.updateReply(rvo);
		
		setRating(rvo.getBookId());
		
		return result;
	}

	/* 회원이 작성한 댓글정보 */
	@Override
	public ReplyVO getUpdateReply(int replyId) {

		return replyMapper.getUpdateReply(replyId);
	}

	/* 댓글 삭제 */
	@Override
	public int deleteReply(ReplyVO rvo) {
		
		int result = replyMapper.deleteReply(rvo);
			
		setRating(rvo.getBookId());
		
		return result;
		
	}
	
	/* 평점 세팅 */
	public void setRating(int bookId) {
		
		// 상품 평점 평균값을 반환 후 대입
		Double ratingAvg = replyMapper.getRatingAverage(bookId);
		
		if(ratingAvg == null) {		// 반환 값이 없으며
				ratingAvg = 0.0;	// 평균 값은 0.0
		}
		
		ratingAvg = (double) (Math.round(ratingAvg*10));
		ratingAvg = ratingAvg / 10;
		
		// 변수 저장
		UpdateReplyVO uvo = new UpdateReplyVO();
		uvo.setBookId(bookId);
		uvo.setRatingAvg(ratingAvg);
		
		// 구한 평균 평점 반영
		replyMapper.updateRating(uvo);
	}
}
