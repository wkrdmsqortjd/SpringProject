package com.dustmq.model;

import java.util.List;

/* 장바구니 DTO */
public class CartVO {

	// vam_cart 속성
	private int cartId;
	
	private String memberId;
	
	private int bookId;
		
	private int bookCount;	// 수량
	
	// vam_book의 속성, 이 후 cart테이블과 조인하기 위해 추가
	private String bookName;
	
	private int bookPrice;
	
	private double bookDiscount;	
	
	// 추가 컬럼
	private int salePrice;	// 판매가 (할인 적용가)
	
	private int totalPrice;	// 총 가격
	
	// 포인트
	private int point;
	private int totalPoint;
	
	// 상품 이미지
	private List<AttachImageVO> imageList;
	
	// salePrice 와 totalPrice 초기화 메서드
	public void initSaleTotal() {
		this.salePrice = (int)(this.bookPrice * (1 - this.bookDiscount));
		this.totalPrice = this.salePrice * this.bookCount;
		this.point = (int)(Math.floor(this.salePrice * 0.05));
		this.totalPoint = this.point * this.bookCount;
}
	
	
	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}

	public int getPoint() {
		return point;
	}

	public int getTotalPoint() {
		return totalPoint;
	}

	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getBookId() {
		return bookId;
	}

	public void setBookId(int bookId) {
		this.bookId = bookId;
	}

	public int getBookCount() {
		return bookCount;
	}

	public void setBookCount(int bookCount) {
		this.bookCount = bookCount;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	public int getBookPrice() {
		return bookPrice;
	}

	public void setBookPrice(int bookPrice) {
		this.bookPrice = bookPrice;
	}

	public double getBookDiscount() {
		return bookDiscount;
	}

	public void setBookDiscount(double bookDiscount) {
		this.bookDiscount = bookDiscount;
	}

	public int getSalePrice() {
		return salePrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	@Override
	public String toString() {
		return "CartVO [cartId=" + cartId + ", memberId=" + memberId + ", bookId=" + bookId + ", bookCount=" + bookCount
				+ ", bookName=" + bookName + ", bookPrice=" + bookPrice + ", bookDiscount=" + bookDiscount
				+ ", salePrice=" + salePrice + ", totalPrice=" + totalPrice + ", point=" + point + ", totalPoint="
				+ totalPoint + ", imageList=" + imageList + "]";
	}
}
