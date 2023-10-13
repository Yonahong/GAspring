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
			<table class = "table table-bordered table-hover">
				<tr>
					<td>번호</td>
					<td>${vo.idx }</td>
				</tr>
				<tr>
					<td>제목</td>
					<td><c:out value="${vo.title}" /></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><!-- 게시글의 줄바꿈을 적용위해 textarea 사용 -->
						<textarea class="form-control" readonly="readonly" rows="10" cols=""><c:out value="${vo.content}" /></textarea>
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td>${vo.writer }</td>
				</tr>
			
				<tr>
					<td colspan="2" style="text-align: center;">
						<!-- 아래 c:if는 게시글 수정관련권한설정 -->
						<c:if test="${not empty mvo}">
							<button data-btn="reply" class ="btn btn-sm btn-primary">답글</button>
							<button data-btn="modify" class ="btn btn-sm btn-success">수정</button>
						</c:if>
						
						<c:if test="${empty mvo}">
							<button disabled="disabled" class = "btn btn-sm btn-primary">답글</button>
							<button disabled="disabled" class = "btn btn-sm btn-success">수정</button>
						</c:if>

						<button data-btn="list" class ="btn btn-sm btn-warning">목록</button>
					
					</td>
				</tr>
			</table>	    
			
			<form id="frm" method="get" action="">
				<input id="idx" type="hidden" name="idx" value="${vo.idx}">
				<input type="hidden" name="page" value="${cri.page}">
				<input type="hidden" name="perPageNum" value="${perPageNum}"
			</form>
			
		</div>	
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
				
				if(btn == "reply"){
					//속성을 attr을 통해서 action을 reply로 바꿔줌
					//페이지를 넘어갈때 idx값을 가지고 해당 페이지로 가야한다.
					//list로 갈때는 idx를 갖고갈 필요가 없다.
					formData.attr("action","${cpath}/board/reply");
				}else if(btn == "modify"){
					formData.attr("action","${cpath}/board/modify");
				}else if(btn == "list"){
					formData.attr("action","${cpath}/board/List");
					formData.find("#idx").remove();
				}
				
				//form태그를 누르면 submit이 작동되게함
				formData.submit();
				
			});
		});
	</script>
	
</body>
</html>