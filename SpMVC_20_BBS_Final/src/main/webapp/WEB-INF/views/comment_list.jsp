<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<c:forEach var="COMMENT" items="${COMMENT}">
	<div class="row p-4 cmt-item" data-id="${COMMENT.c_id}">
		<div class="col-2 m-1"><b>${COMMENT.c_writer}</b></div>
		<div class="col-8 m-1">${COMMENT.c_subject}</div>
		<div class="col-1 cmt-item-del"><b>&times;</b></div>
	</div>
</c:forEach>