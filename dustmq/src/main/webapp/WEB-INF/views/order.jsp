<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>          
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome BookMall</title>
<link rel="stylesheet" href="/resources/css/order.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
  
<!-- 다음 주소록 api -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>

<%@include file="includes/member/header2.jsp" %>

			<div class="clearfix"></div>			
		</div>
		<div class="content_area">
		
			<div class="content_subject"><span>주문</span></div>

			<div class="content_main">
				<!-- 회원 정보 -->
				<div class="member_info_div">
					<table class="table_text_align_center memberInfo_table">
						<tbody>
							<tr>
								<th style="width: 25%;">주문자</th>
								<td style="width: *">${memberInfo.memberName} | ${memberInfo.memberMail}</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<!-- 배송지 정보 -->
				<div class="addressInfo_div">
					<div class="addressInfo_button_div">
						<button class="address_btn address_btn_1" onclick="showAddress('1')" style="background-color: #3c3838;">상용자 정보 주소록</button>
						<button class="address_btn address_btn_2" onclick="showAddress('2')">직접 입력</button>
					</div>
					
					<!-- 배송 관련 버튼 클릭에 따라 보이거나 숨겨지는 태그 -->
					<div class="addressInfo_input_div_wrap">
						<div class="addressInfo_input_div addressInfo_input_div_1" style="display: block"> <!-- 선택자 우선순위로는 css파일 보다 태그에 설정한게 우선 -->
								
								<!-- 사용자 정보 주소 -->
								<table>
									<colgroup>
										<col width="25%">
										<col width="*">
									</colgroup>
									<tbody>
										<tr>
											<th>이름</th>
											<td>
												${memberInfo.memberName}
											</td>
										</tr>
										<tr>
											<th>주소</th>
											<td>
												${memberInfo.memberAddr1} ${memberInfo.memberAddr2}<br>${memberInfo.memberAddr3}										
												<input class="selectAddress" value="T" type="hidden">	<!-- 판단 근거가 T(기본 배송지) -->
												<input class="customer_input" value="${memberInfo.memberName}" type="hidden">
												<input class="address1_input" type="hidden" value="${memberInfo.memberAddr1}">
												<input class="address2_input" type="hidden" value="${memberInfo.memberAddr2}">
												<input class="address3_input" type="hidden" value="${memberInfo.memberAddr3}">
											</td>
										</tr>
									</tbody>
								</table>		
						</div>
						
						<!-- 사용자 주소 입력란 api 사용 -->
						<div class="addressInfo_input_div addressInfo_input_div_2">
								<table>
									<colgroup>
										<col width="25%">
										<col width="*">
									</colgroup>
									<tbody>
										<tr>
											<th>이름</th>
											<td>
												<input class="customer_input">
											</td>
										</tr>
										<tr>
											<th>주소</th>
											<td>
												<input class="selectAddress" value="F" type="hidden">	<!-- 판단 근거가 F(직접 입력 배송지) -->	
												<input class="address1_input" readonly="readonly"> <a class="address_search_btn" onclick="execution_daum_address()">주소 찾기</a><br>
												<input class="address2_input" readonly="readonly"><br>
												<input class="address3_input" readonly="readonly">
											</td>
										</tr>
									</tbody>
							</table>
						</div>
				</div>
			</div>
			
				<!-- 상품 정보 -->
				<div class="orderGoods_div">
					<!-- 상품 종류 -->
					<div class="goods_kind_div">
						주문상품 <span class="goods_kind_div_kind"></span>종 <span class="goods_kind_div_count"></span>개
					</div>
					<!-- 상품 테이블 -->
					<table class="goods_subject_table">
						<colgroup>
							<col width="15%">
							<col width="45%">
							<col width="40%">
						</colgroup>
						<tbody>
							<tr>
								<th>이미지</th>
								<th>상품 정보</th>
								<th>판매가</th>
							</tr>
						</tbody>
					</table>
					<table class="goods_table">
						<colgroup>
							<col width="15%">
							<col width="45%">
							<col width="40%">
						</colgroup>					
						<tbody>
							<c:forEach items="${orderList}" var="ol">
								<tr>
									<td>
										<!-- 이미지 -->
										<div class="image_wrap" data-bookid="${ol.imageList[0].bookId}" data-path="${ol.imageList[0].uploadPath}" data-uuid="${ol.imageList[0].uuid}" data-filename="${ol.imageList[0].fileName}">
											<img src="">
										</div>
										
									</td>
									<td>${ol.bookName}</td>
									<td class="goods_table_price_td">
										<fmt:formatNumber value="${ol.salePrice}" pattern="#,### 원" /> | 수량 ${ol.bookCount}개
										<br><fmt:formatNumber value="${ol.totalPrice}" pattern="#,### 원" />
										<br>[<fmt:formatNumber value="${ol.totalPoint}" pattern="#,### 원" />P]
										<input type="hidden" class="individual_bookPrice_input" value="${ol.bookPrice}">
										<input type="hidden" class="individual_salePrice_input" value="${ol.salePrice}">
										<input type="hidden" class="individual_bookCount_input" value="${ol.bookCount}">
										<input type="hidden" class="individual_totalPrice_input" value="${ol.salePrice * ol.bookCount}">
										<input type="hidden" class="individual_point_input" value="${ol.point}">
										<input type="hidden" class="individual_totalPoint_input" value="${ol.totalPoint}">
										<input type="hidden" class="individual_bookId_input" value="${ol.bookId}">
									</td>
								</tr>							
							</c:forEach>
			
						</tbody>
					</table>
				</div>
				
				<!-- 포인트 정보 -->
				<div class="point_div">
					<div class="point_div_subject">포인트 사용</div>
					<table class="point_table">
						<colgroup>
							<col width="25%">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>포인트 사용</th>
								<td>
									${memberInfo.point} | <input class="order_point_input" value="0">원 
									<a class="order_point_input_btn order_point_input_btn_Y" data-state="Y">모두사용</a>
									<a class="order_point_input_btn order_point_input_btn_N" data-state="N" style="display: none;">사용취소</a>
									
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<!-- 주문 종합 정보 -->
				<div class="total_info_div">
					<!-- 가격 종합 정보 -->
					<div class="total_info_price_div">
						<ul>
							<li>
								<span class="price_span_label">상품 금액</span>
								<span class="totalPrice_span">100000</span>원
							</li>
							<li>
								<span class="price_span_label">배송비</span>
								<span class="delivery_price_span">100000</span>원
							</li>
																					<li>
								<span class="price_span_label">할인금액</span>
								<span class="usePoint_span">100000</span>원
							</li>
							<li class="price_total_li">
								<strong class="price_span_label total_price_label">최종 결제 금액</strong>
								<strong class="strong_red">
									<span class="total_price_red finalTotalPrice_span">
										1500000
									</span>원
								</strong>
							</li>
							<li class="point_li">
								<span class="price_span_label">적립예정 포인트</span>
								<span class="totalPoint_span">7960원</span>
							</li>
						</ul>
					</div>
					
					<!-- 버튼 영역 -->
					<div class="total_info_btn_div">
						<a class="order_btn">결제하기</a>
					</div>
			</div>	<!-- total_info_div -->
			
		</div>	<!-- content_area -->
		
		<!-- 주문 요청 form -->
		<form class="order_form" action="/order" method="post">
			<!-- 주문자 회원번호 -->
			<input name="memberId" value="${memberInfo.memberId}" type="hidden">
			<!-- 배송지 -->
			<input name="customer" type="hidden">
			<input name="memberAddr1" type="hidden">
			<input name="memberAddr2" type="hidden">
			<input name="memberAddr3" type="hidden">
			<!-- 사용한 포인트 -->
			<input name="usePoint" type="hidden">
			<!-- 상품 정보 -->
		</form>
		
	</div>	<!-- class="content_area" -->
		
		 <%@include file="./includes/admin/footer.jsp" %>	<!-- footer --> 
		
	</div>	<!-- class="wrap" -->
