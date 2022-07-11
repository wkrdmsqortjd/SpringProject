<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>          
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome BookMall</title>
<link rel="stylesheet" href="resources/css/search.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>

<div class="wrapper">
	<div class="wrap">
		<div class="top_gnb_area">
			<ul class="list">
				<c:if test = "${member == null}">	<!-- 로그인 x -->	
					<li >
						<a href="/member/login">로그인</a>
					</li>
					<li>
						<a href="/member/join">회원가입</a>
					</li>
				</c:if>
				<c:if test="${member != null }">	<!-- 로그인 o -->		
					<c:if test="${member.adminCk == 1 }">	<!-- 관리자 계정 -->
						<li><a href="/admin/main">관리자 페이지</a></li>
					</c:if>							
					<li>
						<a id="gnb_logout_button">로그아웃</a>
					</li>
					<li>
						마이룸
					</li>
					<li>
						장바구니
					</li>
				</c:if>				
				<li>
					고객센터
				</li>			
			</ul>			
		</div>
		<div class="top_area">
			<!-- 로고영역 -->
			<div class="logo_area">
				<a href="/main"><img src="resources/img/guhaebang_logo.png"></a>
			</div>
			<div class="search_area">
                	<div class="search_wrap">
                		<form id="searchForm" action="/search" method="get">
                			<div class="search_input">
                				<select name="type">
                					<option value="T">책 제목</option>
                					<option value="A">작가</option>
                				</select>
                				<!-- 검색 인터페이스 부분에도 사용자가 사용한 데이터들을 값을 가지도록 코드 추가 -->
                				<input type="text" name="keyword" value="<c:out value="${PageMaker.cri.keyword}"/>">
                    			<button class='btn search_btn'>검 색</button>                				
                			</div>
                		</form>
                	</div>
			</div>
			<div class="login_area">
			
				<!-- 로그인 하지 않은 상태 -->
				<c:if test = "${member == null }">
					<div class="login_button"><a href="/member/login">로그인</a></div>
					<span><a href="/member/join">회원가입</a></span>				
				</c:if>				
				
				<!-- 로그인한 상태 -->
				<c:if test="${ member != null }">
					<div class="login_success_area">
						<span>회원 : ${member.memberName}</span>
						<span>충전금액 : <fmt:formatNumber value="${member.money }" pattern="\#,###.##"/></span>
						<span>포인트 : <fmt:formatNumber value="${member.point }" pattern="#,###" /></span>
						<a href="/member/logout.do">로그아웃</a>
					</div>
				</c:if>
				
			</div>
			<div class="clearfix"></div>			
		</div>
		
		<div class="content_area">
				
		<!-- 게시물 O -->
		<c:if test="${listcheck != 'empty' }">
			<!-- 검색결과에 따른 데이터 -->
			<div class="list_search_result">
				<table class="type_list">
						<colgroup>	<!-- 테이블 태그에서 서식 지정을 위해 하나 이상의 열을 그룹으로 묶을 떄 사용 -->
								<col width="110">
								<col width="*">
								<col width="120">
								<col width="120">
								<col width="120">
						</colgroup>				
						<tbody id="searchList">
								<c:forEach items="${list}" var="list">
									<tr>
										<td class="image">
												<div class="image_wrap" data-bookid="${list.imageList[0].bookId}" data-path="${list.imageList[0].uploadPath}" data-uuid="${list.imageList[0].uuid}" data-filename="${list.imageList[0].fileName}">
														<img>
												</div>
										</td>
										<td class="detail">
												<div class="category">
													[${list.cateName}]
												</div>
												<div class="title">
													${list.bookName}
												</div>
												<div class="author">
												<!-- String 타입의 publeYear을 Date타입으로 바꾸기 위해 parseDate 사용 -->
												<fmt:parseDate var="publeYear" value="${list.publeYear}" pattern="yyyy-MM-dd" />
													${list.authorName} 지음 | ${list.publisher} | <fmt:formatDate value="${publeYear}" pattern="yyyy-MM-dd"/>
													
												</div>
										</td>
										<td class="info">
											<div class="rating">
													평점(추후 추가)
											</div>
										</td>
										<td class="price">
												<div class="org_price">
													<del>	<!-- 텍스트 가운데 한 라인을 추가해 삭제된 텍스터를 표시 -->
															<fmt:formatNumber value="${list.bookPrice}" pattern="#,### 원"/>	<!-- fmt태그를 사용해 금액표시 설정 -->
													</del>
												</div>
												<div class="sell_price">
													<strong>
															<fmt:formatNumber value="${list.bookPrice * (1-list.bookDiscount)}" pattern="#,### 원"/>
													</strong>
												</div>
											</td>
											<td class="option"></td>
										</tr>
								</c:forEach>
						</tbody>
				</table>
			</div>
			
			<!-- 페이지 이동 인터페이스 -->
			<div class="pageMaker_wrap">
				<ul class="pageMaker">
				
					<!-- 이전 버튼 -->
					<c:if test="${pageMaker.prev}">
						<li class="pageMaker_btn prev">
							<a href="${pageMaker.pageStart - 1}"> 이전 </a>
						</li>
					</c:if>
					
					<!-- 페이지 번호 -->
					<c:forEach begin="${pageMaker.pageStart}" end="${pageMaker.pageEnd}" var="num">
						<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active' : '' }">		
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
			
			<!-- form태그를 활용해 이동방식을 적용 -->
			<form id="moveForm" action="/search" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
				<input type="hidden" name="type" value="${pageMaker.cri.type}">
			</form>
		
		</c:if>
		<!-- 게시물 X -->
		<c:if test="${listcheck == 'empty' }">
			<div class="table_empty">
				검색결과가 없습니다.
			</div>
		</c:if>
				
		</div>
		
		 <%@include file="./includes/admin/footer.jsp" %>	<!-- footer --> 
		
	</div>	<!-- class="wrap" -->
