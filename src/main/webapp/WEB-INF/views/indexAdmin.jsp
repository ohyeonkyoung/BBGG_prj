<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="head.jsp"></jsp:include>

<!-- vector map CSS -->
<link href="vendors/vectormap/jquery-jvectormap-2.0.3.css" rel="stylesheet" type="text/css" />
<!-- Morris Charts CSS -->
<link href="vendors/morris.js/morris.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<jsp:include page="navAdmin.jsp"></jsp:include>
		
	<!-- Main Content -->
    <div class="hk-pg-wrapper">
		<!-- Container -->
		<div class="container">
			<!-- Row -->			
               <div class="row">
                   <div class="col-xl-12">
					<div class="hk-row">
						<div class="col-sm-12">
							<div class="card-group hk-dash-type-2">
							
								<div class="card card-sm">
									<div class="card-body">
										<div class="d-flex justify-content-between mb-5">										
											<div>
												<span class="d-block font-15 text-dark font-weight-500">일반회원</span>
											</div>
											<div>
												<span class="text-danger font-14 font-weight-500">
													<c:choose>
														<c:when test="${userCount-userYestdCount > 0}">
															+${userCount-userYestdCount}
														</c:when>
														<c:when test="${userCount-userYestdCount <= 0}">
															${userCount-userYestdCount}
														</c:when>
														<c:otherwise>0</c:otherwise>
													</c:choose>
													</span>
											</div>
										</div>
										<div>
											<span class="d-block display-4 text-dark mb-5">${userCount}</span>
											<small class="d-block">당일 신규 가입 회원(명)</small>
										</div>
									</div>
								</div>
							
								<div class="card card-sm">
									<div class="card-body">
										<div class="d-flex justify-content-between mb-5">
											<div>
												<span class="d-block font-15 text-dark font-weight-500">부동산회원</span>
											</div>
											<div>
												<span class="text-danger font-14 font-weight-500">
													<c:choose>
														<c:when test="${partnerCount-partnerYestdCount > 0}">
															+${partnerCount-partnerYestdCount}
														</c:when>
														<c:when test="${partnerCount-partnerYestdCount <= 0}">
															${partnerCount-partnerYestdCount}
														</c:when>
														<c:otherwise>0</c:otherwise>
													</c:choose>													
												</span>
											</div>
										</div>
										<div>
											<span class="d-block display-4 text-dark mb-5"><span class="counter-anim">${partnerCount}</span></span>
											<small class="d-block">당일 신규 가입 회원(개)</small>
										</div>
									</div>
								</div>
							
								<div class="card card-sm">
									<div class="card-body">
										<div class="d-flex justify-content-between mb-5">
											<div>
												<span class="d-block font-15 text-dark font-weight-500">매물</span>
											</div>
											<div>
												<span class="text-warning font-14 font-weight-500">
													<c:choose>
														<c:when test="${itemCount-itemYestdCount > 0}">
															+${itemCount-itemYestdCount}
														</c:when>
														<c:when test="${itemCount-itemYestdCount <= 0}">
															${itemCount-itemYestdCount}
														</c:when>
														<c:otherwise>0</c:otherwise>
													</c:choose>	
												</span>
											</div>
										</div>
										<div>
											<span class="d-block display-4 text-dark mb-5">${itemCount}</span>
											<small class="d-block">당일 등록된 매물(건)</small>
										</div>
									</div>
								</div>
							
								<div class="card card-sm">
									<div class="card-body">
										<div class="d-flex justify-content-between mb-5">
											<div>
												<span class="d-block font-15 text-dark font-weight-500">신고</span>
											</div>
											<div>
												<span class="text-danger font-14 font-weight-500">													
													<c:choose>
														<c:when test="${fakeCount-fakeYestdCount > 0}">
															+${fakeCount-fakeYestdCount}
														</c:when>
														<c:when test="${fakeCount-fakeYestdCount <= 0}">
															${fakeCount-fakeYestdCount}
														</c:when>
														<c:otherwise>0</c:otherwise>
													</c:choose>													
												</span>
											</div>
										</div>
										<div>
											<span class="d-block display-4 text-dark mb-5">${fakeCount}</span>
											<small class="d-block">당일 신고(건)</small>
										</div>
									</div>
								</div>
								
							</div>
						</div>	
					</div>
					
					<div class="card">
								<div class="card-header card-header-action">
									<h6>신규 개인 회원</h6>
									<div class="d-flex align-items-center card-action-wrap">
										<a href="/admin/userList" class="inline-block refresh mr-15">
											<i class="ion ion-md-arrow-down"></i>
										</a>
										<a href="/admin/userList" class="inline-block full-screen">
											<i class="ion ion-md-expand"> <small>더보기</small></i>
										</a>
									</div>
								</div>
								<div class="card-body pa-0">
									<div class="table-wrap">
										<div class="table-responsive">
											<table class="table table-striped table-sm table-hover mb-0">
												<thead class="">
													<tr>
														<th>회원번호</th>
														<th>아이디</th>
														<th>이름</th>
														<th>가입일</th>
														<th>인증여부</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="item" items="${userList}">
														<tr>
															<td>${item.userNo}</td>
															<td>${item.userId}</td>
															<td>${item.userName}</td>
															<td><fmt:formatDate value="${item.registDate}" type="both" dateStyle="short" timeStyle="short"/></td>
															<td>${item.rememberMe}</td>
														</tr>
													</c:forEach>													
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							
							<div class="card">
								<div class="card-header card-header-action">
									<h6>신규 중개사 회원</h6>
									<div class="d-flex align-items-center card-action-wrap">
										<a href="/admin/partnerList" class="inline-block refresh mr-15">
											<i class="ion ion-md-arrow-down"></i>
										</a>
										<a href="/admin/partnerList" class="inline-block full-screen">
											<i class="ion ion-md-expand"> <small>더보기</small></i>
										</a>
									</div>
								</div>
								<div class="card-body pa-0">
									<div class="table-wrap">
										<div class="table-responsive">
											<table class="table table-striped table-sm table-hover mb-0">
												<thead class="">
													<tr>
														<th>회원no</th>
														<th>아이디</th>
														<th>부동산명</th>
														<th>가입일</th>
														<th>연락처</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="item" items="${partnerList}">
														<tr>
															<td>${item.partnerNo}</td>
															<td>${item.userId}</td>
															<td>${item.compName}</td>
															<td><fmt:formatDate value="${item.registDate}" type="both" dateStyle="short" timeStyle="short"/></td>
															<td>${item.phone}</td>
														</tr>
													</c:forEach>													
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							
							<div class="card">
								<div class="card-header card-header-action">
									<h6>최근 등록 매물</h6>
									<div class="d-flex align-items-center card-action-wrap">
										<a href="/itemList" class="inline-block refresh mr-15">
											<i class="ion ion-md-arrow-down"></i>
										</a>
										<a href="/itemList" class="inline-block full-screen">
											<i class="ion ion-md-expand"> <small>더보기</small></i>
										</a>
									</div>
								</div>
								<div class="card-body pa-0">
									<div class="table-wrap">
										<div class="table-responsive">
											<table class="table table-striped table-sm table-hover mb-0">
												<thead class="">
													<tr>
														<th>매물no</th>
														<th>부동산no</th>
														<th>매물주소</th>
														<th>매물등록날짜</th>
														<th>설명</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="item" items="${itemList}" end="9">
														<tr>
															<td>${item.itemNo}</td>
															<td>${item.partnerNo}</td>
															<td>${item.address}</td>
															<td><fmt:formatDate value="${item.registDate}" type="both" dateStyle="short" timeStyle="short"/></td>
															<td><a href="itemDetail/${item.itemNo}">${item.tag1}</a></td>
														</tr>
													</c:forEach>													
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							
							<div class="card">
								<div class="card-header card-header-action">
									<h6>최근 신고</h6>
									<div class="d-flex align-items-center card-action-wrap">
										<a href="/fake/list" class="inline-block refresh mr-15">
											<i class="ion ion-md-arrow-down"></i>
										</a>
										<a href="/fake/list" class="inline-block full-screen">
											<i class="ion ion-md-expand"> <small>더보기</small></i>
										</a>
									</div>
								</div>
								<div class="card-body pa-0">
									<div class="table-wrap">
										<div class="table-responsive">
											<table class="table table-striped table-sm table-hover mb-0">
												<thead class="">
													<tr>
														<th>신고no</th>
														<th>매물no</th>
														<th>부동산명</th>
														<th>내용</th>
														<th>상태</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="item" items="${fakeList}">
														<tr>
															<td>${item.fakeNo}</td>
															<td>${item.itemNo}</td>
															<td>${item.compName}</td>
															<td>${item.fakeContent}</td>
															<td><a href="itemSelect/${item.itemNo}">${item.useAt}</a></td>
														</tr>
													</c:forEach>													
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
					
				</div> <!-- /col-xl-12 -->
			</div>
            <!-- /Row -->
        </div>
        <!-- /Container -->
    </div>
    <!-- /HK Wrapper -->
    
    <!-- jQuery -->
    <script src="../../resources/vendors/jquery/dist/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../../resources/vendors/popper.js/dist/umd/popper.min.js"></script>
    <script src="../../resources/vendors/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- Slimscroll JavaScript -->
    <script src="../../resources/dist/js/jquery.slimscroll.js"></script>

    <!-- Fancy Dropdown JS -->
    <script src="../../resources/dist/js/dropdown-bootstrap-extended.js"></script>

    <!-- FeatherIcons JavaScript -->
    <script src="../../resources/dist/js/feather.min.js"></script>

    <!-- Toggles JavaScript -->
    <script src="../../resources/vendors/jquery-toggles/toggles.min.js"></script>
    <script src="../../resources/dist/js/toggle-data.js"></script>
	
	<!-- Counter Animation JavaScript -->
	<script src="../../resources/vendors/waypoints/lib/jquery.waypoints.min.js"></script>
	<script src="../../resources/vendors/jquery.counterup/jquery.counterup.min.js"></script>
	
	<!-- Morris Charts JavaScript -->
    <script src="../../resources/vendors/raphael/raphael.min.js"></script>
    <script src="../../resources/vendors/morris.js/morris.min.js"></script>
	
	<!-- EChartJS JavaScript -->
    <script src="../../resources/vendors/echarts/dist/echarts-en.min.js"></script>
    
	<!-- Sparkline JavaScript -->
    <script src="../../resources/vendors/jquery.sparkline/dist/jquery.sparkline.min.js"></script>
	
	<!-- Owl JavaScript -->
    <script src="../../resources/vendors/owl.carousel/dist/owl.carousel.min.js"></script>
	
	<!-- Init JavaScript -->
    <script src="../../resources/dist/js/init.js"></script>
	<script src="../../resources/dist/js/ecStat.min.js"></script>
	<script src="../../resources/dist/js/dashboard5-data.js"></script>

<jsp:include page="footer.jsp"></jsp:include>
<jsp:include page="js.jsp"></jsp:include>
</body>
</html>