</div>	<!-- class="wrapper" -->

		

<script>

/* '주문 페이지'에 이동했을 때 '주문 종합 정보'가 보여져야해 ready() 사용 */
$(document).ready(function(){
	
	/* 브랜드 로고 이미지 삽입 - 자꾸 text/html로 응답이 옴 */
	const lobj = $(".logo_area");
	lobj.find("img").attr('src', '/resources/img/BookShop.png');
	
	/* 주문 종합 정보 최신화 */
	setTotalInfo();
	
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
			$(this).find("img").attr('src', '/resources/img/no_Image.png');
		}

	});
	
});	// ready()

	/* 주소입력란 버튼 동작 (숨김, 표시) */
	function showAddress(className){
		
		/* 숨김 */
		$(".addressInfo_input_div").css('display', 'none');
		
		/* 표시 */
		$(".addressInfo_input_div_" + className).css('display', 'block');
	
		/* 색상 동일 */
		$(".address_btn").css('backgroundColor', '#555');
	
		/* 클릭한 버튼 색상 변경 */
		$(".address_btn_" + className).css('backgroundColor', '#3c3838');	
		
		/* 배송지 판단 근거 */
		
		/* 기본 배송지 */
		$(".addressInfo_input_div_" + className).find(".selectAddress").val("T");
		
		/* 직접 입력 배송지 */
		$(".addressInfo_input_div").each(function(i, obj){
					$(obj).find(".selectAddress").val("F");
		});
	}
	
	/* 다음 주소 api */
	/* 다음 주소 연동 */
