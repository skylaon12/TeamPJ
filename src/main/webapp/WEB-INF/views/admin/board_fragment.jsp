<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />	
<table class="table table-hover text-nowrap">
	<thead>
		<tr>
			<th>제목</th>
			<th>작성자</th>
			<th>등록일자</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="dto" items="${board}">
			<tr>
				<td><a href="read?id=${dto.p_id}" style="color: inherit; text-decoration: none;">${dto.p_title}</a></td>
				<td>${dto.p_writer}</td>
				<td>${dto.p_created}</td>
				<td>${dto.p_hitcount}</td>
				<td><a href="${cp}/admin/boardDel?id=${dto.p_id}"><button name="delete-btn" type="button" class="btn btn-block btn-danger btn-sm">문의 삭제</button></a></td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>
				<a href="${cp}/admin/write"><button type="button" class="btn btn-block bg-gradient-success btn-sm">등록</button></a>
			</td>
		</tr>
	</tfoot>
</table>