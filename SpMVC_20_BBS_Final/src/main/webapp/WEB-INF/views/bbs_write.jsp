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
		$("button.btn_delete").click(function(){
			if(confirm("글을 삭제합니까?")) {
				let query = "${rootPath}/delete?b_id=${BBS.b_id}"
				alert(query)
				document.location.replace(query)
				
			}
		})

		var toolbar = [
			['style',['bold','italic','underline'] ],
			['fontsize',['fontsize']],
			['font Style',['fontname']],
			['color',['color']],
			['para',['ul','ol','paragraph']],
			['height',['height']],
			['table',['table']],
			['insert',['link','hr','picture']],
			['view',['fullscreen','codeview']]
			
		]
		
		// summernote의 드롭앤드랍 기능 가로채기 위해서 callbacks 생성
		// onImageUpload : function(files,editor,isEdit)
		// 파일정보는 files에, editor에는 섬머노트 자체가 전달된다.
		$("#b_content").summernote({
			lang:'ko-KR',
			placeholder:'본문을 입력하세요',
			width:'100%',
			toolbar:toolbar,
			height:'200px',
			disableDragAndDrop : false,
			callbacks : {
				onImageUpload : function(files,editor,isEdit){
				
					for(let i = files.length - 1; i >=0 ; i--) {
						// 파일을 1개씩 업로드할 함수
						upFile(files[i],this); // files의 i번째 파일을 업로드,,,, this = editor, 섬머노트 그 자체를 말한다.
					}
				}
			}
		}) // end summer
		
		// ajax를 사용해서 파일을 서버로 업로드 수행하고
		// 실제 저장된 파일 이름을 받아서
		// summernote에 기록된 내용 중 img src=""을 변경할 예정
		function upFile(file,editor) {
			
			var formData = new FormData()
			// upFile 변수에 file 정보를 담아서 보내기 위한 준비
			// upFile은 변수 이름, file은 실제로 우리가 올릴 파이름 정보
			// editor.insertImage
			// summernote의 내장 함수를 callback 형태로
			// 호출해서 현재 summernote box에 표시하고자하는
			// 이미지의 src 부분을 url값으로 대치
			
			// img src="data:base64~!~~~~"처럼 긴 이름을
			// img src="UUID파일.jpg" 형태로 변경
			
			formData.append('upFile',file)
			$.ajax({
				url : "${rootPath}/image_up",
				type : "POST",
				data : formData,
				contentType : false,
				processData : false,
				enctype : "multipart/form-data",
				success : function(result) {
					alert(result)
					result = "${rootPath}/files/" + result // 파일이름만 오기 때문에 path를 등록해주기
					$(editor).summernote('editor.insertImage',result) // 섬머노트 내장객체에 result를 넣음
				},
				error : function() {
					alert("서버 통신 오류")
				}
				
			})
			
			
		}
		
	}) 
	</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/include-header.jspf" %>
	<section class="container-fluid">
		<fieldset>
			<form method="POST">
				<input type="hidden" id="id" name="b_id" class="form-control" value="${BBS.b_id}">
				<div class="form-group">
					<input name="b_writer" class="form-control" placeholder="작성자" value="${BBS.b_writer}">
				</div>
				<div class="form-group">
					<input name="b_subject" class="form-control" placeholder="제목" value="${BBS.b_subject}">
				</div>
				<div class="form-group summer">
					<textarea id="b_content" name="b_content" rows="5" cols="30">${BBS.b_content}</textarea>
				</div>
				<div class="form-group d-flex justify-content-end">
					<button class="btn btn-primary mr-2">저장</button>
					<button type="button" class="btn btn-danger mr-2 btn_delete" data-id="${BBS.b_id}">삭제</button>
					<a href="${rootPath}/"><button type="button" class="btn btn-success">목록으로</button></a>
				</div>
			</form>
			
		</fieldset>
	</section>
</body>
</html>