function execution_daum_address(){
 		console.log("동작");
	   new daum.Postcode({
	        oncomplete: function(data) {

	        	var addr = ''; 		// 주소 변수
                var extraAddr = ''; // 참고항목 변수
 
                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                   		 addr = data.roadAddress;
                } else { 							 // 사용자가 지번 주소를 선택했을 경우(J)
                    	addr = data.jibunAddress;
                }
 
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
 
                	// 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                 	// 추가해야할 코드
                    // 주소변수 문자열과 참고항목 문자열 합치기
                      addr += extraAddr;
                
                } else {
                	addr += ' ';
                }
 
             	// 제거해야할 코드
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $(".address1_input").val(data.zonecode);
                $(".address2_input").val(addr);				
                // 커서를 상세주소 필드로 이동한다.
                $(".address3_input").attr("readonly", false);
                $(".address3_input").focus();	 

	        }
	    }).open();  	
}
	
	/* 포인트 입력 */
	$(".order_point_input").on("propertychange change keyup paste input", function(){

		// 회원이 소유하고 있는 포인트 값을 maxPoint에 대입
		// el방식으로 가져온 데이터는 문자열 이므로 parseInt를 사용해 숫자타입으로 변환
		const maxPoint = parseInt('${memberInfo.point}');	// 최대 포인트 (상수)
		
		// 사용자가 입력한 값
		let inputValue = parseInt($(this).val());
		
		if(inputValue < 0){					// 사용자 입력 포인트가 0보다 작으면
				$(this).val(0);				// 입력란에 0을 대입
		} else if (inputValue > maxPoint){	// 소유하고 있는 포인트보다 입력란에 높게 입력하면
				$(this).val(maxPoint);		// 가지고 있는 최대 포인트를 다 대입
		}
		
		/* 주문 종합 정보 최신화 */
		setTotalInfo();
		
});
	
	/* 포인트 버튼  Y : 전액 사용 상태 / N : 모두 취소 상태 */
	$(".order_point_input_btn").on("click", function(){
		
		const maxPoint = parseInt('${memberInfo.point}');
		
		let state = $(this).data("state");
		
		// state의 상태에 따라 조건이 나뉨
		if(state == 'Y'){
			console.log("모두 사용");
			
			/* 전액 사용 */
			//값 변경
			$(".order_point_input").val(maxPoint);
			//글 변경
			$(".order_point_input_btn_N").css("display", "inline-block");
			$(".order_point_input_btn_Y").css("display", "none");
		
		} else if(state == 'N'){
			console.log("모두 취소");

			/* 취소 */
			//값 변경
			$(".order_point_input").val(0);
			//글 변경
			$(".order_point_input_btn_N").css("display", "none");
			$(".order_point_input_btn_Y").css("display", "inline-block");		
		}
		
		/* 주문 조합 정보란 최신화 */
		setTotalInfo();
		
	});
	
	/* 총 주문 정보 세팅(배송비, 총 가격, 포인트, 물품 수량, 종류) */
	function setTotalInfo(){
		
		/* 가격 변수 선언 */
		let totalPrice = 0;			// 총 가격
		let totalCount = 0;			// 총 갯수
		let totalKind = 0;			// 총 종류
		let totalPoint = 0;			// 총 포인트
		let deliveryPrice = 0;		// 배송비
		let usePoint = 0;			// 사용 포인트(할인 가격)
		let finalTotalPrice = 0;	// 최종 가격(총 가격 + 배송비)
		
		/* 상품 가격에 해당하는 태그를 순회하며 값을 대입 */
		$(".goods_table_price_td").each(function(index, element){
			
			// 총 가격
			totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
			// 총 갯수
			totalCount += parseInt($(element).find(".individual_bookCount_input").val());
			// 총 종류
			totalKind += 1;
			// 총 포인트
			totalPoint += parseInt($(element).find(".individual_totalPoint_input").val());
			
		});
		
		/* 배송비 결정 */
		if(totalPrice >= 30000){		// 총 금액이 30000원을 이상이면
				deliveryPrice = 0;		// 배달비 0원
	
		} else if (totalPrice == 0){		// 총 금액이 0원이면
				deliveryPrice = 0;		// 배달비 0원
		
		} else {						// 그 외의 경우
				deliveryPrice = 3000;	// 배달비 3000원
		}
		
		finalTotalPrice = totalPrice + deliveryPrice;	
		
		/* 사용 포인트 */
		usePoint = $(".order_point_input").val();
		
		finalTotalPrice = finalTotalPrice - usePoint; 	
		
		/* 값 삽입 */
		$(".totalPrice_span").text(totalPrice.toLocaleString());			// 총 가격
		$(".goods_kind_div_count").text(totalCount);						// 총 갯수
		$(".goods_kind_div_kind").text(totalKind);							// 총 종류
		$(".totalPoint_span").text(totalPoint.toLocaleString());			// 총 포인트
		$(".delivery_price_span").text(deliveryPrice.toLocaleString());		// 배송비
		$(".usePoint_span").text(usePoint.toLocaleString());				// 할인가(사용 포인트)
		$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());	
	}
	
	/* 주문 요청 */
	$(".order_btn").on("click", function(){
		
		/* 배송지 */
		$(".addressInfo_input_div").each(function(i, obj){
			
			if($(obj).find(".selectAddress").val() === 'T'){	// 기본 배송지
					$("input[name='customer']").val($(obj).find(".customer_input").val());
					$("input[name='memberAddr1']").val($(obj).find(".address1_input").val());
					$("input[name='memberAddr2']").val($(obj).find(".address2_input").val());
					$("input[name='memberAddr3']").val($(obj).find(".address3_input").val());
			}
			
		});	//each()
		
		/* 사용 포인트 */
		$("input[name='usePoint']").val($(".order_point_input").val());
		
		/* 상품 정보 */
		let form_contents = '';
		$(".goods_table_price_td").each(function(index, element){
				
				/* input 태그를 동적으로 생성 */
				let bookId = $(element).find(".individual_bookId_input").val();
				let bookCount = $(element).find(".individual_bookCount_input").val();
				let bookId_input = "<input name='orders[" + index + "].bookId' type='hidden' value='" + bookId + "'>";
				
				form_contents += bookId_input;
				let bookCount_input = "<input name='orders[" + index + "].bookCount' type='hidden' value='" + bookCount + "'>";
				form_contents += bookCount_input;
		});	

		/* 주문 요청 form태그에 form_contents 추가 */
		$(".order_form").append(form_contents);	
			
		/* 서버에 전송 */
		$(".order_form").submit();
		
		
	});	// on()
	
	
</script>

</body>
</html>