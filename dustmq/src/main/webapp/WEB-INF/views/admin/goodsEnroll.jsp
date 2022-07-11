<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/goodsEnroll.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" /> <!-- 달력 -->
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.1.0/classic/ckeditor.js"></script>	<!-- 위지윅 -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>		<!-- 달력 -->
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<style type="text/css">

	/* 상품 이미지 관련 */
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
	
	#result_card {
		position: relative;		/* relative는 요소를 원래 위치에서 벗어나게 배치 가능 */
	}
	
	.imgDeleteBtn {
		position: absolute;		/* absolute의 배치 기준을 자신이 아닌 상위 요소를 기준으로 배치 가능 */
		top: 0;
		right: 5%
	    background-color: #ef7d7d;
	    color: red;
	    font-weight: 900;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    line-height: 26px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;	
	}
	
</style>

</head>
<body>
 
		 <%@include file="../includes/admin/header.jsp" %>	
		 
                <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>상품 등록</span></div>
                       <div class="admin_content_main">
                    	
                    	<!-- 상품 등록에 필요한 데이터 form -->
                    	<form action="/admin/goodsEnroll" method="post" id="enrollForm">
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 제목</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="bookName">
                    				<span class="ck_warn bookName_warn">책 이름을 입력해주세요.</span>
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>작가</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input id="authorName_input" readonly="readonly">			<!-- 사용자에게 보일 부분 -->
		 							<input id="authorId_input" name="authorId" type="hidden">	<!-- 상품 등록에 필요로 한 authorId 데이터를 저장 -->
									<button class="authorId_btn">작가 선택</button>
                    				<span class="ck_warn authorId_warn">작가를 선택해주세요</span>
                    			</div>
                    		</div>            
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>출판일</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="publeYear" autocomplete="off" readonly="readonly">
                    				<span class="ck_warn publeYear_warn">출판일을 선택해주세요.</span>
                    			</div>
                    		</div>            
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>출판사</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="publisher">
                    				<span class="ck_warn publisher_warn">출판사를 입력해주세요.</span>
                    			</div>
                    		</div>             
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 카테고리</label>
                    			</div>
                    			<div class="form_section_content">
                    				<div class="cate_wrap">
										<span>대분류</span>
										<select class="cate1">
											<option selected value="none">선택</option>
										</select>
									</div>
									<div class="cate_wrap">
										<span>중분류</span>
										<select class="cate2">
											<option selected value="none">선택</option>
										</select>
									</div>
									<div class="cate_wrap">
										<span>소분류</span>
										<select class="cate3" name="cateCode">
											<option selected value="none">선택</option>
										</select>
									</div> 
									<span class="ck_warn cateCode_warn">카테고리를 선택해주세요.</span>
                    			</div>
                    		</div>          
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 가격</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="bookPrice" value="0">
                    				<span class="ck_warn bookPrice_warn">상품 가격을 입력해주세요.</span>
                    			</div>
                    		</div>               
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 재고</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="bookStock" value="0">
                    				<span class="ck_warn bookStock_warn">상품 재고를 입력해주세요.</span>
                    			</div>
                    		</div>          
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 할인율</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input id="discount_interface" maxlength="2" value="0">	<!-- 사용자가 입력할 값 1~99 -->
                    				<input name="bookDiscount" type="hidden" value="0">		<!-- 기존 서버에 전송될 할인율 값을 저장 -->
                    				<span class="step_val">할인 가격 : <span class="span_discount"></span></span>
                    				<span class="ck_warn bookDiscount_warn">1~99 숫자를 입력해주세요.</span>
                    			</div>
                    		</div>          		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 소개</label>
                    			</div>
                    			<div class="form_section_content bit">
                    				<textarea name="bookIntro" id="bookIntro_textarea"></textarea>	<!-- 위지윅 적용 태그 -->
                    				<span class="ck_warn bookIntro_warn">책 소개를 입력해주세요.</span>
                    			</div>
                    		</div>        		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 목차</label>
                    			</div>
                    			<div class="form_section_content bct">
                    				<textarea name="bookContents" id="bookContents_textarea"></textarea>  <!-- 위지윅 적용 태그-->
                    				<span class="ck_warn bookContents_warn">책 목차를 입력해주세요.</span>
                    			</div>
                    		</div>
                    		<!-- 파일 업로드 UI -->
							<div class="form_section">
								<div class="form_section_title">
									<label>상품 이미지</label>
								</div>
								<div class="form_section_content">
									<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;">	<!-- 파일 여러개 선택하고 싶으면 multiple속성 추가 -->
										<div id="uploadResult">
											<!-- <div id="result_card">
												<div class="imgDeleteBtn">x</div>
												<img src="/display?fileName=P1235.png">
											</div> -->
										</div>
								</div>
							</div>                    		
                   		</form>
                   			<!-- 버튼 -->
                   			<div class="btn_section">
                   				<button id="cancelBtn" class="btn">취 소</button>
	                    		<button id="enrollBtn" class="btn enroll_btn">등 록</button>
	                    	</div> 
                    </div>  
                </div>
           	
      	 <%@include file="../includes/admin/footer.jsp" %>
      	 
