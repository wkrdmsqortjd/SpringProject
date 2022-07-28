package com.dustmq.model;

/* 주문 취소에 관한 정보를 담는 그릇 */
public class OrderCancelVO {
	
	/* 주문 취소에 필요한 데이터 */
	private String memberId;	// 멤버 아이디
	private String orderId;		// 상품 아이디
	
	/* 주문 취소 후 리다이렉트 할 때 필요한 데이터 */
	private String keyword;		// 검색 키워드
	private int amount;			// 게시물의 총 개수
	private int pageNum;		// 현재 페이지 번호
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	@Override
	public String toString() {
		return "OrderCancleVO [memberId=" + memberId + ", orderId=" + orderId + ", keyword=" + keyword + ", amount="
				+ amount + ", pageNum=" + pageNum + "]";
	}

}
