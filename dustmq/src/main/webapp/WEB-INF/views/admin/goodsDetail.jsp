<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/goodsDetail.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/26.0.0/classic/ckeditor.js"></script>

<style type="text/css">
	
	/* 이미지 */
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;
	}

</style>
</head>
<body>

		<%@include file="../includes/admin/header.jsp" %>
                <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>상품 상세</span></div>

                    <div class="admin_content_main">

                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 제목</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="bookName" value="<c:out value="${goodsInfo.bookName}"/>" disabled>
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>등록 날짜</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input value="<fmt:formatDate value='${goodsInfo.regDate}' pattern='yyyy-MM-dd'/>" disabled>
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>최근 수정 날짜</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input value="<fmt:formatDate value='${goodsInfo.updateDate}' pattern='yyyy-MM-dd'/>" disabled>
                    			</div>
                    		</div>                    		                    		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>작가</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input id="authorName_input" readonly="readonly" value="${goodsInfo.authorName }" disabled>
                    				                    				
                    			</div>
                    		</div>            
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>출판일</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="publeYear" autocomplete="off" readonly="readonly" value="<c:out value="${goodsInfo.publeYear}"/>" disabled>                    				
                    			</div>
                    		</div>            
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>출판사</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="publisher" value="<c:out value="${goodsInfo.publisher}"/>" disabled>
                    			</div>
                    		</div>             
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 카테고리</label>
                    			</div>
                    			<div class="form_section_content">
                    				<div class="cate_wrap">
                    					<span>대분류</span>
                    					<select class="cate1" disabled>
                    						<option  value="none">선택</option>
                    					</select>
                    				</div>
                    				<div class="cate_wrap">
                    					<span>중분류</span>
                    					<select class="cate2" disabled>
                    						<option  value="none">선택</option>
                    					</select>
                    				</div>
                    				<div class="cate_wrap">
                    					<span>소분류</span>
                    					<select class="cate3" name="cateCode" disabled>
                    						<option value="none">선택</option>
                    					</select>
                    				</div>                  				                    				
                    			</div>
                    		</div>          
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 가격</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="bookPrice" value="<c:out value="${goodsInfo.bookPrice}"/>" disabled>
                    			</div>
                    		</div>               
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 재고</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="bookStock" value="<c:out value="${goodsInfo.bookStock}"/>" disabled>
                    			</div>
                    		</div>          
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 할인율</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input id="discount_interface" maxlength="2" disabled>
                    			</div>
                    		</div>          		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 소개</label>
                    			</div>
                    			<div class="form_section_content bit">
                    				<textarea name="bookIntro" id="bookIntro_textarea" disabled>${goodsInfo.bookIntro}</textarea>
                    			</div>
                    		</div>        		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 목차</label>
                    			</div>
                    			<div class="form_section_content bct">
                    				<textarea name="bookContents" id="bookContents_textarea" disabled>${goodsInfo.bookContents}</textarea>
                    			</div>
                    		</div>
                   		
                   		<div class="form_section">
                   			<div class="form_section_title">
								<label>상품 이미지</label>                   			
                   			</div>
                   			<div class="form_section_content">
                   				
                 				<div id="uploadResult">
                 					
                				</div>
                   			</div>
                   		</div>
                   		
                   			 <div class="btn_section">
		             			<button id="cancelBtn" class="btn">상품 목록</button>
		                    	<button id="modifyBtn" class="btn enroll_btn">수정 </button>
                			</div> 
                    </div>      

	                	  <!-- 페이지 이동 폼 -->
	                <form id="moveForm" action="/admin/goodsManage" method="get" >
	 						<input type="hidden" name="pageNum" value="${cri.pageNum}">
							<input type="hidden" name="amount" value="${cri.amount}">
							<input type="hidden" name="keyword" value="${cri.keyword}">
	              	</form>
               
                </div>
		<%@include file="../includes/admin/footer.jsp" %>

