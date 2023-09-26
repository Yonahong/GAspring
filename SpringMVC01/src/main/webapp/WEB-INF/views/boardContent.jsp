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
	<% pageContext.setAttribute("newLineChar", "\n"); %>
	<div class="container">
	  <h2>SpringMVC01</h2>
	  <div class="panel panel-default">
	    <div class="panel-heading">글쓰기할꺼야?글쓰기할꺼야?글쓰기할꺼야?글쓰기할꺼야?글쓰기할꺼야?글쓰기할꺼야?</div>
	    <div class="panel-body">
	    	<table class="table">
	    	
	    	<!-- 모델에 있는 게시글에 대한 값을 EL식으로 가져온다 -->
	    		<tr>
		    		<td>제목</td>
		    		<td>${vo.title }</td>
	    		</tr>
	    		
	    		<tr>
		    		<td>내용</td>
		    		<td>
		    		<!-- vo 안에 컨텐츠를 가져올건데 위에 설정한 \n이 발견된다면
		    		br태그를 넣어줄것임 -->
		    			${fn:replace( vo.content, newLineChar,"<br>" ) }
		    		</td>
	    		</tr>
	    		
	    		<tr>
		    		<td>작성자</td>
		    		<td>${vo.writer }</td>
	    		</tr>
	    		
	    		<tr>
		    		<td>작성일</td>
		    		
		    		<td>
		    		<!-- 날짜에서 시간 앞에 있는 스페이스바(" ") 기준으로 떼어주고
		    		앞의 시간, 0번째 있는 값만 표기할것이다 -->
		    			${fn:split(vo.indate," ")[0] }
		    		</td>
	    		</tr>
	    		
	    		<tr>
	    			<td colspan="2" align="center">
	    				<a href="../boardUpdateForm.do/${vo.idx}"class="btn btn-success btn-sm" >수정</a>
	    				<!-- 글을 삭제하려면 고유값인 idx를 보내준다 -->
	    				<!-- 과제 : 게시글을 삭제하고 게시글목록으로 이동하시오 -->
	    				<a href="../boardDelete.do/${vo.idx}" class="btn btn-warning btn-sm">삭제</a>
	    				<a href="../boardList.do" class="btn btn-info btn-sm">목록</a>
	    			</td>
	    		</tr>
	    		
	    	</table>
	  	  
	    </div>
	    
	    <div class="panel-footer">글을 쓸거야?글을 쓸거야?글을 쓸거야?글을 쓸거야?글을 쓸거야?글을 쓸거야?</div>
	  </div>
	</div>
</body>
</html>