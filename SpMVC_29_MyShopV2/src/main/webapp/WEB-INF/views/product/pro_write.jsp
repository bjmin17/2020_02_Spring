<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
<style>
#body {
	height: 1000px;
}

form{
	width:100%;
}

section {
	width:100%;
	display: flex;
	border:1px solid red;
}

article {
	flex: 1px;
	margin: 5px;
	border: 1px solid blue;
}
</style>
<script>
$(function(){
	// $("button.save").click(function(){})를 사용해야 한다.
	// ajax로 호출하여 가져온 form에서는 사용하면 안되는 이벤트
	$(document).on("click","button.save",function(){
		let p_code = $("#p_code").val()
		if(p_code == "") {
			$("div#p_code_error").html("<b>* 상품코드는 반드시 입력하세요!!</b>")
			$("#p_code").focus()
			return false
		}
		
		$('form').submit()
		
	})
	
	$(document).on("blur","#p_code",function(){
		// 상품코드는 중복되면 안되기 때문에
		// 중복된 상품코드를 미리 검사해보자
		let p_code = $("#p_code").val()
		if(p_code == "") {
			$("div#p_code_error").html("<b>* 상품코드는 반드시 입력하세요!!</b>")
			$("#p_code").focus()
			return false
		}
		
		$.ajax({
			url : "${rootPath}/product/code_check",
			data : {p_code : p_code},
			type : "GET",
			method : "GET",
			success : function(result) {
				if(result == "EXISTS") {
					$("div#p_code_error").html("이미 사용중인 코드입니다.")
					$("#p_code").focus()
					return false
				} else if(result = "NONE") {
					$("div#p_code_error").html("<font color='blue'>사용가능한 코드입니다.</font>")
					/*
						상품 코드 중복검사를 ajax로 실행한 후
						데이터를 서버로 submit을 수행할 때는
						ajax가 끝난 다음 success 함수내에서 실행을 해 주어야 한다.
						
						만약 ajax 코드 밖에서 submit을 수행하면 
						ajax로 중복검사를 수행하기 전에
						submit이 실행되어 버릴 수 있다.
					*/
					
				}
			},
			error : function(x,error) {
				$("div#p_code_error").html("서버 통신 오류")
			}
		})
		// ajax가 끝난뒤 코드를 추가하면, 
		// ajax 실행 뒤 어떤 코드가 먼저 실행되는지 정해지지 않는다.
		// $('form').submit()
		
	})
	
	$("#ajax_up").click(function(){
		let formData = new FormData()
		let file = $("#file")[0].files[0]
		formData.append("file",file) // append를 이용해서 파일을 추가시켜주기
		$.ajax({
			url : "${rootPath}/file/upload",
			method : "POST",
			data : formData,
			processData : false, // Ajax를 이용해서 file업로드를 할 때 중요한것
			contentType : false, // Ajax를 이용해서 file업로드를 할 때 중요한것
			// data로 전달해주면 문제는 csrf 토큰을 전달할 수가 없어서 403 오류가 발생한다.
			beforeSend : function(ax) {
				ax.setRequestHeader("${_csrf.headerName}","${_csrf.token}") // Ajax에서 token값 세팅하는 절차
			},
			success : function(result) {
				alert(result)
			},
			error : function() {
				alert("서버 통신 오류")
			}

		})
	})
})
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/include-nav.jspf"%>

	<form:form modelAttribute="productVO" action="?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
		<section class="container body">

			<article>
				<h3>상품정보 등록</h3>
				<div id="p_code_error" class="text-danger">
				</div>
				<div class="form-group">
					<form:input path="p_code" class="form-control" placeholder="상품코드" />
				</div>
				<div class="form-group">
					<form:input path="p_name" class="form-control" placeholder="상품이름" />
				</div>
				<div class="form-group">
					<form:input path="p_oprice" class="form-control" placeholder="판매가격" />
				</div>
				<div class="form-group">
					<input type="file" id="file" name="file">
					<button type="button" id="ajax_up">ajax 파일업</button>
				</div>
				<div class="button-group">
					<button type="button" class="btn btn-primary save ">저장</button>
					<button type="button" class="btn btn-success list">상품목록으로</button>
				</div>

			</article>
		</section>
		
	</form:form>

</body>
</html>