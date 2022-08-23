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
<!-- slick - css -->
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<!-- slick - js -->
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
</head>
<body>

<!-- header -->
<%@include file="includes/member/header2.jsp" %>

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
							[<fmt:formatNumber value="${goodsInfo.bookDiscount * 100}" pattern="###" />% 
							<fmt:formatNumber value="${goodsInfo.bookPrice * goodsInfo.bookDiscount}" pattern="#,### 원" /> 할인]</div>							
					</div>		
					<div class="point_info">
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
				<div class="reply_subject">
					<h2>리뷰</h2>
				</div>
				
				<!-- 로그인한 회원에게만 보이도록 if태그 사용 -->
				<c:if test="${member != null }">
					<div class="reply_button_wrap">
						<button>리뷰 등록</button>				
					</div>
				</c:if>
				
				<!-- 동적으로 구현할 태그의 데이터 -->
				<div class="reply_not_div">			<!-- 댓글이 없을 경우 -->
				
				</div>
				
				<ul class="reply_content_ul">		<!-- 댓글이 존재할 때 '페이징 댓글 정보' 가 삽입 -->
				</ul>				
				
				<div class="reply_pageInfo_div">	<!-- 댓글 페이지 버튼이 삽입될 태그 -->
					<ul class="pageMaker">

					</ul>
				</div>
			</div>
		</div>
		
		<!-- 주문 form -->
		<form action="/order/${member.memberId}" method="get" class="order_form">
			<input type="hidden" name="orders[0].bookId" value="${goodsInfo.bookId}">
			<input type="hidden" name="orders[0].bookCount" value="">	<!-- 수량은 사용자가 바로구매 버튼을 눌렀을 때 확정 (js 코드) -->
		</form>
		
		 <%@include file="./includes/member/footer.jsp" %>	<!-- footer --> 
		
	</div>	<!-- class="wrap" -->
</div>	<!-- class="wrapper" -->

<script>

