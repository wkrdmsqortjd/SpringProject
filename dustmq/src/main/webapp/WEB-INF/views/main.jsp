<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Welcome BookMall</title>
<link rel="stylesheet" href="resources/css/main.css">

<!-- slick - css -->
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>

<!-- font awesome -->
<script src="https://kit.fontawesome.com/1986c6b16c.js" crossorigin="anonymous"></script>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>

<!-- slick - js -->
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<style type="text/css">

	.slick-prev{
		left: 100px;
		/* z-index: 1; */
	}
	
	.slick-next{
		right: 100px;
		/* z-index: 1; */
	}
	
	.slick-prev:before, .slick-next:before{
		color: gray;
	}

</style>

</head>
<body>

<%@include file="includes/member/header.jsp" %>

<%-- <div class="wrapper">
	<div class="wrap">
		<div class="top_gnb_area">
		<div class="brand_name">
			Spring Project
		</div>
			<ul class="list">
				<c:if test = "${member == null }">	<!-- 비 로그인 -->
					<li>
						<a href="/member/login">로그인</a>	
					</li>
					<li>
						<a href="/member/join">회원가입</a>
					</li>
				</c:if>
				
				<c:if test = "${member != null }"> 	<!-- 로그인 -->
					<c:if test = "${member.adminCk == 1 }">	<!-- 관리자 계정 -->
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
			<!-- 로고 영역 -->
			<div class="logo_area">
				<a href="/main"><img src="resources/img/guhaebang_logo.png"></a>
			</div>
			<div class="search_area">
				<div class="search_wrap">
               		
               		<form id="searchForm" action="/search" method="get">
               			<div class="search_input">
           					<select name="type">
               					<option value="T"> 책 제목 </option>
               					<option value="A"> 작 가 </option>
            				</select>
               				<input type="text" name="keyword">
                   			<button class='btn search_btn'>
								<i class="fa-solid fa-magnifying-glass"></i>
							</button>                				
               			</div>
               		</form>
               	
               	</div>
			</div>
			<div class="login_area">
			
			<!-- 로그인 하지 않은 상태 -->
			<c:if test = "${member == null }">
				<div class="login_button"><a href="/member/login">로그인</a></div>
			</c:if>
			
			<!-- 로그인한 상태 -->
	        <c:if test="${ member != null }">
                <div class="login_success_area">
                    <span>회원 : ${member.memberName}</span>
                    <span>충전금액 :<fmt:formatNumber value="${member.money }" pattern="\#,###.##"/></span>
                    <span>포인트 :<fmt:formatNumber value="${member.point }" pattern="#,###" /></span>
              		<a href="/member/logout.do">로그아웃</a>
                </div>
            </c:if>		
			
			</div> --%>
			<div class="clearfix"></div>			
		</div>
		<div class="navi_bar_area">
			<div class="dropdown">
			    <button class="dropbtn">국내  
				<i class="fa-solid fa-arrow-down"></i>
			    </button>
			    <div class="dropdown-content">
					<c:forEach items="${cate1}" var="cate">
						<a href="search?type=C&cateCode=${cate.cateCode}">${cate.cateName}</a>
					</c:forEach>
			    </div>			
			</div>
			<div class="dropdown">
			    <button class="dropbtn">국외 
			      <i class="fa-solid fa-arrow-down"></i>
			    </button>
			    <div class="dropdown-content">
			    	<c:forEach items="${cate2}" var="cate">
						<a href="search?type=C&cateCode=${cate.cateCode}">${cate.cateName}</a>
					</c:forEach>		      		      
			    </div>			
			</div>
		</div>
		<div class="content_area">
		
			<div class="slide_div_wrap">
				<div class="slide_div">
					<div>
						<a>
							<img src="../resources/img/no_Image.png">
						</a>
					</div>
					<div>
						<a>
							<img src="../resources/img/no_Image.png">
						</a>
					</div>
					<div>
						<a>
							<img src="../resources/img/no_Image.png">
						</a>
					</div>				
				</div>	
			</div>
			
			<!-- 평점순 이미지 -->
			<div class="ls_wrap">
				<div class="ls_div_subject">
					평점순 상품
				</div>
				<div class="ls_div">
					<c:forEach items="${ls}" var="ls">
						<a href="/goodsDetail/${ls.bookId}">
							<div class="ls_div_content_wrap">
								<div class="ls_div_content">
									<div class="image_wrap" data-bookid="${ls.imageList[0].bookId}" data-path="${ls.imageList[0].uploadPath}" data-uuid="${ls.imageList[0].uuid}" data-filename="${ls.imageList[0].fileName}">
										<img>
									</div>				
									<div class="ls_category">	<!-- 분류 이름 -->
										${ls.cateName}
									</div>
									<div class="ls_rating">		<!-- 평점 -->
										${ls.ratingAvg}
									</div>
									<div class="ls_bookName">	<!-- 책 이름 -->
										${ls.bookName}
									</div>							
								</div>
							</div>
						</a>					
					</c:forEach>					
				</div>
			</div>
		
		</div>
		
	
	</div>	<!-- class="wrap" -->
