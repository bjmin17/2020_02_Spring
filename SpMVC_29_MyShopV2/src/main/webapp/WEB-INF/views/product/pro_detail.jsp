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

div.p_detail_white{
	flex:1;
	text-align: right;
	font-weight: bold;
}
</style>
<script>
$(function(){
	$("button.size-add").click(function(){
		// 선택된것 가져오고 싶으면 option:selected해주기
		let size_standard = $("#m_size_list option:selected").val()
		let size_name = $("#m_size_list option:selected").text()
		//alert(size_standard + size_name)
		
		// select box의 multiple이 false이면 작동하지 않는 스크립트
		if(!size_standard) {
			alert("추가할 사이즈를 선택하세요")
		}
		
		$.ajax({
			url : "${rootPath}/product/insert_size",
			method : "POST",
			data : {
				s_size : size_standard,
				p_code : '${productVO.p_code}'
			},
			beforeSend : function(ax) {
				ax.setRequestHeader(
					"${_csrf.headerName}","${_csrf.token}"		
				)
			}
			
		})
		// success와 같은 코드
		// ajax 바깥에 적기
		.done(function(result){
			
			if(result == "EXISTS") {
				alert("이미 등록된 사이즈 정보입니다.")
			} else {
				// 옵션 추가하기
				$("#p_size_list").append(
						$("<option/>",
								{
								value:result.s_size,
								text:size_name,
								'data-id' : result.s_seq // jackson-databind 설치하기
								})
				)
			}
		})
		
	})
	
	$("button.size-delete").click(function(){
		
		let seq = $("#p_size_list option:selected").data("id")
		
		
		let size_standard = $("#m_size_list option:selected").val()
		
		$.ajax({
			url : '${rootPath}/product/delete_size',
			method : "POST",
			data : {
				s_seq:seq
			},
			beforeSend : function(ax) {
				ax.setRequestHeader(
					"${_csrf.headerName}","${_csrf.token}"		
				)
			}
		})
		.done(function(result){
			if(result == "DELETE"){
				alert("삭제 완료")
				$("#p_size_list option:selected").remove()
			} else {
				alert("삭제 불가")
			}
		})
		
		// 선택한 것 삭제하기
		$("#p_size_list option:selected").remove()
	}) // button-delete end
	
	$("button.color-add").click(function(){
		
		let size_seq = $("#p_size_list option:selected").data("id")
		
		console.log("사이즈 seq", size_seq)
		
		// size select가 선택되지 않아서 size_value 값이
		// undefined가 되면 이 값은 false와 같다
		if(!size_seq) {
			alert("컬러를 추가하려면 먼저사이즈를 선택해야 합니다.")
			return false
		}
		
		let color_name = $("#m_color_list option:selected").text()
		let color_value = $("#m_color_list option:selected").val()
		
		$.ajax({
			url : "${rootPath}/product/insert_color",
			method : "POST",
			data : { size_seq : size_seq, c_color : color_value},
			beforeSend : function(ax) {
				ax.setRequestHeader(
					"${_csrf.headerName}","${_csrf.token}"		
				)
			}
		})
		.done(function(result){
			if(result == "EXISTS") {
				alert("이미 등록된 컬러 리스트 입니다.")
			} else {
				$("#p_color_list").append(
					$("<option/>",
						{
							'data-id' : result.c_seq,
							value:result.c_color, 
							text:color_name
						})		
				)
			}
		})
		
		
		
	}) // add-color end
	$("#p_size_list").change(function(){
		
		let s_seq = $(this).find("option:selected").data("id")
		alert(s_seq)
		
		$.ajax({
			url : "${rootPath}/product/get_color_list_by_size",
			method : "GET",
			data : { s_seq : s_seq },
		})
		.done(function(color_list){
			
			// select의 전체 options를 삭제
			$("#p_color_list option").remove()
			
			if(color_list =="FAIL") {
				alert("통신오류")				
			} else if( !color_list.length){
				alert("컬러 리스트가 없음")
			} else {
				color_list.forEach(function(vo) {
					$("#p_color_list").append(
						$("<option/>",
								{
									value:vo.c_color,
									text:vo.o_name,
									'data-id':vo.c_seq
								}
						)		
					)
				})
			}	
		})
	})
})

</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/include-nav.jspf"%>

	<section class="container body">
	
		<p>상품 코드 : ${productVO.p_code}
		<p>상품명 : ${productVO.p_name}
		<p>품목코드 : ${productVO.p_bcode}
		<p>주매입처코드 : ${productVO.p_dcode}
		<p>매입가격 : ${productVO.p_iprice}
		<p>판매가격 : ${productVO.p_oprice}
		<p>과세여부 : ${productVO.p_vat}
		<p>대표이미지 : ${productVO.p_file}
		<img width="100px" src="${rootPath}/upload/${productVO.p_file}">
	
	</section>
	<div class="p_detail_box">
		<div class="p_detail_white">
			<button onclick="location.href=${rootPath}/product" class="btn btn-success">목록으로</button>
		</div>
	</div>
	<article class="container p-5 bg-light">
		<form:form modelAttribute="productVO">
			<div class="p_detail_box">
				<div class="p_detail_white">
					<h5>사이즈 선택</h5>
					<form:select path="m_size_list" class="form-control" multiple="false">
						<form:options items="${m_size_list}" itemLabel="o_name" itemValue="o_standard"/>
					</form:select>
					<button type="button" class="btn btn-primary size-add">▼ 추가</button>
					<button type="button" class="btn btn-warning size-delete">▲ 삭제</button>
					<form:select path="p_size_list" class="form-control">
						<c:forEach items="${productVO.p_size_list}" var="vo">
							<form:option value="${vo.s_size}" data-id="${vo.s_seq}">${vo.o_name}</form:option>
						</c:forEach>
					</form:select>
					
				</div>
				<div class="p_detail_white">
					<h5>컬러 선택</h5>
					<form:select path="m_color_list" class="form-control" multiple="false">
						<form:options items="${m_color_list}" itemLabel="o_name" itemValue="o_standard"/>
					</form:select>
					<button type="button" class="btn btn-primary color-add">▼ 추가</button>
					<button type="button" class="btn btn-warning color-delete">▲ 삭제</button>
					<select id="p_color_list" multiple="multiple" class="form-control">
											
					</select>
				</div>
			</div>
		</form:form>
	</article>
</body>
</html>