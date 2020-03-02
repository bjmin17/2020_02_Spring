<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<form method="POST" class="repl">
	<div class="row p-4">
		<div class="col-2">
			<input name="c_p_id" id="c_p_id" class="form-control" type="hidden" value="${CMT.c_p_id}">
			<input name="c_b_id" class="form-control" type="hidden" value="${CMT.c_b_id}">
			<input name="c_writer" id="c_writer" class="form-control" placeholder="작성자">
		</div>
		<div class="col-8">
			<input name="c_subject" id="c_subject" class="form-control" placeholder="댓글을 입력하세요">
		</div>
		<div class="col-2 d-flex justify-content-start">
			<button type="button" class="btn btn-primary mr-2 commentInsert btn-cmt-save">답변저장</button>
			<a href="${rootPath}/"><button type="button" class="btn btn-success">목록으로</button></a>
		</div>
	</div>
</form>
