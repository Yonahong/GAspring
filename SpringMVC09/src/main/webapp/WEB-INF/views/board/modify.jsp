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
	    <!-- 글을 가져오는 get -->
	   		<form id="frm">
	   		
			<table class = "table table-bordered table-hover">
				<tr>
					<td>번호</td>
					<td><input id="idx" readonly="readonly" value="${vo.idx}" name="idx" type="text" class="form-control"> </td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input id="title" value="<c:out value="${vo.title}" />" class="form-control" name="title" type="text"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><!-- 게시글의 줄바꿈을 적용위해 textarea 사용 -->
						<textarea id="content" name="content" class="form-control" rows="10" cols=""><c:out value="${vo.content}" /></textarea>
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input id="writer" readonly="readonly" value="${vo.writer }" class="form-control" name="writer" type="text"></td>
				</tr>
			
				<tr>
					<td colspan="2" style="text-align: center;">
						
						<c:if test="${not empty mvo && mvo.memID eq vo.memID }">
							<button data-btn="modify" type="submit" class ="btn btn-sm btn-primary">수정</button>
							<button data-btn="remove" type="button" class ="btn btn-sm btn-success">삭제</button>
						</c:if>
						
						<c:if test="${empty mvo or mvo.memID ne vo.memID }">
							<button disabled="disabled" type="submit" class ="btn btn-sm btn-primary">수정</button>
							<button disabled="disabled" type="button" class ="btn btn-sm btn-success">삭제</button>
						</c:if>
						
						<button data-btn="list" type="button" class ="btn btn-sm btn-warning">목록</button>
					</td>
				</tr>
			</table>
		
		
			<!-- form태그 안에 form태그가 들어가는 것은 지양함. -->
				
				<input type="hidden" name="page" value="${cri.page}">
				<input type="hidden" name="perPageNum" value="${perPageNum}"
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
				
				if(btn == "remove"){
					//속성을 attr을 통해서 action을 reply로 바꿔줌
					//페이지를 넘어갈때 idx값을 가지고 해당 페이지로 가야한다.
					//list로 갈때는 idx를 갖고갈 필요가 없다.
					formData.attr("action","${cpath}/board/remove");
					formData.attr("method","get")
					
					//주소창에 내용이 보이지 않도록 삭제해줌
					formData.find("#title").remove();
					formData.find("#content").remove();
					formData.find("#writer").remove();
					
				}else if(btn == "list"){
					formData.attr("action","${cpath}/board/List");
					formData.find("#idx").remove();
					formData.attr("method","get")
					
					formData.find("#title").remove();
					formData.find("#content").remove();
					formData.find("#writer").remove();
					formData.find("#idx").remove();
					
				}else if (btn == "modify"){
					formData.attr("action","${cpath}/board/modify");
					formData.attr("method","post")
				}
				
				//form태그를 누르면 submit이 작동되게함
				formData.submit();
				
			});
		});
	</script>
	
</body>
</html>