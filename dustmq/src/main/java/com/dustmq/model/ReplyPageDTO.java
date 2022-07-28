package com.dustmq.model;

import java.util.List;

/* 댓글 페이징에 필요한 데이터를 담는 객체 */
public class ReplyPageDTO {

	/* 댓글 정보 리스트 */
	List<ReplyVO> list;
	
	/* 페이지 정보 */
	PageDTO pageInfo;

	public List<ReplyVO> getList() {
		return list;
	}

	public void setList(List<ReplyVO> list) {
		this.list = list;
	}

	public PageDTO getPageInfo() {
		return pageInfo;
	}

	public void setPageInfo(PageDTO pageInfo) {
		this.pageInfo = pageInfo;
	}

	@Override
	public String toString() {
		return "ReplyPageDTO [list=" + list + ", pageInfo=" + pageInfo + "]";
	}
}
