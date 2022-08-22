<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome GUHAEBANG</title>
<link rel ="stylesheet" href = "resources/css/main.css">
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
 <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
 
 <style type="text/css">

	.slick-prev{
		left: 100px;
	}
	
	.slick-next{
		right: 100px;
	}
	
	.slick-prev:before, .slick-next:before{
		color: gray;
	}

</style>
 
</head>
<body>

<%@include file="includes/member/header_kakao.jsp" %>

			<div class = "clearfix"></div>
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
					베스트 상품
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
       <%@include file="includes/member/footer.jsp" %>
<script>
$(document).ready(function(){
	
	/* 이벤트 베너 */
	$(".slide_div").slick(
			{
				dots : true,
				autoplay : true,
				autoplaySpeed : 5000
			}				
	);	
	
	/* 베너 슬릭 */
	$(".slick_banner").slick(
		{
			dots : false,
			autoplay : true,
			autoplaySpeed : 3000,
			arrows : false
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