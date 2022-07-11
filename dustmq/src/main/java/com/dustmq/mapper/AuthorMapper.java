package com.dustmq.mapper;

import java.util.List;

import com.dustmq.model.AuthorVO;
import com.dustmq.model.CateVO;
import com.dustmq.model.Criteria;

public interface AuthorMapper {
	
	/* 작가 등록 */
	public void authorEnroll(AuthorVO author);
	
	/* 작가 목록 */ 
	// 여러 작가의 데이터를 반환받아야 하기 때문에 반환타입으로 List 자료구조 사용
	public List<AuthorVO> authorGetList(Criteria cri);
	
	/* 작가 총 수 */
	// Criteria는 keyword를 전달받기 위해 매개변수로 받음
	public int authorGetTotal(Criteria cri);
	
	/* 작가 상세 */
	public AuthorVO authorGetDetail(int authorId);
	
	/* 작가 정보 수정 */
	public int authorModify(AuthorVO author);
	
	/* 작가 정보 삭제 */
	public int authorDelete(int authorId);
}
