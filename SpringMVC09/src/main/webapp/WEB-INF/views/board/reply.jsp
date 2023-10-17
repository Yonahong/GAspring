<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 아래 contextpath -->
<c:set var="cpath" value ="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
	  <h2>SpringMVC09</h2>
	  <div class="panel panel-default">
	    <div class="panel-heading">Board</div>
	    <div class="panel-body">Panel Content</div>
			<form id="frm" method="post">
			
				<input type="hidden" name="page" value="${cri.page}"> 
				<input type="hidden" name="perPageNum" value="${cri.perPageNum}"> 
				<!-- 검색하는 type과 keyword를 넘기기  위한 부분 -->
				<input type ="hidden" name="type" value="${cri.type}">
				<input type ="hidden" name="keyword" value="${cri.keyword}">
			
				<input id="memID" type="hidden" name="memID" value="${mvo.memID}">
				<input id="idx"type="hidden" name="idx" value="${vo.idx}">
				
				
				<div class="form-group">
					<label>제목</label>
					<input id="title" value="<c:out value="${vo.title}" />" type="text" name="title" class="form-control">
				</div>

				<div class="form-group">
					<label>답변</label>
					<textarea id="content" name="content" rows="10" cols="" class="form-control"></textarea>
				</div>

				<div class="form-group">
					<label>작성자</label>
					<input id="writer" value="${mvo.memName}" readonly="readonly" type="text" name="writer" class="form-control">
				</div>
				
				<button data-btn="reply" type="button" class="btn btn-default btn-sm">답변</button>
				<button data-btn="reset" type="button" class="btn btn-default btn-sm">취소</button>
				<button data-btn="list" class="btn btn-default btn-sm">목록</button>
				
				
			</form>
	    <div class="panel-footer">Panel Content</div>
	  </div>
	</div>
	
	<script type="text/javascript">
	
	//링크처리
	$(document).ready(function(){
		$("button").on("click",function(e){
			var formData = $("#frm");
			//this는 클릭한 data-btn의 버튼명을 말함
			var btn = $(this).data("btn");
			//alert(btn);
	
			if(btn == "list"){
				formData.attr("action","${cpath}/board/List");
				formData.find("#idx").remove();
				formData.attr("method","get")
				
				formData.find("#memID").remove();
				formData.find("#title").remove();
				formData.find("#content").remove();
				formData.find("#writer").remove();
				
			}else if(btn=="reply"){
				formData.attr("action", "${cpath}/board/reply")
			}else if(btn=="reset"){
				formData[0].reset();
			//모든 버튼 클릭 시 submit이 되게 되어있어 취소를 누르더라도 등록이 되고있음.
			//아래 submit까지 가지 않고 끝내는 방법인 return 사용
				return;
				
			}
			
			//form태그를 누르면 submit이 작동되게함
			formData.submit();
			
		});
	});
		
	</script>
	
</body>
</html>