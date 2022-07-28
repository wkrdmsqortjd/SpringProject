package com.dustmq.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

// 댓글의 정보를 담는 클래스
public class ReplyVO {
	
	private int replyId;		// 댓글 아이디
	private int bookId;			// 상품 아이디
	private String memberId;	// 회원 아이디
	
	@JsonFormat(shape= JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="Asia/Seoul")	// json으로 변환된 Date 타입의 포맷을 지정
	private Date regDate;		// 댓글 등록일
	private String content;		// 댓글 내용
	private double rating;		// 댓글 평점
	public int getReplyId() {
		return replyId;
	}
	public void setReplyId(int replyId) {
		this.replyId = replyId;
	}
	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	@Override
	public String toString() {
		return "ReplyVO [replyId=" + replyId + ", bookId=" + bookId + ", memberId=" + memberId + ", regDate=" + regDate
				+ ", content=" + content + ", rating=" + rating + "]";
	}
	
}
