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
			
			let writer = $(this).find("div.writer").text()
			let subject = $(this).find("div.subject").text()
			
			$("#c_id").val(id)
			$("#c_writer").val(writer)
			$("#c_subject").val(subject)
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

		$(document).on("click",".cmt-item-repl",function(event){
			
			let b_id = "${BBS.b_id}"
			let c_id = $(this).parent("div").data("id")
			let data = {c_b_id:b_id,c_p_id:c_id}
			
			event.stopPropagation()
			
			$.get("${rootPath}/comment/repl",data,function(result){

				$(".modal-body").html(result)
				$(".modal-main").css("display","block")
				
			})
		})
		
		$(document).on("click","button",function(){

		//$(document)clic)("button").click(function(){
			let txt = $(this).text()
			if(txt == '수정') {
				document.location.href="${rootPath}/update?b_id=${BBS.b_id}"
			} else if(txt == '삭제') {
				if(confirm("삭제할까요?")) {
					document.location.replace("${rootPath}/delete/${BBS.b_id}")
				}
			} else if(txt == '답변저장') {
				
				var formData = $("form.repl").serialize()
				$.ajax({
					url : "${rootPath}/comment/insert",
					data : formData,
					type : "POST",
					success : function(result){
						$(".modal-main").css("display","none")
						$("div.cmt-list").html(result)
					},
					error : function(){
						alert("서버 통신 오류")
					}
				})
				
				
			} else if(txt == '저장') {
				/*
				ajax를 사용해서 form에 담긴 데이터를 controller로 전송
				*/
				// form 태그가 한개라서 그저 form만 넣고, 여러개면 아이디나 클래스 넣기
				// serialize는 jQuery 함수로 form에 있는 데이터를 한줄로 만들고 서버로 보내기 좋게 만들어준다.
				
				/*
				ajax를 사용해서 form 담긴 데이터를 controller로 전송
				.serialize() 함수를 사용해서 form에 담긴 데이터를 문자열화하고, query 형식으로 변경하고 ajax의 data에 담아서 전송
				*/
				
				/* 만약 ajax를 이용 안 한다면 아래 aData처럼 input 박스에 있는 값들을 넣어서 해줘야 한다
				// input box에 입력한 데이터를 json 형태로 변경하기
				// 항목이 많을 경우, 문제를 일으킬 수 있다.
				var aData = {
					c_writer : $("#c_writer").val(),
					c_subject : $("#c_subject").val()
				}
				*/
				
				// serialize()를 사용하면 모든 문제 해결
				var formData = $("form.main").serialize()
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
				
			} else if(txt == '답글작성') {
				// alert("답글쓰기")
				document.location.href = "${rootPath}/repl?b_id=${BBS.b_id}"
				return false
				
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
		<button class="btn btn-info mr-2">답글작성</button>
		<button class="btn btn-success"	>목록으로</button>
	</div>
	<section class="container-fluid bg-light p-4">
		<div class="col-2 m-1"><b>댓글 작성란</b></div>
		<form class="main" method="POST">
			<div class="row p-4">
				<div class="col-2">
					<input name="c_id" id="c_id" class="form-control" type="hidden" value="0">
					<input name="c_b_id" class="form-control" type="hidden" value="${BBS.b_id}">
					<input name="c_writer" id="c_writer" class="form-control" placeholder="작성자">
				</div>
				<div class="col-8">
					<input name="c_subject" id="c_subject" class="form-control" placeholder="댓글을 입력하세요">
				</div>
				<div class="col-2 d-flex justify-content-start">
					<button type="button" class="btn btn-primary mr-2 commentInsert btn-cmt-save">저장</button>
					<a href="${rootPath}/"><button type="button" class="btn btn-success">목록으로</button></a>
				</div>
			</div>
		</form>
		
		<div class="p-4 cmt-list">
			<%@ include file="/WEB-INF/views/comment_list.jsp" %>
		</div>
		<style>
	div.modal-main {
		position: fixed;
		top:0;
		left:0;
		
		width:100%;
		height: 100%;
		
		overflow: auto;
		
		background-color: rgba(0,0,0,0.4);
		z-index:10;
		display: none;
	}
	
	div.modal-content {
		width: 80%;
		position:relative;
		margin:auto;
		top:300px;
		padding:0;	
		
	}
	
	div.modal-header{
		display: flex;
		justify-content: flex-end;
	}
	
	span.modal-close {
		cursor: pointer;
		float: right;
		font-size: 30px;
		font-weight: bold;
		color:black;
	}
	
	span.modal-close:hover, span.modal-close:focus {
		color:#000;
	}
</style>
<script>
$(function(){
	
	$(".modal-close").click(function(){
		$(".modal-main").css("display","none")
	})
	
})
</script>

<div class="modal-main">
	<div class="modal-content">
		<div class="modal-header">
			<span class="modal-close">&times;</span>
		</div>
		<div class="modal-body">
			
		</div>
	</div>
</div>
	</section>
</body>
</html>


