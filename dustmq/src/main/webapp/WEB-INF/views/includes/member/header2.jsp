<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="../resources/css/member/header.css">

<div class="wrapper">
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
						<a href="/member/logout.do">로그아웃</a>
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
				<a href="/main"><img src="resources/img/BookShop.png"></a>
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
                </div>
            </c:if>		
			
			</div>