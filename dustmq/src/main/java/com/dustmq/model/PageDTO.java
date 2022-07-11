package com.dustmq.model;

// 페이징 이동 인터페이스를 출력시키는데 필요한 데이터들의 모임
public class PageDTO {

	/* 페이지 시작 번호 */
    private int pageStart;
    
    /* 페이지 끝 번호 */
    private int pageEnd;
    
    /* 이전, 다음 버튼 존재 유무 */
    private boolean next, prev;
    
    /* 전체 게시물 수 */
    private int total;
    
    /* 현재페이지 번호(pageNum), 페이지당 게시물 표시수(amount), 검색 키워드(keyword), 검색 종류(type) */
    private Criteria cri;
    
    /* 생성자(클래스 호출 시 각 변수 값 초기화) */
    /* PageDTO를 인스턴스화 시키려면 Criteria와 total들이 필요 */
    public PageDTO(Criteria cri, int total) {
        
        /* cri, total 초기화 */
        this.cri = cri;
        this.total = total;
        
        /* 페이지 끝 번호 Math.ceil()은 올림처리 메서드이다.*/
        this.pageEnd = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
        
        /* 페이지 시작 번호 */
        this.pageStart = this.pageEnd - 9;
        
        /* 전체 마지막 페이지 번호 */
        int realEnd = (int)(Math.ceil(total*1.0/cri.getAmount()));	// 1.0을 곱한 이유는 나누면 정수가 나오기 때문
        
        /* 페이지 끝 번호 유효성 체크 */
        /* 전체 마지막 페이지(realEnd)가 화면에 보이는 마지막페이지(endPage)보다 작으면, 보이는 페이지 값 조정 */
        if(realEnd < pageEnd) {
            this.pageEnd = realEnd;
        }
        
        /* 이전 버튼 값 초기화 */
        this.prev = this.pageStart > 1;
        
        /* 다음 버튼 값 초기화 , 전체 마지막 페이지 번호보다 화면에 보이는 페이지 번호가 작다면 보임 */
        /* 즉, 마지막 realEnd에서는 보이지 않아야함 */
        this.next = this.pageEnd < realEnd;
        
    }

	public int getPageStart() {
		return pageStart;
	}

	public void setPageStart(int pageStart) {
		this.pageStart = pageStart;
	}

	public int getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	@Override
	public String toString() {
		return "PageDTO [pageStart=" + pageStart +
				        ", pageEnd=" + pageEnd +
				        ", next=" + next +
				        ", prev=" + prev + 
				        ", total=" + total +
				        ", cri=" + cri +
				        "]";
	}
    
}
