<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>          
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome BookMall</title>
<script src="https://kit.fontawesome.com/1986c6b16c.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/cart.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>

<%@include file="includes/member/header2.jsp" %>

			<div class="clearfix"></div>			
		</div>
		<div class="content_area">
		<div class="content_subject"><span>장바구니</span></div>
			<!-- 장바구니 리스트 -->
			<div class="content_middle_section"></div>
			<!-- 장바구니 가격 합계 -->
			<!-- cartInfo -->
			<div class="content_totalCount_section">
			
			<!-- 체크박스 전체 여부 -->
			<div class="all_check_input_div">
				<input type="checkbox" class="all_check_input input_size_20" checked="checked"><span class="all_chcek_span">전체선택</span>
			</div>
				
				<table class="subject_table">
					<caption>표 제목 부분</caption>
					<tbody>

						<tr>
							<th class="td_width_1"></th>
							<th class="td_width_2"></th>
							<th class="td_width_3">상품명</th>
							<th class="td_width_4">가격</th>
							<th class="td_width_4">수량</th>
							<th class="td_width_4">합계</th>
							<th class="td_width_4">삭제</th>
						</tr>
					</tbody>
				</table>
				<table class="cart_table">
					<caption>표 내용 부분</caption>
					<tbody>
						<c:forEach items="${cartInfo}" var="ci">	<!-- Controller에서 Model을 통해 전달 받은 객체 -->
							<tr>
								<td class="td_width_1 cart_info_td">
									<input type="checkbox" class="individual_cart_checkbox input_size_20" checked="checked">
									<input type="hidden" class="individual_bookPrice_input" value="${ci.bookPrice}">
									<input type="hidden" class="individual_salePrice_input" value="${ci.salePrice}">
									<input type="hidden" class="individual_bookCount_input" value="${ci.bookCount}">
									<input type="hidden" class="individual_totalPrice_input" value="${ci.salePrice * ci.bookCount}">
									<input type="hidden" class="individual_point_input" value="${ci.point}">
									<input type="hidden" class="individual_totalPoint_input" value="${ci.totalPoint}">
									<input type="hidden" class="individual_bookId_input" value="${ci.bookId}">
								</td>
								<td class="td_width_2">
									<div class="image_wrap" data-bookid="${ci.imageList[0].bookId}" data-path="${ci.imageList[0].uploadPath}" data-uuid="${ci.imageList[0].uuid}" data-filename="${ci.imageList[0].fileName}">
										<img>
									</div>
								</td>
								<td class="td_width_3">${ci.bookName}</td>
								<td class="td_width_4 price_td">
									<del>정가 : <fmt:formatNumber value="${ci.bookPrice}" pattern="#,### 원" /></del><br>
									판매가 : <span class="red_color"><fmt:formatNumber value="${ci.salePrice}" pattern="#,### 원" /></span><br>
									포인트 : <span class="green_color"><fmt:formatNumber value="${ci.point}" pattern="#,###" /></span>
								</td>
								<td class="td_width_4 table_text_align_center">
									<div class="table_text_align_center quantity_div">
										<input type="text" value="${ci.bookCount}" class="quantity_input">	
										<button class="quantity_btn plus_btn">+</button>
										<button class="quantity_btn minus_btn">-</button>
									</div>
									<a class="quantity_modify_btn" data-cartid="${ci.cartId}">변경</a>
								</td>
								<td class="td_width_4 table_text_align_center">
									<fmt:formatNumber value="${ci.salePrice * ci.bookCount}" pattern="#,### 원" />
								</td>
								<td class="td_width_4 table_text_align_center>">
									<button class="delete_btn" data-cartid="${ci.cartId}">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<table class="list_table">
				</table>
			</div>
			<!-- 가격 종합 -->
			<div class="content_total_section">
				<div class="total_wrap">
					<table>
						<tr>
							<td>
								<table>
									<tr>
										<td>총 상품 가격</td>
										<td>
											<span class="totalPrice_span">70000</span> 원
										</td>
									</tr>
									<tr>
										<td>배송비</td>
										<td>
											<span class="delivery_price">3000</span>원
										</td>
									</tr>									
									<tr>
										<td>총 주문 상품수</td>
										<td><span class="totalKind_span"></span>종 <span class="totalCount_span"></span>권</td>
									</tr>
								</table>
							</td>
							<td>
								<table>
									<tr>
										<td></td>
										<td></td>
									</tr>
								</table>							
							</td>
						</tr>
					</table>
					<div class="boundary_div">구분선</div>
					<table>
						<tr>
							<td>
								<table>
									<tbody>
										<tr>
											<td>
												<strong>총 결제 예상 금액</strong>
											</td>
											<td>
												<span class="finalTotalPrice_span">70000</span> 원
											</td>
										</tr>
									</tbody>
								</table>
							</td>
							<td>
								<table>
									<tbody>
										<tr>
											<td>
												<strong>총 적립 예상 포인트</strong>
											
											</td>
											<td>
												<span class="totalPoint_span">70000</span> 원
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 구매 버튼 영역 -->
			<div class="content_btn_section">
				<a class="order_btn">주문하기</a>
			</div>
		</div>
		
		<!-- 변경된 데이터 정보를 update 매핑 메서드에 전달 -->
		<form action="/cart/update" method="post" class="quantity_update_form">
			<input type="hidden" name="cartId" class="update_cartId">		
			<input type="hidden" name="bookCount" class="update_bookCount">		
			<input type="hidden" name="memberId" value="${member.memberId}">		
		</form>
		
		<!-- 삭제한 정보를 delete 매핑 메서드에 전달 -->
		<form action="/cart/delete" method="post" class="quantity_delete_form">
				<input type="hidden" name="cartId" class="delete_cartId">
				<input type="hidden" name="memberId" value="${member.memberId}">
		</form>
		
		<!-- 주문 form -->
		<form action="/order/${member.memberId}" method="get" class="order_form">

		</form>
		
		 <%@include file="./includes/admin/footer.jsp" %>	<!-- footer --> 
		
	</div>	<!-- class="wrap" -->
