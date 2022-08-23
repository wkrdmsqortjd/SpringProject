<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>          
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome BookMall</title>
<!-- slick - css -->
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<link rel="stylesheet" href="resources/css/search.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
</head>
<body>

<%@include file="includes/member/header.jsp" %>

<div class="clearfix"></div>	

		<div class="content_area">
				
		<!-- 게시물 O -->
		<c:if test="${listcheck != 'empty' }">
				<div class="search_filter">
					<div class="filter_button_wrap">
						<button class="filter_button filter_active" id="filter_button_a">국내</button>
						<button class="filter_button" id="filter_button_b">국외</button>
					</div>	
						
						<!-- 국내 -->
						<div class="filter_content filter_a">
							<!-- model 객체를 통해 데이터 전달 -->
							<c:forEach items="${filter_info}" var="filter">
								<c:if test="${filter.cateGroup eq '1'}">
									<a href="${filter.cateCode}">${filter.cateName}(${filter.cateCount})</a>
								</c:if>		
							</c:forEach>
						</div>
						
						<!-- 국외 -->
						<div class="filter_content filter_b">
							<c:forEach items="${filter_info}" var="filter">
								<c:if test="${filter.cateGroup eq '2'}">
									<a href="${filter.cateCode}">${filter.cateName}(${filter.cateCount})</a>
								</c:if>
							</c:forEach>
						</div>	
						
						<!-- 필터 정보를 form태그를 통해서 search.jsp에 전달 -->
						<form id="filter_form" action="/search" method="get" >
							<input type="hidden" name="keyword">
							<input type="hidden" name="cateCode">
							<input type="hidden" name="type">
						</form>			
						
				</div>
				
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
													<a href="/goodsDetail/${list.bookId}">	<!-- @PathVariable -->
														${list.bookName}
													</a>
													
												</div>
												<div class="author">
												<!-- String 타입의 publeYear을 Date타입으로 바꾸기 위해 parseDate 사용 -->
												<fmt:parseDate var="publeYear" value="${list.publeYear}" pattern="yyyy-MM-dd" />
													${list.authorName} 지음 | ${list.publisher} | <fmt:formatDate value="${publeYear}" pattern="yyyy-MM-dd"/>
													
												</div>
										</td>
										<td class="info">
												<div class="rating">
													${list.ratingAvg} 점
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
	                   		<a href="${pageMaker.pageEnd + 1}">다음</a>
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
	
	/* 검색 필터 - 버튼을 누름에 따라 해당 필터링의 정보들이 담겨있음 */
	let buttonA = $("#filter_button_a");
	let buttonB = $("#filter_button_b");
	
	/* 버튼을 눌렀을 때 해당 데이터 이외의 데이터는 안보이게 구현 */
	buttonA.on("click", function(){
		$(".filter_b").css("display", "none");
		$(".filter_a").css("display", "block");		
		buttonA.attr("class", "filter_button filter_active");
		buttonB.attr("class", "filter_button");
	});
	
	buttonB.on("click", function(){
		$(".filter_a").css("display", "none");
		$(".filter_b").css("display", "block");
		buttonB.attr("class", "filter_button filter_active");
		buttonA.attr("class", "filter_button");		
	});
	
	/* 필터링 태그 동작 관련 */
	$(".filter_content a").on("click", function(e){
			e.preventDefault();
			
			// 검색 타입
			let type = '<c:out value="${pageMaker.cri.type}"/>';
			
			if(type === 'A' || type === 'T'){
				type = type + 'C';				// 검색 조건이 "AC" , "AT"
			}
			
			// 검색 키워드
			let keyword = '<c:out value="${pageMaker.cri.keyword}"/>';
			
			// 카테고리 코드
			let cateCode= $(this).attr("href");
			
			// <form> 태그에 input 태그안으로 값을 저장
			$("#filter_form input[name='keyword']").val(keyword);
			$("#filter_form input[name='cateCode']").val(cateCode);
			$("#filter_form input[name='type']").val(type);
			
			// form태그 전달
			$("#filter_form").submit();
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