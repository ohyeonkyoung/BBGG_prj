<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- Header Area wrapper Starts -->
    <script>
	$(document).ready(function() {
	    $('.nav-item').click(function() {
	        $('.nav-item').removeClass('active');
	        $(this).addClass('active');
	    });
	});
	</script>
	
	<!-- Main Style -->
	<link rel="stylesheet" type="text/css" href="/resources/assets/css/colors/black.css">
	
    <header id="header-wrap">
      <!-- Start Top Bar -->
      <div class="top-bar">
        <div class="container">
          <div class="row">
            <div class="col-lg-7 col-md-8 col-xs-12">
              <!-- Start Contact Info -->
              <ul class="links clearfix">
                <li> BBGG-A.site </li>
                <!-- <li><a href="#"><i class="lni-map-marker"></i> York Blvd, Los Angeles, US</a></li> -->
              </ul>
              <!-- End Contact Info -->
            </div>
            <div class="col-lg-5 col-md-4 col-xs-12">
              <div class="roof-social float-right">
               	<div>
               		
               	</div>
              </div>
              <c:if test="${loginVO == null}">
	              <div class="header-top-right float-right">
	                <a href="/login" class="header-top-button"><i class="lni-lock"></i> 로그인</a>
	              </div>
              </c:if>
              <c:if test="${loginVO != null}">
	              <div class="header-top-right float-right">
	              	<a href="#" class="header-top-button"><i class="lni-user"></i><strong>${loginVO.userName}</strong>님</a> |
	                <a href="/actionLogout" class="header-top-button"><i class="lni-lock"></i> 로그아웃</a>
	              </div>
              </c:if>
            </div>
          </div>
        </div>
      </div>
      <!-- End Top Bar -->

      <!-- Navbar Start -->
      <nav class="navbar navbar-expand-lg navbar-light bg-white"  data-toggle="sticky-onscroll">
        <div class="container">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#main-navbar" aria-controls="main-navbar" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
              <span class="lin-menu"></span>
            </button>
            <a class="navbar-brand" href="/admin"><img src="/resources/comm/logo(B)s.png" alt="logo_admin"></a>
          </div>

          <div class="collapse navbar-collapse" id="main-navbar">
            <ul class="navbar-nav mr-auto w-100 justify-content-center">
              <li class="nav-item mx-3 active">
                <a class="nav-link m1-3" href="/admin" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  홈
                </a>
                
              </li>
              <li class="nav-item dropdown mx-3">
                <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  매물 관리 
                </a>
                 <div class="dropdown-menu">
                  <a class="dropdown-item" href="/fake/list">신고 매물</a>
                  <a class="dropdown-item" href="/admin/itemList">매물 조회</a>
                  <a class="dropdown-item" href="#">단기 임대</a>
                </div>
              </li>
              <li class="nav-item dropdown mx-3">
                <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  회원 관리 
                </a>
                 <div class="dropdown-menu">
                  <a class="dropdown-item" href="/admin/userList">개인 회원</a>
                  <a class="dropdown-item" href="/admin/partnerList">중개사 회원</a>
                </div>
              </li>
              <li class="nav-item dropdown mx-3">
                <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  게시판 관리 
                </a>
                <div class="dropdown-menu">
                  <a class="dropdown-item" href="/notice">공지사항</a>
                  <a class="dropdown-item" href="#">부동산 가이드</a>
                  <a class="dropdown-item" href="#">Q & A</a>
                </div>
              </li>
              <c:if test="${loginVO != null}">
              <li class="nav-item dropdown mx-3">
                <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  마이페이지 <i class="fa fa-angle-down"></i>
                </a>
                <div class="dropdown-menu">
                  <a class="dropdown-item" href="portfolio-2.html">내 정보 수정</a>
                  <a class="dropdown-item" href="/note/sendList/${loginVO.userNo}">보낸 쪽지함</a>
                </div>
              </li>
              </c:if>   
            </ul>
            <!-- <div class="search-add float-right">
              <form method="post">
                <div class="form-group">
                    <input type="search" name="field-name" value="" placeholder="검색어를 입력하세요" required="">
                    <button type="submit" class="search-btn"><span class="lni-search"></span></button>
                </div>
              </form>
            </div> -->
            <div>
              
            </div>
          </div>
        </div>

        <!-- Mobile Menu Start -->
        <ul class="mobile-menu">
          <li>
            <a class="active" href="/admin">
            홈
            </a>
            <ul class="dropdown">
              <li>
                <a href="/admin">
                  관리자 홈
                </a>
              </li>  
              <li>
                <a class="active" href="/">
                  회원 홈
                </a>
              </li>   
            </ul>
          </li>
          <li>
            <a href="#">매물 관리</a>
            <ul class="dropdown">
              <li><a href="/fake/list">신고 매물</a></li>
              <li><a href="/admin/itemList">매물 조회</a></li>
              <li><a href="#">단기 임대</a></li>
            </ul>
          </li>
          <li>
            <a href="#">회원 관리</a>
            <ul class="dropdown">
              <li><a href="/admin/userList">개인 회원</a></li>
              <li><a href="/admin/partnerList">단체 회원</a></li>
            </ul>
          </li>
          <li>
            <a href="#">게시판 관리</a>
            <ul class="dropdown">
              <li><a href="/notice">공지사항</a></li>
              <li><a href="#">부동산 가이드</a></li>
              <li><a href="#">Q & A</a></li>
            </ul>
          </li>
        </ul>
        <!-- Mobile Menu End -->
      </nav>
      <!-- Navbar End -->
    </header>
    <!-- Header Area wrapper End -->
