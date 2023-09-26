<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	    <div class="panel-heading">글쓰기할꺼야?글쓰기할꺼야?글쓰기할꺼야?글쓰기할꺼야?글쓰기할꺼야?글쓰기할꺼야?</div>
	    <div class="panel-body">
			<form action="../boardUpdate.do" method="post">
			<input type="hidden" name="idx" value="${vo.idx}">
	    	<table class="table">
	    	
   					<!-- boardcontent를 가져와서 5곳을 수정해줄것임
   					액션에 이름, 제목,내용,작성자에 vo.~~~를 가져와서 보여줌, 버튼이름수정 -->
   					<!-- 여기에서 보드업데이트.두로 갈것인데 저쪽으로 갈 떄 idx값을 줘야 수정을 적용함으로
   					idx값을 보내야함. 사용자에게 안보이게 폼태그 안에 hidden이라는 태그로 보내줄것임 -->
	    			<!-- 아래에 기존에 써져있던 글을 입력해줘놓을것임 그걸 보고 수정하게 -->
	    			
	    			<!-- boardupdate.do 요청을 하게 되면
	    			idx와 일치하는 게시글을 입력한 정보로 수정하고 게시글 목록페이지로 이동
	    			 -->
	    		<tr>
		    		<td>제목</td>
		    		<td><input value="${vo.title}" type="text" name="title" class="form-control"></td>
	    		</tr>
	    		
	    		<tr>
		    		<td>내용</td>
		    		<td><textarea row="7" name="content" class="form-control" cols="">${vo.content}</textarea></td>
	    		</tr>
	    		
	    		<tr>
		    		<td>작성자</td>
		    		<td><input value="${vo.writer}" type="text" name="writer" class="form-control"></td>
	    		</tr>
	    		
	    		<tr>
	    			<td colspan="2" align="center">
	    				<button class="btn btn-success btn-sm" type="submit">수정</button>
	    				<button class="btn btn-warning btn-sm" type="reset">취소</button>
	    				<a href="../boardList.do" class="btn btn-info btn-sm">목록</a>
	    			</td>
	    		</tr>
	    		
	    	</table>
	  	  </form>	
	    </div>
	    
	    <div class="panel-footer">글을 쓸거야?글을 쓸거야?글을 쓸거야?글을 쓸거야?글을 쓸거야?글을 쓸거야?</div>
	  </div>
	</div>
</body>
</html>