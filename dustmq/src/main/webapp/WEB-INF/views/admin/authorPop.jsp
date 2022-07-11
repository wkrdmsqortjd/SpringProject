<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/authorPop.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>	<!-- 페이지 인터페이스가 동작하는 Jquery -->
</head>
<body>
	
	<div class="subject_name_warp">
			<span>작가 선택</span>
		</div>
		<div class="content_wrap">
               	<!-- 게시물 표 영역 -->
				<div class="author_table_wrap">
               		<!-- 게시물 O -->
               		<c:if test="${listCheck != 'empty'}">
               			<div class="table_exist">
	                    	<table class="author_table">
	                    		<thead>
	                    			<tr>
	                    				<td class="th_column_1">작가 번호</td>
	                    				<td class="th_column_2">작가 이름</td>
	                    				<td class="th_column_3">작가 국가</td>
	                    			</tr>
	                    		</thead>
	                    		
	                    		<!-- forEach는 List, 배열 요소를 순서대로 반복해서 처리하는 태그 var는 변수명 items는 컬랙션 객체 -->
	                    		<c:forEach items="${list}" var="list">
	                    		<tr>
	                    			<td><c:out value="${list.authorId}"></c:out> </td>
	                    			
                    			<td>														<!-- data-name 속성을 사용하여 <a>태그에 '작가이름' 데이터를 저장 -->
		                    			<a class="move" href='<c:out value="${list.authorId}"/>' data-name='<c:out value="${list.authorName}"/>'>
		                    				<c:out value="${list.authorName }"></c:out>
		                    			</a>
	                    			</td>
	                    			
	                    			<td><c:out value="${list.nationName}"></c:out> </td>
	                    		</tr>
	                    		</c:forEach>
	                    	</table>
                    	</div>                			
               		</c:if>
               		<!-- 게시물 x -->
               		<c:if test="${listCheck == 'empty'}">
               			<div class="table_empty">
               				등록된 작가가 없습니다.
               			</div>
               		</c:if>
               		
                    <!-- 검색 영역 -->
                    <div class="search_wrap">
                    	<form id="searchForm" action="/admin/authorPop" method="get">
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
	                    		<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? "active":""}">
	                    			<a href="${num}">${num}</a>
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
               		
					<form id="moveForm" action="/admin/authorPop" method="get">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
					</form>               		
               		
		</div>

	</div>
	
<script>

	let searchForm = $('#searchForm');
	let moveForm = $('#moveForm');
	
	/* 작가 검색 버튼 동작 */
	$('#searchForm button').on("click", function(e){
		
		e.preventDefault();
		
		/* 검색 키워드 유효성 검사 */
		if(!searchForm.find("input[name='keyword']").val()) {
					
			alert("키워드를 입력하십시오,");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		
		searchForm.submit();
		
	});
	
	/* 페이지 이동 버튼 */
	$(".pageMaker_btn a").on("click", function(e){
		
		e.preventDefault();
		
		console.log($(this).attr("href"));		// 버튼에 href를 추가
	
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));	// 그 href를 pageNum가 name인 태그에 값을 할당
		
		moveForm.submit();
	
	});
	
	/* 작가 선택 및 팝업창 닫기 */
	$(".move").on("click", function(e){
		
		// <a>태그에 대한 동작을 멈춤
		e.preventDefault();
		
		// 'authorId' 와 'authorName' 변수를 사용자가 클릭한 <a>태그 속성에 저장된 authorId, authorName 데이터로 초기화
		let authorId = $(this).attr("href");	// attr()은 요소의 속성의 값을 가져오거나 속성을 추가, 이 상황은 가져오는 문법
		let authorName= $(this).data("name");	
		
		// 부모 요소에 접근
		$(opener.document).find("#authorId_input").val(authorId);
		$(opener.document).find("#authorName_input").val(authorName);
		
		window.close();	// 팝업창 닫기
		
	});
	
	

</script>
	
	
</body>
</html>