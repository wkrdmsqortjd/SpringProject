<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/orderList.css">
 
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
</head>
<body>
 
    		 <%@include file="../includes/admin/header.jsp" %>	<!-- header -->
    
                <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>주문 현황</span></div>
                <!-- 테이블 형식으로 전달받은 데이터를 보여줌 -->
                <div class="author_table_wrap">
                
                	<!-- 주문 상품 o -->
                	<c:if test="${listCheck != 'empty' }">
                   		<table class="order_table">
		                    	<colgroup>
			                    		<col width="21%">
			                    		<col width="20%">
			                    		<col width="20%">
			                    		<col width="20%">
			                    		<col width="19%%">
		                    	</colgroup>
	                    		
	                    		<thead>
	                    			<tr>
	                    				<td class="th_column_1">주문 번호</td>
	                    				<td class="th_column_2">주문 아이디</td>
	                    				<td class="th_column_3">주문 날짜</td>
	                    				<td class="th_column_4">주문 상태</td>
	                    				<td class="th_column_5">취소</td>
	                    			</tr>
	                    		</thead>
	                    		
	                    		<c:forEach items="${list}" var="list"> <!-- 상품 정보들을 하나씩 순회 -->
		                    		<tr>
		                    			<td><c:out value="${list.orderId}"></c:out> </td>
		                    			<td><c:out value="${list.memberId}"></c:out></td>
		                    			<td><fmt:formatDate value="${list.orderDate}" pattern="yyyy-MM-dd"/></td>
		                    			<td><c:out value="${list.orderState}"/></td>
		                    			<td>
		                    				<c:if test="${list.orderState == '배송준비' }">
		                    					<button class="delete_btn" data-orderid="${list.orderId}" data-memberId="${list.memberId}">주문 취소</button>
	                    					</c:if>
		                    			</td>
		                    		</tr>
	                    		</c:forEach>
	                    </table>
                   	</c:if>       
                   	
                   	<!-- 주문 상품 x -->
                   	<c:if test="${listCheck == 'empty' }">
                   		<div class="table_empty">
                   			등록된 작가가 없습니다.
                   		</div>
                   	</c:if>       			
                    </div>   
                    
                    <!-- 검색 영역 -->
                    <div class="search_wrap">
                    	<form id="searchForm" action="/admin/orderList" method="get">
                    		<div class="search_input">
                    			<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
                    			<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"></c:out>'>
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
	                    		     해당 버튼에 현재 페이징을 할 수 있도록 css 설정을 해줄 것 -->
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
                    <form id="moveForm" action="/admin/orderList" method="get">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
					</form>
                                     
                    <!-- 주문 취소 눌렀을 때 서버 요청 --> 
                    <form id="deleteForm" action="/admin/orderCancel" method="post">
                    		<input type="hidden" name="orderId">
                    		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
							<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
							<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
							<input type="hidden" name="memberId">
                    </form> 
                </div>
			
			 <%@include file="../includes/admin/footer.jsp" %>	<!-- footer -->

<script>

	let searchForm = $('#searchForm');
	let moveForm = $('#moveForm');
	
	/* 작가 검색 버튼 작동 */
	$("#searchForm button").on("click", function(e){
		
		e.preventDefault();
		
		/* 검색 키워드 유효성 체크 */
		if(!searchForm.find("input[name='keyword']").val()){	/* keyword 가 없다면 */
				alert("키워드를 입력하시오");
				return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");		/* 페이지 번호를 1로 대입, 검색하면 1페이지 부터 */
		
		searchForm.submit();

	});
	
	/* 페이지 이동 버튼 작동 */
	$(".pageMaker_btn a").on("click", function(e){
		
		e.preventDefault();

		/* console.log($(this).attr("href"));	 */
		
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));	/* 각 눌렀던 href의 속성을 추가 */
		
		moveForm.submit();
		
	});
	
	/* 최소 버튼 클릭 */
	$(".delete_btn").on("click", function(e){
		
		e.preventDefault();
		
		let id = $(this).data("orderid");	/* 버튼에 orderId 데이터 값을 id에 저장 */
		let memid = $(this).data("memberid");
		
		$("#deleteForm").find("input[name='orderId']").val(id);
		$("#deleteForm").find("input[name='memberId']").val(memid);
		
		$("#deleteForm").submit();
		
	});

</script>
 
</body>
</html>
