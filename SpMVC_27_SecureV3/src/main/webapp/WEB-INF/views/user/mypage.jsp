<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/include-nav.jspf" %>
	<style>
		#body {
			/*height: 2000px;*/
			width: 70%;
			margin:auto;
			margin-top: 150px;
		}
		
		.tbl_mypage {
			position: relative;
		    width: 100%;
		    table-layout: fixed;
		    border-spacing: 0;
		    border-collapse: collapse;
		    word-wrap: break-word;
		    word-break: keep-all;
		    border: 0;
		    border-bottom: 1px solid #e5e5e5;
		}
		
		.tbl_mypage tr {
			display: table-row;
		    vertical-align: inherit;
		    border-color: inherit;
		    
		}
		
		.tbl_mypage th {
			color: #333;
		    border-right: 1px solid #e5e5e5;
		    background: #f9f9f9;
		    padding : 32px 31px;
		    height:165px;
		}
		
		.tbl_mypage td {
			padding: 32px 0 32px 30px;
			display: flex;
			flex-direction: column;
		}
		
		.pre_content span {
			width: 100px;
		}
		
		button.btn_user {
			border: 1px solid #bfbfbf;
	    	background: #fff;
	    	font-weight: bold;	
	    	margin: auto;
	    	
			padding:5px 6px ;
		}
		
		button.btn_content {
			border: 1px solid #bfbfbf;
	    	background: #fff;
	    	font-weight: bold;	
	    	color: blue;
	    	
			padding:10px 12px ;
		}
		
		.tbl_mypage td input {
			float: left;
		    width: 147px;
		    margin: 3px 3px 3px 0;
		    padding-left: 0;
		    letter-spacing: 0;
		    border: 1;
		}
		
		
	</style>
	<section id="body">
		<article class="user_article">
			<h2>${userVO.username}의 MYPAGE</h2>
			<hr/>
			<div>
				<form>
					<table class="tbl_mypage">
						<tr>
							<th>이름</th>
							<td>
								<div class="pre_content">
									<span>${userVO.username}</span>
									<button type="button" class="btn btn_user" data-toggle="collapse" data-target="#update_username">수정</button>
								</div>
								<div id="update_username" class="collapse form-group">
									<input type="text" name="username" class="form-control" placeholder="이름">
									<button class="btn btn_content" type="button">수정완료</button>
								</div>
							</td>
						<tr>
						<tr>
							<th>이메일</th>
							<td>
								<div class="pre_content">
									<span>${userVO.email}</span>
									<button type="button" class="btn btn_user" data-toggle="collapse" data-target="#update_email">수정</button>
								</div>
								<div id="update_email" class="collapse form-group">
									<input type="email" name="email" class="form-control" placeholder="이메일">
									<button class="btn btn_content" type="button">수정완료</button>
								</div>
							</td>
						<tr>
						<tr>
							<th>전화번호</th>
							<td>
								<div class="pre_content">
									<span>${userVO.phone}</span>
									<button type="button" class="btn btn_user" data-toggle="collapse" data-target="#update_phone">수정</button>
								</div>
								<div id="update_phone" class="collapse form-group">
									<input type="text" name="phone"  class="form-control" placeholder="전화번호">
									<button class="btn btn_content" type="button">수정완료</button>
								</div>
							</td>
						<tr>
						<tr>
							<th>주소</th>
							<td>
								<div class="pre_content">
									<span>${userVO.address}</span>
									<button type="button" class="btn btn_user" data-toggle="collapse" data-target="#update_addr">수정</button>
								</div>
								<div id="update_addr" class="collapse form-group">
									<input type="text" name="address"  class="form-control" placeholder="주소">
									<button class="btn btn_content" type="button">수정완료</button>
								</div>
							</td>
						<tr>
					</table>
				</form>
			</div>
		</article>
	</section>
</body>
</html>