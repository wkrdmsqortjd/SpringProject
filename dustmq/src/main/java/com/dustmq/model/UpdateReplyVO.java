package com.dustmq.model;

// 댓글 관련 작업 후 평점을 최신화 하기위한 데이터를 담는 클래스
public class UpdateReplyVO {
	
	private int bookId;			// 상품 아이디

	private double ratingAvg;	// 평균 평점
	
	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public double getRatingAvg() {
		return ratingAvg;
	}
	public void setRatingAvg(double ratingAvg) {
		this.ratingAvg = ratingAvg;
	}
	@Override
	public String toString() {
		return "UpdateReplyVO [bookId=" + bookId + ", ratingAvg=" + ratingAvg + "]";
	}
}
