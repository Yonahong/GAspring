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
			<form action="${cpath}/board/register" method="post">
			
			<!-- post방식의 register 요청이 들어왔을 때
			BoardController에서는 BoardService의 register 메소드를 통해서
			게시글 입력 기능을 수행하고 list.jsp로 이동 -->
			
			
			
				<input type="hidden" name="memID" value="${mvo.memID}"
				
				<div class="form-group">
					<label>제목</label>
					<input type="text" name="title" class="form-control">
				</div>

				<div class="form-group">
					<label>내용</label>
					<textarea name="content" rows="10" cols="" class="form-control"></textarea>
				</div>

				<div class="form-group">
					<label>작성자</label>
					<input value="${mvo.memName}" readonly="readonly" type="text" name="writer" class="form-control">
				</div>
				
				
				
				<button type="submit" class="btn btn-default btn-sm">등록</button>
				<button type="reset" class="btn btn-default btn-sm">취소</button>
				
				
			</form>

	    
	    <div class="panel-footer">Panel Content</div>
	  </div>
	</div>
	
	<script type="text/javascript">
		
	</script>
	
</body>
</html>