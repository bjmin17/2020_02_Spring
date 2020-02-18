<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
.in-errors {
	color:red;
	font-size: 8px;
}
/*
	col-md-7 col-12
	해상도가 768보다 크면 7칸만 차지하고
	그 이하이면 12칸을 차지하여 풀 width로 보여라

*/

tr,td,th {
	white-space: nowrap;
}

.pro-list {
	overflow: auto;
}

.p_name {
	display:inline-block;
	width: 150px;
	padding: 0 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

</style>

<section class="container-fluid row mt-5">
	<article class="col-md-7 col-12 bg-light pro-input">
	
		<form:form action="${rootPath}/admin/dept/input" modelAttribute="deptVO">
			
			<div class="container-fluid form-group row">
				<form:input path="d_code" class="form-control col-6" placeholder="거래처코드"/>
				<form:input path="d_name" class="form-control col-6" placeholder="거래처명"/>
			</div>
			<div class="container-fluid form-group row">
				<form:errors path="d_code" class="in-errors col-6"/>
				<form:errors path="d_name" class="in-errors col-6"/>
			</div>
			<div class="container-fluid form-group row">
				<form:input path="d_ceo" class="form-control col-6" placeholder="대표자명"/>
				<form:input path="d_sid" class="form-control col-6" placeholder="사업자번호"/>
			</div>
			<div class="container-fluid form-group row">
				<form:errors path="d_ceo" class="in-errors col-6"/>
				<form:errors path="d_sid" class="in-errors col-6"/>
			</div>
			<div class="form-group">
				<form:input path="d_tel" class="form-control" placeholder="대표전화"/>
				<form:errors path="d_tel" class="in-errors col-6"/>
			</div>
			<div class="form-group">
				<form:input path="d_addr" class="form-control" placeholder="주소"/>
				<form:errors path="d_addr" class="in-errors col-6"/>
			</div>
			<div class="container-fluid form-group row">
				<form:input path="d_manager" class="form-control col-6" placeholder="담당자명"/>
				<form:input path="d_mtel" class="form-control col-6" placeholder="담당자 전화번호"/>
			</div>
			<div class="container-fluid form-group row">
				<form:errors path="d_manager" class="in-errors col-6"/>
				<form:errors path="d_mtel" class="in-errors col-6"/>
			</div>
			<div class="form-group">
				<form:textarea path="d_rem" class="form-control" rows="" cols="" placeholder="비고"/>
				<form:errors path="d_rem" class="in-errors col-6"/>
			</div>
			<div class="form-group">
				<button>저장</button>
			</div>
		</form:form>
			

	</article>
	
	<article class="col-md-4 col-12 bg-light list-body">
		<%@ include file="/WEB-INF/views/dept/dept_list.jsp" %>
	</article>
</section>