<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	  <h2>SpringMVC01</h2>
	  <div class="panel panel-default">
	    <div class="panel-heading">성철성철성철성철성철성철성철성철성철성철성철성철성철성철성철</div>
	    <div class="panel-body">성철성철성철성철성철성철성철성철성철성철성철성철성철성철성철
    		<table class ="table table-bordered table-hover">
	    		<tr class="active">
					<td>번호</td>	    		
					<td>제목</td>	    		
					<td>작성자</td>	    		
					<td>작성일</td>	    		
					<td>조회수</td>	    		
	    		</tr>
	    		
	    		<!--  model 안에 있는 list를 jstl을 활용하여 출력 -->
	    		<!--  model 안의 값은 어떻게 가져오나.
	    				model은 request영역 안에 있음.
	    				배열은 items로 가져와야함,
	    				
	    		 -->
	    		 <c:forEach items="${list}" var="vo" varStatus="i" >
	    		 <tr>
	    		 	<td>${i.count }</td>
	    		 	<!-- 어떤 글을 볼지에 대한 값을 서버로 줘야 서버가 해당 글을 
	    		 	보여주기때문에 겟방식으로 보내줌 -->
	    		 	
	    		 	<!-- 경로에다가 값을 보내는 방식을 path variable이라한다.
	    		 		아래 주소의 do?idx=를 단순히 / 하나로 바꿀 수 있음
	    		 		키값을 계속 설정하지 않아도 되는 장점이 있음 -->
	    		 	<td><a href="boardContent.do/${vo.idx}">${vo.title }</a></td>
	    		 	<td>${vo.writer }</td>
	    		 	<td>${fn:split(vo.indate," ")[0] }</td>
	    		 	<td>${vo.count}</td>
	    		 	
	    		 </tr>
	    		 </c:forEach>
	    		 
	    	</table>
	    	
	    	<!-- 부트스트랩을 사용해 디자인을 준것, 버튼 만들기 -->
	    	<!-- 스프링은 jsp->jsp 로 이동이 안되고 디스페쳐->컨트롤러를 통해서 이동해야함 -->
	    	<a href="boardForm.do" class="btn btn-primary btn-sm">글쓰기</a>
	    	
	    </div>
	    <div class="panel-footer">성철성철성철성철성철성철성철성철성철성철성철성철성철성철성철</div>
	  </div>
	</div>
</body>
</html>