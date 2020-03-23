<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나의 홈페이지</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script>
	$(function() {
		$(".btn-insert").click(function() {
			document.location.href = "${rootPath}/insert"
		})

		$(".btn-update").click(function() {
			let id = $(this).data("id")

			document.location.href = "${rootPath}/update?b_id=" + id
		})

		$(".btn-delete").click(function() {
			let id = $(this).data("id")
			if (confirm("버킷 리스트를 삭제하겠습니까?")) {
				document.location.replace("${rootPath}/delete?b_id=" + id)
			}
		})
		

		
		 $(".custom-control-input").click(function(){
			 var checked = $(this).data("check")
			 var newChecked = checked * (-1)
			 
			 let id = $(this).data("id")
			 let b_name = $(this).data("name")
			 
			 
			 
			 $.ajax({
					 url : "${rootPath}/update?b_id="+id,
					 type : "POST",
					 data : {
					 	bucketlistname : b_name,
					 	checked : newChecked
					 },
					 success : function(result) {
						 document.location.href="${rootPath}/"
						 
					 }, error:function(){
						 alert("서버 통신 오류")
					 }
			 })
		 })
	})
</script>
<style>
body {
	width: 768px;
	margin: auto;
}

tbody.tbody-list tr:hover {
	background-color: #eee;
}


</style>
</head>
<header class="jumbotron">
	<h1>나의 버킷리스트</h1>
	<p> 꼭 한 번쯤은 해 보고 싶은 것</p>
</header>
<body>
	<section>
		<article>
			<table class="table">
				<tr>
					<th>No</th>
					<th>할일</th>
					<th>시작날짜</th>
					<th>기한</th>
					<th>달성일</th>
					<th>달성여부</th>
					<th>비고</th>
				</tr>
				<c:choose>
					<c:when test="${empty BUCKETLIST}">
						<td colspan="7">버킷리스트가 없습니다.</td>
					</c:when>
					<c:otherwise>
						<tbody class="tbody-list">
							<c:forEach items="${BUCKETLIST}" var="bucket" varStatus="index">
								<tr>
									<td>${index.count}</td>
									<td>${bucket.bucketlistname}</td>
									<td>${bucket.bucketlistsdate}</td>
									<td>${bucket.bucketlistdeadline}</td>
									<td>${bucket.bucketlistachivedate}</td>
									<td>
										<form>
											<div class="custom-control custom-checkbox">
												<c:if test="${bucket.checked > 0}">
													<input type="checkbox" class="custom-control-input"
														id="${bucket.b_id}&&check" name="${bucket.b_id}&&check"
														data-id="${bucket.b_id}" 
														data-name="${bucket.bucketlistname}"
														data-check="${bucket.checked}" checked> 
													<label
														class="custom-control-label" for="${bucket.b_id}&&check">Check
													</label>
												</c:if>
												<c:if test="${bucket.checked < 0}">
													<input type="checkbox" class="custom-control-input"
														id="${bucket.b_id}&&check" name="${bucket.b_id}&&check"
														data-id="${bucket.b_id}" 
														data-name="${bucket.bucketlistname}"
														data-check="${bucket.checked}" > 
													<label
														class="custom-control-label" for="${bucket.b_id}&&check">Check
													</label>
												</c:if>
											</div>
										</form>
									</td>
									<td>
										<button class="btn btn-outline-warning btn-update"
											data-id="${bucket.b_id}">수정</button>
										<button class="btn btn-outline-danger btn-delete"
											data-id="${bucket.b_id}">삭제</button>
									</td>

								</tr>

							</c:forEach>
						</tbody>
					</c:otherwise>
				</c:choose>
			</table>
		</article>
		<article>
				<button class="btn btn-outline-primary btn-insert ml">추가</button>
		</article>
	</section>

</body>
</html>