<script>

	let enrollForm = $("#enrollForm");

	/* 취소 버튼 */
	$("#cancelBtn").click(function(){
	
	location.href="/admin/goodsManage"
	
	});
	
	/* 상품 등록 버튼 */
	$("#enrollBtn").on("click", function(e){
		
		e.preventDefault();
		
		/* 상품 등록 체크 변수 */
		let bookNameCk = false;		
		let authorIdCk = false;		
		let publeYearCk = false;	
		let publisherCk = false;	
		let cateCodeCk = false;		
		let priceCk = false;
		let stockCk = false;
		let discountCk = false;
		let introCk = false;
		let contentsCk = false;
		
		/* 체크 대상 변수 */
		let bookName = $("input[name='bookName']").val();
		let authorId = $("input[name='authorId']").val();
		let publeYear = $("input[name='publeYear']").val();
		let publisher = $("input[name='publisher']").val();
		let cateCode = $("select[name='cateCode']").val();
		let bookPrice = $("input[name='bookPrice']").val();
		let bookStock = $("input[name='bookStock']").val();
		let bookDiscount = $("#discount_interface").val();
		let bookIntro = $(".bit p").html();	// p태그는 CKEditor5 를 이용해 적으면 자동으로 p태그가 붙는데 그 p를 의미
		let bookContents = $(".bct p").html();
		
		/* 유효성 검사(공란 체크) */
		if(bookName){
			$(".bookName_warn").css('display', 'none');
			bookName = true;
		} else {
			$(".bookName_warn").css('display', 'block');
			bookName = false;
		}
		
		if(authorId){
			$(".authorId_warn").css('display','none');
			authorIdCk = true;
		} else {
			$(".authorId_warn").css('display','block');
			authorIdCk = false;
		}
		
		if(publeYear){
			$(".publeYear_warn").css('display','none');
			publeYearCk = true;
		} else {
			$(".publeYear_warn").css('display','block');
			publeYearCk = false;
		}	
		
		if(publisher){
			$(".publisher_warn").css('display','none');
			publisherCk = true;
		} else {
			$(".publisher_warn").css('display','block');
			publisherCk = false;
		}
		
		if(cateCode != 'none'){
			$(".cateCode_warn").css('display','none');
			cateCodeCk = true;
		} else {
			$(".cateCode_warn").css('display','block');
			cateCodeCk = false;
		}	
		
		if(bookPrice != 0){
			$(".bookPrice_warn").css('display','none');
			priceCk = true;
		} else {
			$(".bookPrice_warn").css('display','block');
			priceCk = false;
		}	
		
		if(bookStock != 0){
			$(".bookStock_warn").css('display','none');
			stockCk = true;
		} else {
			$(".bookStock_warn").css('display','block');
			stockCk = false;
		}		
		
		/* 입력값이 숫자면 true */
		 if(!isNaN(bookDiscount)){
			$(".bookDiscount_warn").css('display', 'none');
			discountCk = true;
		} else {
			$(".bookDiscount_warn").css('display', 'block');
			discountCk = false;
		} 
		
		if(bookIntro != '<br data-cke-filler="true">'){
			$(".bookIntro_warn").css('display','none');
			introCk = true;
		} else {
			$(".bookIntro_warn").css('display','block');
			introCk = false;
		}		
															// <br data-cke-filler="true">는 CKEditor 5의 필러
		if(bookContents != '<br data-cke-filler="true">'){	// 편집 보기에서 사용되는 블록 필러의 경우
			$(".bookContents_warn").css('display','none');
			contentsCk = true;
		} else {
			$(".bookContents_warn").css('display','block');
			contentsCk = false;
		}		
		
		/* 최종 체크 */
		/* if(bookNameCk && authorIdCk && publeYearCk && publisherCk && cateCodeCk
		   && priceCk && stockCk && discountCk && introCk && contentsCk ){

				console.log("성공");
				enrollForm.submit();	// 모두 true면 전송
		} else {
				return false;			// 한 항목이라도 false면 '상품 등록' 메서드가 종료
		} */
		
		enrollForm.submit();
		
	});
	
	/* 위지윅 적용 */
	/* 책 소개 */
	ClassicEditor
		.create(document.querySelector('#bookIntro_textarea'))
		.catch(error=>{
			console.error(error);
		});
		
	/* 책 목차 */	
	ClassicEditor
	.create(document.querySelector('#bookContents_textarea'))
	.catch(error=>{
		console.error(error);
	});
	
	/* 캘린더 */
	/* 설정 */
	const config = {
		dateFormat: 'yy-mm-dd',
		showOn : "button",			// input 태그 옆에 버튼 추가 (input을 버튼화 한거같음)
		buttonText:"날짜 선택",
	    prevText: '이전 달',
	    nextText: '다음 달',
	    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNames: ['일','월','화','수','목','금','토'],
	    dayNamesShort: ['일','월','화','수','목','금','토'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
	    yearSuffix: '년',
        changeMonth: true,
        changeYear: true
	}

	/* 캘린더 적용 */
	$(function() {
		 $( "input[name='publeYear']" ).datepicker(config);	// yyyy-mm-dd 형식 date타입
	});
	
	/* 작가 선택 버튼 */
	$('.authorId_btn').on("click", function(e){
		
		// 버튼을 클릭 시 동작하는 메서드 추가와 해당 구현부에 버튼의 동작을 멈추는 코드를 추가.
		// form태그 안에 추가되어있기 때문에 기능을 막지 않으면 <form>이 전송
		e.preventDefault();
		
		let popUrl = "/admin/authorPop";
		let popOption = "width = 650px, height=550px, top=300px, left=300px, scrollbars=yes";
		
		// 팝업창을 뜨게하는 코드 window.open();
		window.open(popUrl,"작가 찾기",popOption);	
		
	});
	
	/* 카테고리 */
	let cateList = JSON.parse('${cateList}');	// cateList 속성에 담긴 JSON데이터를 js객체로 변환
	
	// 각 등급에 사용될 배열, 객체
	let cate1Array = new Array();
	let cate2Array = new Array();
	let cate3Array = new Array();
	
	let cate1Obj = new Object();
	let cate2Obj = new Object();
	let cate3Obj = new Object();
	
	let cateSelect1 = $(".cate1");		
	let cateSelect2 = $(".cate2");
	let cateSelect3 = $(".cate3");
	
	/* 카테고리 배열 초기화 메서드 */
	function makeCateArray(obj, array, cateList, tier){
		for(let i = 0; i < cateList.length; i++){
			if(cateList[i].tier === tier){
				obj = new Object();
				
				obj.cateName = cateList[i].cateName;
				obj.cateCode = cateList[i].cateCode;
				obj.cateParent = cateList[i].cateParent;
				
				array.push(obj);				
				
			}
		}
	}	
	
	/* 배열 초기화 */
	makeCateArray(cate1Obj,cate1Array,cateList,1);	// 1 티어
	makeCateArray(cate2Obj,cate2Array,cateList,2);	// 2 티어	
	makeCateArray(cate3Obj,cate3Array,cateList,3);	// 3 티어
	
	// <select> 태그 내부에 <option> 태그를 추가
	/* 대분류 <option> 태그 */
	for(let i = 0; i < cate1Array.length; i++){
		cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");
	}
	
	/* 중분류 <option> 태그 */
	$(cateSelect1).on("change",function(){
		
		// 대분류에서 선택된 값을 가져옴
		let selectVal1 = $(this).find("option:selected").val();
		
		// 중분류 <option>태그를 지우고 기본적인 <option> 태그를 추가 -> 다른 대분류 선택 시 기존 option 태그들 사라짐
		cateSelect2.children().remove();	// 삭제
		cateSelect3.children().remove();
		
		cateSelect2.append("<option value='none'>선택</option>");	// 추가
		cateSelect3.append("<option value='none'>선택</option>");
		
		// 대분류 선택 값과 일치하는 cateParent 값을 가진 중분류 <option> 태그를 출력
		for(let i = 0; i < cate2Array.length; i++){
			if(selectVal1 === cate2Array[i].cateParent){	// DB에서 서로 pk fk 부분
				cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");	
			}
		}	// for
	});
	
	/* 소분류 <option>태그 */
	$(cateSelect2).on("change",function(){
		
		let selectVal2 = $(this).find("option:selected").val();
		
		cateSelect3.children().remove();
		
		cateSelect3.append("<option value='none'>선택</option>");		
		
		for(let i = 0; i < cate3Array.length; i++){
			if(selectVal2 === cate3Array[i].cateParent){
				cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");	
			}
		}	// for	
	});	
	
	/* 할인율 Input 설정 : 사용자가 입력 할 수 있는 input에 값이 입력되었을 때 바로 숨겨진 할인율input태그에 소수값이 입력 */
	$("#discount_interface").on("propertychange change keyup paste input", function(){
		
		let userInput = $("#discount_interface");				// 사용자 입력
		let discountInput = $("input[name='bookDiscount']");	// 할인율 전달
		
		let discountRate = userInput.val();					     // 사용자가 입력할 할인값
        let sendDiscountRate = discountRate / 100;			     // 서버에 전송할 할인값

        let goodsPrice = $("input[name='bookPrice']").val();	 // 책 원가
		let discountPrice = goodsPrice * (1 - sendDiscountRate); // 할인된 가격 , 상품 가격 * (1 - (할인율/100))
        
		
		  if(!isNaN(discountRate)){ 
	       	$(".span_discount").html(discountPrice);	// discountPrice의 값을 class가 .span_discount인 태그에 새롭게 넣는다.
			discountInput.val(sendDiscountRate);	
	      }   
	});	
	
	/* 상품 가격을 수정하더라도 잘 적용되게 추가 */
	$("input[name='bookPrice']").on("change", function(){
		
		let userInput = $("#discount_interface");
		let discountInput = $("input[name='bookDiscount']");
		
		let discountRate = userInput.val();					// 사용자가 입력한 할인값
		let sendDiscountRate = discountRate / 100;			// 서버에 전송할 할인값
		let goodsPrice = $("input[name='bookPrice']").val();			// 원가
		let discountPrice = goodsPrice * (1 - sendDiscountRate);		// 할인가격
		
		if(!isNaN(discountRate)){
			$(".span_discount").html(discountPrice);
		
		 } 
	});
	
	/* 이미지 업로드 */
	$("input[type='file']").on("change", function(e){	// input 태그를 통해 선택된 File 객체는 FileList 객체 요소로 저장, 저장된 File은 type이'file'인 input태그의 files 속성
		
		/* 이미지 존재시 삭제 후 업로드 */
		if($(".imgDeleteBtn").length > 0){	// 미리보기 태그가 존재하는지 하지않는지를 통해 판단 (x표시)
			deleteFile();
		}
		
		let formData = new FormData();	// FormData 객체를 인스턴스화. 주소를 formData에 저장
		let fileInput = $('input[name="uploadFile"]');
		let fileList = fileInput[0].files;	// FileList 객체에 접근을 하는 코드
		let fileObj = fileList[0];			// FileList 안에 File 객체에 접근을 하는 코드
		
		/* view에서 이미지 파일을 체크 */
		if(!fileCheck(fileObj.name, fileObj.size)){	
			return false;
		} 
		
		formData.append("uploadFile", fileObj);	// 사용자가 선택한 파일을 FormData에 uploadFile이란 이름(key)로 추가해주는 코드 ( 파일의 정보를 저장 )
		
		$.ajax({								// 준비된 첨부파일 데이터를 서버에 ajax 방식으로 전달
			url : '/admin/uploadAjaxAction',
			processData : false,				// 일반적으로 서버에 전달되는 데이터는 query string형태, 파일 전송의 경우 이를 하지 않아야해서 false로
			contentType : false,				// 기본값이 "application/x-www-form-urlencoded; charset=UTF-8" 인데, "multipart/form-data" 로 전송이 되게 false로
			data : formData,					// 서버로 전송할 데이터	
			type : 'POST',						
			dataType : 'json',					// 서버가 응답할 때 보내줄 데이터 타입, json타입으로 전달해야 뷰에서 AttachImageVO 객체의 데이터를 활용 가능 
			success : function(result) {		// 결과 성공 콜백 함수
					console.log(result);
					showUploadImage(result);	// 이미지를 보여주는 함수
			},
			error : function(result) {			// 파일 체크에서 실패하면 실행되는 콜백 함수
					alert("이미지 파일이 아닙니다.");	
			}
		}); // ajax
	});
	
	/* var, method related with attachFile */
	let regex = new RegExp("(.*?)\.(jpg|png)$");	/* jpg, png 파일만 허용 */
	let maxSize = 1048576; 							/* 허용하는 파일의 크기 1MB */				
	
	function fileCheck(fileName, fileSize){

		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
			  
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		
		return true;		
		
	}
	
	/* 받아온 데이터를 가지고 해당 이미지를 출력하는 메서드 */
	function showUploadImage(uploadResultArr) {
		
		/* 전달받은 데이터 검증 (데이터를 정상적으로 전달 받았다면) */
		if(!uploadResultArr || uploadResultArr.length == 0 ) {return}	
		
		let uploadResult = $("#uploadResult");
		
		// 서버로부터 전달받은 배열 데잍의 첫 번째 요소로 초기화
		let obj = uploadResultArr[0];	
		
		let str = "";
		
		// url 매핑 메서드("/display")에 전달해줄 파일의 경로와 이름을 포함하는 값을 저장하기 위한 변수
		/* let fileCallPath = obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName; 구분자가 \ 라서 에러 */ 
/* 		let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName); */
		let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName); 
		
		// str을 이용해서 이미지를 받아오면 아래 태그들을 추가
		str += "<div id='result_card'>";
		str += "<img src='/display?fileName=" + fileCallPath +"'>";
		str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";			// data-file속성의 속성 값은 출력되는 파일의 경로, 디코딩해주었던 이유
		str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";	// BookVO 의 List<AttachImageVO> imageList
		str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
		str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";		
		str += "</div>";
		
		uploadResult.append(str);	// id가 uploadResult인 태그에 append() 명령으로 태그들을 추가
		
		/* 이미지 삭제 버튼 동작 */
		$("#uploadResult").on("click", ".imgDeleteBtn", function(e){	// uploadResult태그 아래 imgDeleteBtn을 누르면 함수 발생
			
			deleteFile();	// 삭제 함수 호출
			
		});
		
		/* 파일 삭제 메서드 */
		function deleteFile() {
			
			let targetFile = $(".imgDeleteBtn").data("file");
			
			let targetDiv = $("#result_card");
			
			$.ajax({
					url : '/admin/deleteFile',
					data : {fileName : targetFile},
					dataType : 'text',							// 전송하는 targetFile은 문자 데이터이기 때문
					type : 'POST',
					success : function(result){
							console.log(result);
							
							targetDiv.remove();					// 미리보기 영역 삭제
							$("input[type='file']").val("");	// input태그 초기화
					},
					error : function(result){
							console.log(result);
					
							alert("파일을 삭제하지 못하였습니다.");
					}
				
			});	// ajax
		}
		
	}
	
</script>
 
</body>
</html>
