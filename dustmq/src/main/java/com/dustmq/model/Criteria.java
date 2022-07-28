package com.dustmq.model;

import java.util.Arrays;

// 게시물의 페이징, 검색 조건에 따른 데이터를 출력할 때 필요한 VO
public class Criteria {
	
   /* 현재 페이지 번호 */
    private int pageNum;
    
    /* 한 페이지 당 보여질 게시물 수 */
    private int amount;
    
    /* 검색 타입, 검색 조건의 판단 근거가 되는 데이터 */
    // 사용자가 어떠한 검색을 하는지에 대한 데이터를 저장
    private String type;
    
    /* 검색 키워드 */
    private String keyword;
    
    /* 작가 리스트 */
    private String[] authorArr;
    
    /* 카테고리 코드 */
    private String cateCode;
    
    /* 상품 번호(댓글 기능) */
    private int bookId;
    
    public int getBookId() {
		return bookId;
	}

	public void setBookId(int bookId) {
		this.bookId = bookId;
	}

	public String[] getAuthorArr() {
		return authorArr;
	}

	public void setAuthorArr(String[] authorArr) {
		this.authorArr = authorArr;
	}

	public String getCateCode() {
		return cateCode;
	}

	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
	}

    /* 기본 생성자 -> 기본 세팅 : pageNum = 1, amount = 10 */
    public Criteria() {
        this(1,10);
    }
    
    /* 생성자 => 원하는 pageNum, 원하는 amount */
    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }
    
    /* 검색 타입 데이터 배열 변환 */
    public String[] getTypeArr() {
        return type == null? new String[] {}:type.split("");	// type 변수에 담긴 값을 Mapper에 그대로 전달하면 활용 불가.
        														// 활용하기 위해 하나하나의 String 값이 필요한데 이를 split()메서드를 통해 
        														// String타입으로 하나 하나 Mapper에 전달
    }

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", type=" + type + ", keyword=" + keyword
				+ ", authorArr=" + Arrays.toString(authorArr) + ", cateCode=" + cateCode + ", bookId=" + bookId + "]";
	}
	
}
