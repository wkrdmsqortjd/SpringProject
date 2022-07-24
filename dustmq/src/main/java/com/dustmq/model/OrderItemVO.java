package com.dustmq.model;

// 하나의 상품 정보를 담는 클래스
public class OrderItemVO {

	/* 주문 번호 */
	private String orderId;
	
	/* 상품 번호 */
	private int bookId;
	
	/* 주문 수량 */
	private int bookCount;
	
	/* orderItem의 pk */
	private int orderItemId;
	
	/* 상품 단품 가격 */
	private int bookPrice;
	
	/* 상품 할인율 */
	private double bookDiscount;
	
	/* 단품 구매시 받는 포인트 */
	private int savePoint;
	
	/* 할인 적용된 상품가 */
	private int salePrice;
	
	/* 총 가격 */
	private int totalPrice;		// salePrice * bookCount
	
	/* 총 받은 포인트 */
	private int totalSavePoint;	// savePoint * bookCount

	/* 주문 작업에 필요한 데이터를 대입 */
	public void initSaleTotal() {
		this.salePrice = (int) (this.bookPrice * (1 - this.bookDiscount));
		this.totalPrice = this.salePrice * this.bookCount;
		this.savePoint = (int)(Math.floor(this.salePrice * 0.05));
		this.totalSavePoint =this.savePoint * this.bookCount;
	}
	
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
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

	public int getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
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

	public int getSavePoint() {
		return savePoint;
	}

	public void setSavePoint(int savePoint) {
		this.savePoint = savePoint;
	}

	public int getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(int salePrice) {
		this.salePrice = salePrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getTotalSavePoint() {
		return totalSavePoint;
	}

	public void setTotalSavePoint(int totalSavePoint) {
		this.totalSavePoint = totalSavePoint;
	}

	@Override
	public String toString() {
		return "OrderItemVO [orderId=" + orderId + ", bookId=" + bookId + ", bookCount=" + bookCount + ", orderItemId="
				+ orderItemId + ", bookPrice=" + bookPrice + ", bookDiscount=" + bookDiscount + ", savePoint="
				+ savePoint + ", salePrice=" + salePrice + ", totalPrice=" + totalPrice + ", totalSavePoint="
				+ totalSavePoint + "]";
	}
	
}
