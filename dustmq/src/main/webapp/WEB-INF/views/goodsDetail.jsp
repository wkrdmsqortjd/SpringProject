<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>          
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome BookMall</title>
<link rel="stylesheet" href="/resources/css/goodsDetail.css">
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
				<c:if test="${member != null }">			<!-- 로그인 o -->		
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
						<a href="/cart/${member.memberId}">장바구니</a>
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
				<a href="/main"><img src="/resources/img/guhaebang_logo.png"></a>
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
				<div class="line">
			</div>			
			<div class="content_top">
				<div class="ct_left_area">	<!-- 이미지가 들어갈 부분 , 태그에 심어둔 data 속성의 데이터값들을 이용해 이미지를 출력 (JavaScript이용) -->
					<div class="image_wrap" data-bookid="${goodsInfo.imageList[0].bookId}" data-path="${goodsInfo.imageList[0].uploadPath}" data-uuid="${goodsInfo.imageList[0].uuid}" data-filename="${goodsInfo.imageList[0].fileName}">
						<img>
					</div>				
				</div>
				<div class="ct_right_area">
					<div class="title">
						<h1>
							${goodsInfo.bookName}
						</h1>
					</div>
					<div class="line">
					</div>
					<div class="author">
						 <span>
						 	${goodsInfo.authorName} 지음
						 </span>
						 <span>|</span>
						 <span>
						 	${goodsInfo.publisher}
						 </span>
						 <span>|</span>
						 <span class="publeyear">	<!-- 날짜 부분은 BookVO에 선언한 타입이 String이기 떄문에 js를 이용해 원하는 형식으로 출력 -->
						 	<fmt:parseDate var="publeYear" value="${goodsInfo.publeYear}" pattern="yyyy-MM-dd" />
						 	<fmt:formatDate value="${publeYear}" pattern="yyyy-MM-dd"/>
						 	${goodsInfo.publeYear}
						 </span>
					</div>
					<div class="line">
					</div>	
					<div class="price">
						<div class="sale_price">정가 : <fmt:formatNumber value="${goodsInfo.bookPrice}" pattern="#,### 원" /></div>
						<div class="discount_price">
							판매가 : <span class="discount_price_number"><fmt:formatNumber value="${goodsInfo.bookPrice - (goodsInfo.bookPrice*goodsInfo.bookDiscount)}" pattern="#,### 원" /></span> 
							[<fmt:formatNumber value="${goodsInfo.bookDiscount*100}" pattern="###" />% 
							<fmt:formatNumber value="${goodsInfo.bookPrice*goodsInfo.bookDiscount}" pattern="#,### 원" /> 할인]</div>							
					</div>		
					<div>
						적립 포인트 : <span class="point_span"></span>원
					</div>	
					<div class="line">
					</div>	
					<div class="button">						
						<div class="button_quantity">
							주문수량
							<input type="text" value="1" class="quantity_input">
							<span>
								<button class="plus_btn">+</button>
								<button class="minus_btn">-</button>
							</span>
						</div>
						<div class="button_set">
							<a class="btn_cart">장바구니 담기</a>
							<a class="btn_buy">바로구매</a>
						</div>
					</div>
				</div>
			</div>
			<div class="line">
			</div>				
			<div class="content_middle">
				<div class="book_intro">
					${goodsInfo.bookIntro}
				</div>
				<div class="book_content">
					${goodsInfo.bookContents }
				</div>
			</div>
			<div class="line">
			</div>				
			<div class="content_bottom">
				리뷰
			</div>

		</div>
		
		 <%@include file="./includes/admin/footer.jsp" %>	<!-- footer --> 
		
	</div>	<!-- class="wrap" -->
</div>	<!-- class="wrapper" -->

<script>

/* 페이지가 렌더링 되면 실행 */
$(document).ready(function(){
	
	/* 이미지 삽입 */
	const bobj = $(".image_wrap");
	
	if(bobj.data("bookId")){
			
		const uploadPath = bobj.data("path");
		const uuid = bobj.data("uuid");
		const fileName = bobj.data("filename");
		
		const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
		
		bobj.find("img").attr('src', '/display?fileName=' + fileCallPath);

	} else {
		
		bobj.find("img").attr('src', '/resources/img/no_Image.png'); 
	}
	
	/* 출판일 변환(String -> Date) */
	const year = "${goodsInfo.publeYear}";
	
	let tempYear = year.substr(0,10);
	
	let yearArray = tempYear.split("-");
	let publeYear = yearArray[0] + "년 " + yearArray[1] + "월 " + yearArray[2] + "일 ";
	
	$(".publeyear").html(publeYear); /* 선택자에 있는 publeYear의 내용을 가져옴 */
	
	/* 포인트 */
	let salePrice = "${goodsInfo.bookPrice - (goodsInfo.bookPrice * goodsInfo.bookDiscount)}";	// 할인 가
	let point = salePrice * 0.05;	// 포인트
	point = Math.floor(point);		// 반올림(소수점 나머지를 제거)
	$(".point_span").text(point);	// text를 읽음
	
});	// $(document).ready(function())

	/* 수량 버튼 조작 */
	let quantity = $(".quantity_input").val();
	
    /* + 버튼을 누르면 */
	$(".plus_btn").on("click", function(){
			$(".quantity_input").val(++quantity);
	});
	
	/* - 버튼을 누르면 */
	$(".minus_btn").on("click", function(){
		if(quantity > 1){							 /* 수량이 0 이하가 되는것을 방지 */
			$(".quantity_input").val(--quantity);	
		}
	});
	
	/* 서버로 전송할 데이터 */
	const form = {
			
			memberId : '${member.memberId}',
			bookId : '${goodsInfo.bookId}',
			bookCount : ''
	}
	
	/* 장바구니 추가 버튼 */
	$(".btn_cart").on("click", function(e){
		
		form.bookCount = $(".quantity_input").val();	// 추가 버튼을 누르면 수량의 값이 bookCount에 할당
		$.ajax({
				url: '/cart/add',			// 호출할 url
				type: 'POST',				// 호출할 방법
				data: form,					// 서버로 보낼 데이터
				success: function(result){	// 서버가 요청을 성공적으로 수행했을 때 수행될 메서드, 파라미터는 서버가 반환한 값
						console.log(result);
						cartAlert(result);
					}	
		})	// $.ajax()
	});
	
	function cartAlert(result){
		if(result == '0'){
			alert("장바구니에 추가를 하지 못하였습니다.");
		} else if(result == '1'){
			alert("장바구니에 추가되었습니다.");
		} else if(result == '2'){
			alert("장바구니에 이미 추가되었습니다.");
		} else if(result == '5'){
			alert("로그인 후 이용가능합니다.");
		}	
	}

</script>

</body>
</html>