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
			<table class = "table table-bordered table-hover">
				<tr>
					<td>번호</td>
					<td>${vo.idx }</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>${vo.title }</td>
				</tr>
				<tr>
					<td>내용</td>
					<td><!-- 게시글의 줄바꿈을 적용위해 textarea 사용 -->
						<textarea class="form-control" readonly="readonly" rows="10" cols="">${vo.content}</textarea>
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td>${vo.writer }</td>
				</tr>
			
			</table>	    
	    <div class="panel-footer">Panel Content</div>
	  </div>
	</div>
	
	<script type="text/javascript">
		
	</script>
	
</body>
</html>