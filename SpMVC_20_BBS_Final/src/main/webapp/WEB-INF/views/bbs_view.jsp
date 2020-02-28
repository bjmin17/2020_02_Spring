<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
	<script>
	$(function(){
		// $(".cmt-item").click(function(){
		// document 자체에 이벤트를 걸고 click을 하면 cmt-item이 있는지 보고 이벤트 건다.
		// 동적 html
		$(document).on("click",".cmt-item",function(){
			let id = $(this).data("id")
			alert("cmt-item:" + id)
		})
		
		// let c_id = $(this).closest("div").data("id")
		// 가장 인접한 곳(closest)에 있는 div를 찾아서 거기 있는 id를 가져오라
		$(document).on("click","div.cmt-item-del",function(event){
			
			// 나를 감싸고 있는 곳으로 이벤트가 전파되는 것을
			// 그만두어라
			event.stopPropagation()
			if(!confirm("코멘트를 삭제할까요?")) {
				return false
			}
			
			// $(this).parent("div")
			// 현재 자신을 감싸고 있는 가장 가까운 div를 찾아라
			let c_id = $(this).parent("div").data("id")
			// alert("item-del : " + c_id)
			$.ajax({
				url : "${rootPath}/comment/delete/",		
				data : {
					c_id : c_id,
					b_id : "${BBS.b_id}"
				},
				type : "POST",
				success : function(result) {
					$("div.cmt-list").html(result)
				},
				error : function() {
					alert("서버 통신 오류")
				}
			
			})
			
		})		
		$("button").click(function(){
			let txt = $(this).text()
			if(txt == '수정') {
				document.location.href="${rootPath}/update?b_id=${BBS.b_id}"
			} else if(txt == '삭제') {
				if(confirm("삭제할까요?")) {
					document.location.replace("${rootPath}/delete/${BBS.b_id}")
				}
			} else if(txt == '저장') {
				/*
				ajax를 사용해서 form에 담긴 데이터를 controller로 전송
				*/
				// form 태그가 한개라서 그저 form만 넣고, 여러개면 아이디나 클래스 넣기
				// serialize는 jQuery 함수로 form에 있는 데이터를 한줄로 만들고 서버로 보내기 좋게 만들어준다.
				
				var formData = $("form").serialize()
				//alert(formData)
				// data : formData는 위의 var formData를 싣기
				// $("div.cmt-list").html(result)는 div의 cmt-list 클래스에 html로 result를 싣기
				$.ajax({
					url : "${rootPath}/comment/insert",
					data : formData,
					type : "POST",
					success : function(result){
						$("div.cmt-list").html(result)
					},
					error : function(){
						alert("서버 통신 오류")
					}
					
				})
				return true
			} else {
				document.location.href="${rootPath}/list"
			}
		})
		
	})
	</script>
	<style>
	table.table tr:nth-child(4) th, table.table tr:nth-child(4) td {
		
		height: 400px;
	}
	table.table tr:nth-child(4) td{
		overflow-y:scroll;
		
	}
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/include-header.jspf" %>
	<section class="container-fluid">
		<h2 class="p-3">${BBS.b_subject}</h2>
		<div class="row p-3">
			<small class="col-1">${BBS.b_writer}</small>
			<small class="col-5">${BBS.b_date_time}</small>
		</div>
		<hr/>
		<div class="p-3">
			${BBS.b_content}
		</div>
	</section>
	<div class="form-group d-flex justify-content-end">
		<button class="btn btn-warning mr-2">수정</button>
		<button class="btn btn-danger mr-2">삭제</button>
		<button class="btn btn-success"	>목록으로</button>
	</div>
	<section class="container-fluid bg-light p-4">
		<div class="col-2 m-1"><b>댓글 작성란</b></div>
		<form action="${rootPath}/comment/insert" method="POST">
			<div class="row p-4">
				<div class="col-2">
					<input name="c_b_id" class="form-control" type="hidden" value="${BBS.b_id}">
					<input name="c_writer" class="form-control" placeholder="작성자">
				</div>
				<div class="col-8">
					<input name="c_subject" class="form-control" placeholder="댓글을 입력하세요">
				</div>
				<div class="col-2 d-flex justify-content-start">
					<button type="button" class="btn btn-primary mr-2 commentInsert">저장</button>
					<a href="${rootPath}/"><button type="button" class="btn btn-success">목록으로</button></a>
				</div>
			</div>
		</form>
		
		<div class="p-4 cmt-list">
			<%@ include file="/WEB-INF/views/comment_list.jsp" %>
		</div>
	</section>
</body>
</html>