/* 페이지가 렌더링 되면 실행 */
$(document).ready(function(){
	
	
	/* 브랜드 로고 이미지 삽입 - 자꾸 text/html로 응답이 옴 */
	const lobj = $(".logo_area");
	lobj.find("img").attr('src', '/resources/img/BookShop.png');
	
	/* 이미지 삽입 */
	const bobj = $(".image_wrap");
	
	if(bobj.data("bookid")){
			
		console.log(bobj);
		
		const uploadPath = bobj.data("path");
		const uuid = bobj.data("uuid");
		const fileName = bobj.data("filename");
		
		const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
		
		
		bobj.find("img").attr('src', '/display?fileName=' + fileCallPath);

	} else {
		
		bobj.find("img").attr('src', '/resources/img/no_Image.png'); 
	}
	
	/* 출판일 - 변환(String -> Date) */
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
	
	/* 리뷰 리스트 출력 */
	const bookId = '${goodsInfo.bookId}';
	
	$.getJSON("/reply/list", {bookId : bookId}, function(obj){

		/* 댓글 페이지, 페이징 정보 함수 호출 */
		makeReplyContent(obj);	
		
	});
	
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
						cartAlert(result);
					}	
		});	// $.ajax()
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
	
	/* 바로구매 버튼 */
	$(".btn_buy").on("click", function(){
		
		let bookCount = $(".quantity_input").val();
		$(".order_form").find("input[name='orders[0].bookCount']").val(bookCount);
		$(".order_form").submit();
	});

	/* 리뷰 등록 */
	$(".reply_button_wrap").on("click", function(e){
		
		e.preventDefault();
		
		const memberId = '${member.memberId}';
		const bookId = '${goodsInfo.bookId}';
		
		/* 댓글 확인 요청 */
		$.ajax({
			
			data : {
					bookId : bookId,
					memberId : memberId
			},
			url : '/reply/check',
			type : 'POST',
			success : function(result){
				
				if(result === '1'){
					alert("이미 등록된 리뷰가 존재 합니다.")
				} else if(result === '0') {
					let popUrl = "/replyEnroll/" + memberId + "?bookId=" + bookId;
					console.log(popUrl);
					let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes";
					
					window.open(popUrl,"리뷰 쓰기",popOption);							
				}
				
			}
		});	// ajax()
	});
	
	/* 댓글 페이지 정보 객체 */
	const cri = {
		bookId : '${goodsInfo.bookId}',
		pageNum : 1,
		amount : 10
	}
	
	/* 댓글 페이지 이동 버튼 동작 */
	$(document).on('click', '.pageMaker_btn a', function(e){
		
		e.preventDefault();
		
		/* 회원이 클릭한 페이지 번호 */
		let page = $(this).attr("href");
		
		/* 현제 페이지 정보를 저장하는 cri 객체의 pageNum의 속성 값을 사용자가 클릭한 숫자로 변경 후 대입 */
		cri.pageNum = page;
		
		/* 댓글 리스트를 서버에 요청 후 댓글 태그를 최신화 하는 replyListInit() 함수 호출 */
		replyListInit();
		
	});
	
	/* 댓글 데이터 서버 요청 및 댓글 동적 생성 함수 */
	let replyListInit = function(){
		$.getJSON("/reply/list", cri , function(obj){
			
			makeReplyContent(obj);
			
		});		
	}	
	
	/* 리뷰 수정 버튼 */
	$(document).on('click', '.update_reply_btn', function(e){
		
		e.preventDefault();
		
		let replyId = $(this).attr("href");
		let popUrl = "/replyUpdate?replyId=" + replyId + "&bookId=" + '${goodsInfo.bookId}' + "&memberId=" + '${member.memberId}';
		let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes"
	
		window.open(popUrl, "리뷰 수정", popOption);
	});
	
	/* 리뷰 삭제 버튼 */
	 $(document).on('click', '.delete_reply_btn', function(e){

		 e.preventDefault();
		 
		 let replyId = $(this).attr("href");	
		 
		 $.ajax({
				data : {
					replyId : replyId,
					bookId : '${goodsInfo.bookId}'
				},
				url : '/reply/delete',
				type : 'POST',
				success : function(result){
					replyListInit();
// 					alert('삭제가 완료되었습니다.');	
				}
			});	// $.ajax()	
		 
	 });
	
	/* 댓글 동적 생성 함수 */
	function makeReplyContent(obj) {	// obj는 서버로부터 전달받은 댓글 데이터 정보
		
		if(obj.list.length === 0){
			$(".reply_not_div").html('<span>리뷰가 없습니다.</span>');
			$(".reply_content_ul").html('');
			$(".pageMaker").html('');
		} else{
			
			$(".reply_not_div").html('');
			
			const list = obj.list;
			const pf = obj.pageInfo;
			const userId = '${member.memberId}';		
			
			/* list */
			
			let reply_list = '';			
			
			$(list).each(function(i,obj){
				reply_list += '<li>';
				reply_list += '<div class="comment_wrap">';
				reply_list += '<div class="reply_top">';
				
				/* 아이디 */
				reply_list += '<span class="id_span">'+ obj.memberId+'</span>';
				/* 날짜 */
				reply_list += '<span class="date_span">'+ obj.regDate +'</span>';
				/* 평점 */
				reply_list += '<span class="rating_span">평점 : <span class="rating_value_span">'+ obj.rating +'</span>점</span>';
				
				if(obj.memberId === userId){
					reply_list += '<a class="update_reply_btn" href="'+ obj.replyId +'">수정</a><a class="delete_reply_btn" href="'+ obj.replyId +'">삭제</a>';
				}
				reply_list += '</div>';		 //<div class="reply_top">
				reply_list += '<div class="reply_bottom">';
				reply_list += '<div class="reply_bottom_txt">'+ obj.content +'</div>';
				reply_list += '</div>';		//<div class="reply_bottom">
				reply_list += '</div>';		//<div class="comment_wrap">
				reply_list += '</li>';
			});		
			
			$(".reply_content_ul").html(reply_list);			
			
			/* 페이지 버튼 */
			let reply_pageMaker = '';	
			
				/* 이전 */
				if(pf.prev){
					let prev_num = pf.pageStart -1;
					reply_pageMaker += '<li class="pageMaker_btn prev">';
					reply_pageMaker += '<a href="'+ prev_num +'">이전</a>';
					reply_pageMaker += '</li>';	
				}
				/* 숫자(버튼) */
				for(let i = pf.pageStart; i < pf.pageEnd+1; i++){
					reply_pageMaker += '<li class="pageMaker_btn ';
					if(pf.cri.pageNum === i){
						reply_pageMaker += 'active';
					}
					reply_pageMaker += '">';
					reply_pageMaker += '<a href="'+i+'">'+i+'</a>';
					reply_pageMaker += '</li>';
				}
				/* 다음 */
				if(pf.next){
					let next_num = pf.pageEnd +1;
					reply_pageMaker += '<li class="pageMaker_btn next">';
					reply_pageMaker += '<a href="'+ next_num +'">다음</a>';
					reply_pageMaker += '</li>';	
				}	
				
			$(".pageMaker").html(reply_pageMaker);				
			
		}
		
	}
	
</script>

</body>
</html>