<script>

	$(document).ready(function(){
		
		/* 할인율 값 삽입 */
		let bookDiscount = '<c:out value="${goodsInfo.bookDiscount}"/>' * 100;
		/* 새로 생성 초기화한 변수를 활용하여 '할인율' <input> 태그란에 삽입해주는 코드  */
		$("#discount_interface").attr("value", bookDiscount);
		
		/* 출판일 값 가공 */
		let publeYear = '${goodsInfo.publeYear}';	// yyyy-mm-dd 00:00:00
		let length = publeYear.indexOf(" ");		// 빈칸이 존재하는 인덱스 값
		
		publeYear = publeYear.substring(0, length);	// yyyy-mm-dd
		
		$("input[name='publeYear']").attr("value", publeYear);
		
		/* 위지윅 이용 */
		/* 책 소개 */
			ClassicEditor
				.create(document.querySelector('#bookIntro_textarea'))
				.then(editor => {
					console.log(editor);
					editor.isReadOnly = true;
				})
				.catch(error=>{
					console.error(error);
				});
				
			/* 책 목차 */	
			ClassicEditor
			.create(document.querySelector('#bookContents_textarea'))
			.then(editor => {
				console.log(editor);
				editor.isReadOnly = true;
			})
			.catch(error=>{
				console.error(error);
			});
	
			/* 카테고리, 서버로부터 전달받은 리스트 객체를 JSON으로 변경하기 위한 코드 */
			let cateList = JSON.parse('${cateList}');

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
			function makeCateArray(obj,array,cateList, tier){
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
			makeCateArray(cate1Obj,cate1Array,cateList,1);
			makeCateArray(cate2Obj,cate2Array,cateList,2);
			makeCateArray(cate3Obj,cate3Array,cateList,3);
			
			let targetCate2 = '';
			let targetCate3 = '${goodsInfo.cateCode}';
			
			for(let i = 0; i < cate3Array.length; i++){
				if(targetCate3 === cate3Array[i].cateCode){
					targetCate3 = cate3Array[i];
				}
			}// for		
			
			/* cate3Array 에 담긴 소분류 데이터를 모두 비교하여
			   targetCate3 의 cateParent와 동일한 값을 가지는 데이터들 소분류 select 항목에 추가 */
			for(let i = 0; i < cate3Array.length; i++){
				if(targetCate3.cateParent === cate3Array[i].cateParent){
					cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");
				}
			}
			
			/* DB에 저장된 값에 해당하는 카테고리 option 태그에 selected 속성이 추가되도록 코드 작성 */
			$(".cate3 option").each(function(i,obj){
				if(targetCate3.cateCode === obj.value){
					$(obj).attr("selected", "selected");
				}
			});	
			
			/* 중분류 */
			for(let i = 0; i < cate2Array.length; i++){
				if(targetCate3.cateParent === cate2Array[i].cateCode){
					targetCate2 = cate2Array[i];	
				}
			}// for	
			
			for(let i = 0; i < cate2Array.length; i++){
				if(targetCate2.cateParent === cate2Array[i].cateParent){
					cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");
				}
			}		
			
			/* 중분류의 select 태그에 option 데이터들을 추가해준 후 선택되어야 할 option태그에 selected속성 부여 */
			$(".cate2 option").each(function(i,obj){
				if(targetCate2.cateCode === obj.value){
					$(obj).attr("selected", "selected");
				}
			});	
			
			/* 대분류, 대분류의 모든 항목들을 option태그로 추가해주고, selected되어야할 값은 
			   targetCate2.cateParent을 사용 */
			for(let i = 0; i < cate1Array.length; i++){
				cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");
			}
			
			/* targetCate2.cateParent 값을 활용하여 대분류 중 선택되어야할 option태그에 selected 속성을 추가 */
			$(".cate1 option").each(function(i,obj){
				if(targetCate2.cateParent === obj.value){
					$(obj).attr("selected", "selected");
				}
			});	
			
			/* 이미지 정보 호출 */
			let bookId = '<c:out value="${goodsInfo.bookId}"/>';	
			let uploadResult = $("#uploadResult");
			
			// getJSON 첫 번째 인자는 서버에 요청할 GET방식의 url, 두 번째 인자는 서버에 요청할 때 전달할 데이터,
			// 세 번째 인자는 성공적으로 서버로부터 데이터를 전달 받았을 때 실행할 콜백함수 작성
			$.getJSON("/getAttachList", {bookId : bookId}, function(arr){
				
				// 이미지가 없는경우 콜백 함수를 빠져나감
				if(arr.length === 0) {
					
					let str = "";
					str += "<div id='result_card'>";
					str += "<img src='/resources/img/no_Image.png'>";
					str += "</div>";
					
					uploadResult.html(str);
					
					return;
				} 
				
				
				// uploadResult 태그 내부에 삽입될 태그 코드를 값으로 가질 변수
				let str = "";
				
				// 서버로부터 저달받은 이미지 정보 객체를 값으로 가짐, 원래는 여러 이미지를 반환하게 코드를 작성해 뷰에서는
				// 이미지 정보를 배열 형태로 전달받고, 현재 우리의 이미지는 하나만 출력해서 첫 번째 요소를 변수로 지정 
				let obj = arr[0];	
				
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				
				str += "<div id='result_card'";
				str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
				str += ">";
				str += "<img src='/display?fileName=" + fileCallPath +"'>";
				str += "</div>";	
				
				uploadResult.html(str);	// 자식태그를 통째로 일거올 떄 사용, 태그 동적추가할 때 주로 사용
				
			}); // $.getJSON
	
	});	// $(document).ready
	
	/* 목록 이동 버튼 */
	$("#cancelBtn").on("click", function(e){
		e.preventDefault();
		$("#moveForm").submit();	
	});	
	
	/* 수정 페이지 이동 */
	$("#modifyBtn").on("click", function(e){
		e.preventDefault();
		let addInput = '<input type="hidden" name="bookId" value="${goodsInfo.bookId}">';
		$("#moveForm").append(addInput);
		$("#moveForm").attr("action", "/admin/goodsModify");
		$("#moveForm").submit();
	});	
	
	

</script>

</body>
</html>