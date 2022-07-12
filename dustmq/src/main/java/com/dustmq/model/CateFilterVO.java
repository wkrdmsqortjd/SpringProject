package com.dustmq.model;

// 검색 필터링 DTO
public class CateFilterVO {

	/* 카테고리 이름 */
	private String cateName;
	
	/* 카테고리 코드 번호 */
	private String cateCode;
	
	/* 카테고리에서 검색한 상품의 수 */
	private int cateCount;
	
	/* 국내, 국외 분류 */
	private String cateGroup;

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public String getCateCode() {
		return cateCode;
	}

	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
		// cateCode 는 = '1xxxxx' , '2xxxxx' 형태인데 앞 자리로 1(국내) 2(국외)를 구분하여 대입
		this.cateGroup = cateCode.split("")[0];	// split 함수는 특정문자를 기준으로 문자열을 나눠 Array에 저장 후 리턴
	}

	public int getCateCount() {
		return cateCount;
	}

	public void setCateCount(int cateCount) {
		this.cateCount = cateCount;
	}

	public String getCateGroup() {
		return cateGroup;
	}

	public void setCateGroup(String cateGroup) {
		this.cateGroup = cateGroup;
	}

	@Override
	public String toString() {
		return "CateFilterVO [cateName=" + cateName + ", cateCode=" + cateCode + ", cateCount=" + cateCount
				+ ", cateGroup=" + cateGroup + "]";
	}
}