</div>	<!-- class="wrapper" -->

<script>

	/* gnb_area 로그아웃 버튼 작동 */
	$("#gnb_logout_button").click(function(){
		// alert("버튼 작동");
		$.ajax({
			type:"POST",
			url:"/member/logout.do",
			success:function(data){
				alert("로그아웃 성공");
				document.location.reload();	 
			} 
		}); // ajax 
	});
	
	/* 페이지 이동 버튼 */
	const moveForm = $('#moveForm');
	
	$(".pageMaker_btn a").on("click", function(e){
		
		e.preventDefault();
		
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));	// pageNum는 사용자가 누른 페이지의 a태그 정보를 삽입
		
		moveForm.submit();	// 위 정보들을 서버로 전송
		
	});
	
	// <select>태그에 있는 <option>태그에서 selected 속성을 부여해주기 코드 추가
	$(document).ready(function(){
		
		// 검색 타입 selected
		const selectedType = '<c:out value="${pageMaker.cri.type}"/>';
		
		if(selectedType != ""){
				$("select[name='type']").val(selectedType).attr("selected", "selected");			
		}
		
		/* 이미지 삽입 */
		$(".image_wrap").each(function(i, obj){	// i는 순회할 떄 사용될 index고 obj는 그 순서의 객체
			
			const bobj = $(obj);
		
			if(bobj.data("bookid")){	// 이미지 파일 데이터가 있는 경우
			
			const uploadPath = bobj.data("path");
			const uuid = bobj.data("uuid");
			const fileName = bobj.data("filename");
			
			// encodeURIComponent는 URI의 특정한 문자를 utf-8로 인코딩, 후에 "/display" 매핑 메서드로 전달
			const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
			
			// <img>태그에 이미지를 호출하는 url을 값으로 가지는 src속성이 추가
			$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
			
			} else {
						$(this).find("img").attr('src', '/resources/img/no_Image.png')				
			}
		});
	});	// ready(function)
	
</script>

</body>
</html>