</div>	<!-- class="wrapper" -->
        <div class="footer">
            <div class="footer_container">
                
                <div class="footer_left">
                    <img src="resources/img/guhaebang_logo.png">
                </div>
                <div class="footer_right">
                    (주) GUHAEBANG    대표이사 : OOO
                    <br>
                    사업자등록번호 : ooo-oo-ooooo
                    <br>
                    대표전화 : oooo-oooo(발신자 부담전화)
                    <br>
                    <br>
                    COPYRIGHT(C) <strong>guhaebang.naver.com</strong>    ALL RIGHTS RESERVED.
                </div>
                <div class="clearfix"></div>
            </div>
        </div> <!-- class="footer" -->    

<script>

$(document).ready(function(){
	
	/* 이벤트 베너 */
	$(".slide_div").slick(
			{
				dots: true,
				autoplay : true,
				autoplaySpeed: 5000
			}				
	);	
	
	/* 베스트 상품 */
	$(".ls_div").slick({
		slidesToShow: 4,
		slidesToScroll: 4,
		prevArrow : "<button type='button' class='ls_div_content_prev'>←</button>",		// 이전 화살표 모양 설정
		nextArrow : "<button type='button' class='ls_div_content_next'>→</button>",		// 다음 화살표 모양 설정	

		/* 화면의 크기에 따라 달라짐 */
		responsive: [ // 반응형 웹 구현 옵션
                    {  
                        breakpoint: 960, //화면 사이즈 960px 일 때, 3개 출력
                        settings: {
                            slidesToShow:3 
                        } 
                    },
                    { 
                        breakpoint: 768, //화면 사이즈 768px 일 때, 2개 출력
                        settings: {    
                            slidesToShow:2 
                        } 
                    }
                ]
	});		
	
	/* 이미지 삽입 */
	$(".image_wrap").each(function(i, obj){
		
		const bobj = $(obj);
		
		if(bobj.data("bookid")){
			const uploadPath = bobj.data("path");
			const uuid = bobj.data("uuid");
			const fileName = bobj.data("filename");
			
			const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
			
			$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
		} else {
			$(this).find("img").attr('src', '/resources/img/goodsNoImage.png');
		}
		
	});			
	
	/* 검색 버튼 동작 */
	$(".search_btn").on("click", function(){
		
		let searchKeyword = $(".search_input input[name='keyword']").val();
		
		if(searchKeyword == "" || searchKeyword == null) {
			alert("검색어를 입력하세요");
			return false;
		}
		
		$(this).submit();
	});
	
});		/* ready() */


 
    /* gnb_area 로그아웃 버튼 작동 */
    $("#gnb_logout_button").click(function(){
        
        $.ajax({
        	type : "POST",
        	url : "/member/logout.do",
        	success : function(data){
        		alert("로그아웃 성공");
        		document.location.reload();	// 새로 고침
        	}
        });	// ajax
    });
    
</script>

</body>
</html>