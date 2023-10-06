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
	  <h2>SpringMVC07</h2>
	  <div class="panel panel-default">
	    <div class="panel-heading">Board</div>
	    <div class="panel-body">Panel Content</div>
	    <!-- 글을 가져오는 get -->
	    <form action="${cpath}/board/modify" method="post">
			<table class = "table table-bordered table-hover">
				<tr>
					<td>번호</td>
					<td><input readonly="readonly" value="${vo.idx}" name="idx" type="text" class="form-control"> </td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input value="${vo.title }" class="form-control" name="title" type="text"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><!-- 게시글의 줄바꿈을 적용위해 textarea 사용 -->
						<textarea name="content" class="form-control" rows="10" cols="">${vo.content}></textarea>
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input readonly="readonly" value="${vo.writer }" class="form-control" name="writer" type="text"></td>
				</tr>
			
				<tr>
					<td colspan="2" style="text-align: center;">
						
						<c:if test="${not empty mvo && mvo.memID eq vo.memID }">
							<button type="submit" class ="btn btn-sm btn-primary">수정</button>
							<button type="button" onclick="location.href='${cpath}/board/remove?idx=${vo.idx}'" class ="btn btn-sm btn-success">삭제</button>
						</c:if>
						
						<c:if test="${empty mvo or mvo.memID ne vo.memID }">
							<button disabled="disabled" type="submit" class ="btn btn-sm btn-primary">수정</button>
							<button disabled="disabled" type="button" onclick="location.href='${cpath}/board/remove?idx=${vo.idx}'" class ="btn btn-sm btn-success">삭제</button>
						</c:if>
						
						<button type="button" onclick="location.href='${cpath}/board/List'" class ="btn btn-sm btn-warning">목록</button>
					</td>
				</tr>
			</table>
		</form>
				    
	    <div class="panel-footer">Panel Content</div>
	  </div>
	</div>
	
	<script type="text/javascript">
		
	</script>
	
</body>
</html>