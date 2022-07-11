package com.dustmq.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dustmq.model.AuthorVO;
import com.dustmq.model.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AuthorServiceTests {
    
    /*AuthoreService 의존성 주입*/
    @Autowired
    private AuthorService service;
    
	
	  @Test public void authorEnrollTest() throws Exception {
	  
	  AuthorVO author = new AuthorVO();
	  
	  author.setNationId("01"); author.setAuthorName("테스트");
	  author.setAuthorIntro("테스트 소개");
	  
	  service.authorEnroll(author);
	  
	  }
    
    @Test
    public void authorGetListTest() throws Exception{
    	
    	Criteria cri = new Criteria(1,10);	// 3페이지 & 10개 행 표시
    	cri.setKeyword("김난도");
    	
    	List<AuthorVO> list = service.authorGetList(cri);
    	
    	for(int i = 0; i < list.size(); i++) {
    		System.out.println("list" + i + "........" + list.get(i));
    	}
    }
    
    @Test
    public void authorGetDetailTest() throws Exception {
    	
    	int authorId = 30;
    	
    	AuthorVO author = service.authorGetDetail(authorId);
		
		System.out.println("author......." + author);
    	
    }
    
    /* 작가 정보 수정 테스트 */
	@Test
	public void authorModifyTest() throws Exception {
		
		AuthorVO author = new AuthorVO();
		
		author.setAuthorId(30);
		System.out.println("수정 전........................" + service.authorGetDetail(author.getAuthorId()));
		
		author.setAuthorName("수정");
		author.setNationId("01");
		author.setAuthorIntro("소개 수정 하였습니다.");
		
		service.authorModify(author);
		System.out.println("수정 후...................." + service.authorGetDetail(author.getAuthorId()));
	}
    
 
}