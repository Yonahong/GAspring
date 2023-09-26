<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<!-- 권한이 없음을 알리고 다시 로그인하도록 유도 -->
	
	<h2>Access Denied - You are not authorized to access this resource.</h2>
	<hr>
	<a href="${pageContext.request.contextPath}/">Back to Home Page</a>
	
</body>
</html>