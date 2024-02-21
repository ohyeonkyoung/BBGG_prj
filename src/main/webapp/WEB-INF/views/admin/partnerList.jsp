<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../head.jsp"></jsp:include>
<title>부동산회원목록</title>
</head>
<body>
	<jsp:include page="../navAdmin.jsp"></jsp:include>

	<div class="container">
		<div>
			<table border="1" class="table table-scriped table-hover">
				<thead class="table-dark">
					<tr>
						<th>고유번호</th>
						<th>이메일</th>
						<th>상호명(중개사명)</th>
						<th>대표자</th>
						<th>가입날짜</th>
						<th>연락처</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${list}">
					<tr>
						<td>${item.partnerNo}</td>
						<td>${item.userId}</td>
						<td>${item.compName}</td>
						<td>${item.partnerName}</td>
						<td><fmt:formatDate value="${item.registDate}" pattern="yyyy-MM-dd"/></td>
						<td>${item.phone}</td>
					</tr>
					</c:forEach>
					
					<c:if test="${list.size() < 1 }">
					<tr>
						<td colspan="6">검색 된 회원이 없습니다</td>
					</tr>
					</c:if>
				</tbody>
				<tfoot>
				    <tr>
				        <td colspan="5">
				            <ul class="pagination justify-content-center mt-3">
				                <li class="page-item"><a class="page-link" href="?page=1&${pager.query}">처음</a></li>
								<li class="page-item"><a class="page-link" href="?page=${pager.prev}${pager.query}">이전</a></li>
								<c:forEach var="page" items="${pager.list}">
									<li class="page-item"><a class="page-link ${page == pager.page ? 'active' : ''}" href="?page=${page}${pager.query}">${page}</a></li>
								</c:forEach>
								<li class="page-item"><a class="page-link" href="?page=${pager.next}${pager.query}">다음</a></li>
								<li class="page-item"><a class="page-link" href="?page=${pager.last}${pager.query}">마지막</a></li>
				            </ul>
				        </td>
				    </tr>
				</tfoot>
			</table>
		</div>
	</div>


	<jsp:include page="../footer.jsp"></jsp:include>
	<jsp:include page="../js.jsp"></jsp:include>
</body>
</html>