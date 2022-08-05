package com.dustmq.model;

import java.util.List;

// 노출 시킬 상품의 정보들을 담는 클래스
public class SelectVO {
	
	private int bookId;			// 상품 id
	
	private String bookName;	// 상품 이름
	
	private String cateName;	// 카테고리 이름
	
	private double ratingAvg;	// 평균 평점
	
	private List<AttachImageVO> imageList;	// 상품 이미지

	public int getBookId() {
		return bookId;
	}

	public void setBookId(int bookId) {
		this.bookId = bookId;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public double getRatingAvg() {
		return ratingAvg;
	}

	public void setRatingAvg(double ratingAvg) {
		this.ratingAvg = ratingAvg;
	}

	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}

	@Override
	public String toString() {
		return "SelectVO [bookId=" + bookId + ", bookName=" + bookName + ", cateName=" + cateName + ", ratingAvg="
				+ ratingAvg + ", imageList=" + imageList + "]";
	}
	
}