</div>	<!-- class="wrapper" -->

<script>

$(document).ready(function(){
	
	/* 브랜드 로고 이미지 삽입 - 자꾸 text/html로 응답이 옴 */
	const lobj = $(".logo_area");
	lobj.find("img").attr('src', '/resources/img/BookShop.png');
	
	/* 종합 정보 섹션 정보 삽입 */
	setTotalInfo();
	
	/* 이미지 삽입 */
	$(".image_wrap").each(function(i, obj){			// i : 몇 번째 객체인지의 순서 값 ( 배열의 index와 비슷함 )
													// obj : i번째에서 접근하는 객체
		const bobj = $(obj);
	
		if(bobj.data("bookid")){
				
				const uploadPath = bobj.data("path");
				const uuid = bobj.data("uuid");
				const fileName = bobj.data("filename");
				
				const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName); // encodeURIComponent은 URI로 데이터를 전달하기 위해 문자열을 인코딩
				
				$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
		} else {
				$(this).find("img").attr('src', '/resources/img/no_Image.png');
		}		
	});
	
});	// $(document).ready()

	/* 체크여부에 따른 정보의 변화 */
	$(".individual_cart_checkbox").on("change", function(){
		
		// 변화함에 따라 다시 정보를 세팅
		setTotalInfo($(".cart_info_td"));
		
	});
	
	/* 체크박스 전체 선택 */
	$(".all_check_input").on("click", function(){
		
		/* 체크박스 체크 / 해제 */
		/* if($(".all_check").prop("check")){	
				$(".individual_cart_checkbox").attr("checked", true);
		} else {
				$(".individual_cart_checkbox").attr("checked", false);			
		} */

		if($(".all_check").prop("checked")){	
				$(".individual_cart_checkbox").prop("checked", true);
		} else {
				$(".individual_cart_checkbox").prop("checked", false);			
		}
		
		// 변화함에 따라 다시 정보를 세팅
		setTotalInfo($(".cart_info_td"));
		
	});
	
	// 총 주문 정보 세팅
	function setTotalInfo(){
	
	let totalPrice = 0;				// 총 가격
	let totalCount = 0;				// 총 갯수
	let totalKind = 0;				// 총 종류
	let totalPoint = 0;				// 총 포인트
	let deliveryPrice = 0;			// 배송비
	let finalTotalPrice = 0; 		// 최종 가격(총 가격 + 배송비)
	
	// 가격의 정보들을 구하기 위해 순회하는 each() 사용
	$(".cart_info_td").each(function(index, element){	// element는 순회 대상의 객체
			
		if($(element).find(".individual_cart_checkbox").is(":checked") === true){ // 체크의 여부, is()는 특정요소가 선택요소와 관련값 또는 현재 상태 등을 확하는 Boolean메서드
																			      // 각 개별 체크란에 체크가 되었다면
		// 총 가격
		totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
		// 총 갯수
		totalCount += parseInt($(element).find(".individual_bookCount_input").val());
		// 총 종류
		totalKind += 1;
		// 총 포인트
		totalPoint += parseInt($(element).find(".individual_totalPoint_input").val());
	}
	
});
	
	/* 배송비 결정 */
	if(totalPrice >= 30000){	// 총 지불 값이 30000원 이상이면 
		deliveryPrice = 0;		// 배달비 0
	
	} else if(totalPrice == 0){	// 총 지불 값이 0원 이면
		deliveryPrice = 0;		// 배달비 0
	
	} else {					// 총 지불 값이 30000원 이하면
		deliveryPrice = 3000;	// 배달비 3000원
	
	}
	
	/* 최종 가격 */
	finalTotalPrice = totalPrice + deliveryPrice;	
	
	/* 값 삽입 */
	$(".totalPrice_span").text(totalPrice.toLocaleString());  // 총 가격	.text() 선택자 하위에 있는 자식들의 문자열만 출력
	$(".totalCount_span").text(totalCount);					  // 총 갯수
	$(".totalKind_span").text(totalKind);					  // 총 종류
	$(".totalPoint_span").text(totalPoint.toLocaleString());  // 총 포인트
	$(".delivery_price").text(deliveryPrice);				  // 배송비
	$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());	// 최종 가격(배송비 포함) 

	}
	
	/* 수량 변경 버튼 동작 구현 ( + , - 버튼 ) */
	$(".plus_btn").on("click", function(){
		
		let quantity = $(this).parent("div").find("input").val();	// ${ci.bookCount}
		$(this).parent("div").find("input").val(++quantity);		// 수량이 1 씩 증가
		
	});
	
	$(".minus_btn").on("click", function(){
		
		let quantity = $(this).parent("div").find("input").val();	
		
		if(quantity > 1){	// 수량이 1 보다 클 때 동작
			$(this).parent("div").find("input").val(--quantity);
		}
	});
	
	/* 수량 수정 버튼 */
	$(".quantity_modify_btn").on("click", function(){	/* 변경 버튼을 누르면 */
		
		let cartId = $(this).data("cartid");
		let bookCount = $(this).parent("td").find("input").val();
		
		/* modifyCart를 실행하기 위해 cartId 와 bookCount의 데이터가 필요 */
		$(".update_cartId").val(cartId);
		$(".update_bookCount").val(bookCount);
		$(".quantity_update_form").submit();
	});
	
	/* 삭제 버튼 */
	$(".delete_btn").on("click", function(e){
		
		/* 고유 동작을 중단 ex) a 태그 , submit 태그를 통해 페이지를 이동한다거나 form안에 있는 input 등을 전송 할 때 */
		e.preventDefault();	
		
		const cartId = $(this).data("cartid");
		
		$(".delete_cartId").val(cartId);		// cartId의 값을 form 태그에 있는 cartId에 저장
		$(".quantity_delete_form").submit();	// /cart/delete 매핑 메서드에 전송
	
		console.log("삭제 실행");
	});
	
	/* 주문 페이지 이동 */
	$(".order_btn").on("click", function(){
		
		let form_contents = '';		/* input태그 문자열 값이 저장될 변수 */
		let orderNumber = 0;		/* 배열의 index 역할 */
		
		/* 상품 데이터가 저장된 input태그들을 반복 접근하도록 메서드 작성 */
		$(".cart_info_td").each(function(index, element){
			
			/* 사용자가 체크한 물품에 대해서만 조건을 내야함 */
			if($(element).find(".individual_cart_checkbox").is(":checked") === true){	//체크여부
			
				let bookId = $(element).find(".individual_bookId_input").val();
				let bookCount = $(element).find(".individual_bookCount_input").val();
				
				let bookId_input = "<input name='orders[" + orderNumber + "].bookId' type='hidden' value='" + bookId + "'>";
				form_contents += bookId_input;
				
				let bookCount_input = "<input name='orders[" + orderNumber + "].bookCount' type='hidden' value='" + bookCount + "'>";
				form_contents += bookCount_input;
			
				orderNumber += 1;	// 다음 객체에 접근할 때 +1됨
			
			}
		});
		
		$(".order_form").html(form_contents);
		$(".order_form").submit();
		console.log("주문 실행");
	});
	

</script>

</body>
</html>