<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/authorManage.css">
 
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
</head>
<body>
 
    		 <%@include file="../includes/admin/header.jsp" %>	<!-- header -->
    
                <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>작가 관리</span></div>
                <!-- 테이블 형식으로 전달받은 데이터를 보여줌 -->
                <div class="author_table_wrap">
                	<!-- 게시물 o -->
                	<c:if test="${listCheck != 'empty' }">
                    	<table class="author_table">
                    		<thead>
                    			<tr>
                    				<td class="th_column_1">작가 번호</td>
                    				<td class="th_column_2">작가 이름</td>
                    				<td class="th_column_3">작가 국가</td>
                    				<td class="th_column_4">등록 날짜</td>
                    				<td class="th_column_5">수정 날짜</td>
                    			</tr>
                    		</thead>
                    		<c:forEach items="${list}" var="list">	<!-- 반복처리 -->
                    		<tr>
                    			<td><c:out value="${list.authorId}"></c:out> </td>
                   				<td>
		                   			<a class="move" href='<c:out value="${list.authorId}"/>'>
		                    			<c:out value="${list.authorName}"></c:out>
		                   			</a>
                   				</td>
                    			<td><c:out value="${list.nationName}"></c:out> </td>
                    			<td><fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd"/></td>
                    			<td><fmt:formatDate value="${list.updateDate}" pattern="yyyy-MM-dd"/></td>
                    		</tr>
                    		</c:forEach>
                    	</table>  
                   	</c:if>       
                   	
                   	<!-- 게시물 x -->
                   	<c:if test="${listCheck == 'empty' }">
                   		<div class="table_empty">
                   			등록된 작가가 없습니다.
                   		</div>
                   	</c:if>       			
                    </div>   
                    
                    <!-- 검색 영역 -->
                    <div class="search_wrap">
                    	<form id="searchForm" action="/admin/authorManage" method="get">
                    		<div class="search_input">
                    			<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
                    			<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"></c:out>'>
                    			<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
                    			<button class='btn search_btn'>검 색</button>
                    		</div>
                    	</form>
                    </div>  
                  
                    <!-- 페이지 이동 인터페이스 영역 -->
                    <div class="pageMaker_wrap" >
                    
	                    <ul class="pageMaker">
	                    
	                    	<!-- 이전 버튼 -->
	                    	<c:if test="${pageMaker.prev}">
	                    		<li class="pageMaker_btn prev">
	                    			<a href="${pageMaker.pageStart - 1}">이전</a>
	                    		</li>
	                    	</c:if>
	                    	
	                    	<!-- 페이지 번호 -->
	                    	<c:forEach begin="${pageMaker.pageStart}" end="${pageMaker.pageEnd}" var="num">
	                    		<!-- 아래 상항 연산자는 현재 페이지일 경우 class 속성 값이 "pageMaker_btn active" 되는데
	                    		     해당 버튼에 현재 페이짐을 할 수 있도록 css 설정을 해줄 것 -->
	                    		<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? "active":""}">
	                    			<a href="${num}"> ${num} </a>
	                    		</li>
	                    	</c:forEach>
	                    	
	                    	<!-- 다음 버튼 -->
	                    	<c:if test="${pageMaker.next}">
	                    		<li class="pageMaker_btn next">
	                    			<a href="${pageMaker.pageEnd + 1 }">다음</a>
	                    		</li>
	                    	</c:if>
	                    </ul>
                    </div>
                    
                    <!-- 페이지 이동할 때 필요정보 form -->
                    <form id="moveForm" action="/admin/authorManage" method="get">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
					</form>
                                     
                </div>
			
			 <%@include file="../includes/admin/footer.jsp" %>	<!-- footer -->

<script>
 
 	// 페이지가 로드될 때 반드시 실행되는 익명 함수
 	$(document).ready(function(){
 		
 		// c:out는 변수의 내용을 출력할 때 사용되는 태그, HTML 문자를 탈락 시키는 기능이 있다.
 		// 등록 성공시 메세지와 데이터
 		let result = '<c:out value="${enroll_result}"/>';	
 		let mresult = '<c:out value="${modify_result}"/>';
 		
 		// 함수 호출
 		checkResult(result);
 		checkmResult(mresult);
 		
 		/* 등록 함수 */
 		function checkResult(result){
 			
 			if(result === ''){
 				return;
 			}
 			
 			alert("작가 '${enroll_result}' 을 등록하였습니다.");
 		}
 		
 		/* 수정 함수 */
 		function checkmResult(mresult){
 			
 			if(mresult === '1') {
 				
 				alert("작가 정보 수정을 완료하였습니다.");
 				
 			} else if(mresult === '0') {
 				
 				alert("작가 정부 수정을 하지 못하였습니다.");
 			}
 		}
 		
 		/* 삭제 결과 경고창 */
 		let delete_result = '${delete_result}';
 		
 		if(delete_result == 1){
 			alert("삭제 완료");
 		} else if(delete_result == 2){
 			alert("해당 작가 데이터를 사용하고 있는 데이터가 있어서 삭제 할 수 없습니다.")
 		}	
 		
 	});
 	
 	// 변수
 	let moveForm = $('#moveForm');	/* form태그 */
 	let searchForm = $('#searchForm');
 	
 	
 	/* 페이지 이동 버튼 */
 	$(".pageMaker_btn a").on("click", function(e){	// 숫자를 누르면 함수 실행
 		
 		/* a 태그를 눌러도 href 링크로 이동하지 않게 할 경우 */
 		/* form 안에 submit 역할을 하는 버튼을 눌렀어도 새로 실행하지 않게 하고싶을 경우 (submit은 작동) */
 		e.preventDefault();
 		
 		/* 숫자를 누르면 a태그의 동작을 멈추고, a태그에 저장된 href속성 값을 form태그의 내부에 있는 pageNum input태그 값으로 저장 후
 		   form태그 속성에 설정되어 있는 url경로와 method 방식으로 form을 서버로 전달 */
	    /* "/admin/authorManage? pageNum=${num}&amount=10" */
 		moveForm.find("input[name='pageNum']").val($(this).attr("href"));	// A.val(B) : A에 B값을 넣는다.
 																			// A.attr(B) : A요소 중 B의 속성 값 
 																			// $(this)는 pageMaker_btn a 를 의미
 		moveForm.submit();													// 즉, 번호에 해당하는 href의 값을 pageNum에 넣는다.
 		
 	});
 	
 	/* 작가 검색 버튼 동작 */
 	$("#searchForm button").on("click", function(e){
		
		e.preventDefault();
		
		/* 검색 키워드 유효성 검사 */
		if(!searchForm.find("input[name='keyword']").val()){	// ' '안에 value값을 가져옴, 키워드 값이 없을 경우
			alert("키워드를 입력하십시오");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");	// 페이지 이동 후 현재 페이지는 1페이지로 이동
		searchForm.submit();
	});

 	/* 작가 상세 페이지 이동 */
 	$(".move").on("click", function(e){
 		
 		e.preventDefault();
 		
 		// .append() 선택된 요소의 마지막에 새로운 요소나 콘텐츠를 추가
 		moveForm.append("<input type='hidden' name='authorId' value='"+ $(this).attr("href") + "'>");
 		moveForm.attr("action", "/admin/authorDetail");
 		moveForm.submit();
 		
 	});
 </script>
 
 
</body>
</html>
