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
	    <div class="panel-heading">
	    	<c:if test="${empty mvo}">
	    	
		    	<form class="form-inline" action="${cpath}/login/loginProcess" method="post">
		    		<div class="form-group">
						<label for="id">ID:</label>
						<input type="text" class="form-control" id="id" name="memID">
		    		</div>
		    		
		    		<div class="form-group">
						<label for="pwd">Password:</label>
						<input type="password" class="form-control" id="pwd" name="memPwd">
		    		</div>
		    		
		    		<button type="submit" class="btn btn-default">로그인</button>
		    	</form>
			</c:if>	
			
			<c:if test="${not empty mvo}">
				
				<form class="form-inline" action="${cpath}/login/logoutProcess" method="post">
					<div class="form-group">
						<label>${mvo.memName }님 방문 환영환영</label>
					</div>
					<button type="submit" class="btn btn-default">로그아웃</button>		
				</form>
					
			</c:if>
			
	    </div>
	    <div class="panel-body">Panel Content</div>
	    <table class ="table table-bordered table-hover">
	    	<thead>
	    		<tr>
	    			<th>번호</th>
	    			<th>제목</th>
	    			<th>작성자</th>
	    			<th>작성일</th>
	    			<th>조회수</th>
	    		</tr>
	    	</thead>
	    	
	    	<tbody>

		    	<c:forEach items="${List}" var="vo" varStatus="i" >
	    		 <tr>
	    		 	<td>${i.count}</td>
	    		 	<td>
	    		 	
	    		 	<!-- 삭제된 게시글 -->
	    		 	<c:if test="${vo.boardAvailable == 0}">
	    		 		<a href="javascript:alert('삭제된 게시글입니다.)">
		    		 	<c:if test="${vo.boardLevel > 0}">
		    		 		<c:forEach begin="0" end="${vo.boardLevel}" step="1">
		    		 			<span style="padding-left: 15px"> </span>
		    		 		</c:forEach>
		    		 		ㄴ[RE]
		    		 	</c:if>
	    		 		
	    		 		
	    		 		삭제된 게시물입니다.
	    		 		</a>
	    		 	</c:if>
	    		 	
	    		 	<c:if test="${vo.boardAvailable > 0}">
	    		 	<a href="${cpath}/board/get?idx=${vo.idx}">
	    		 	<!-- 게시글 및 댓글 출력부 -->
		    		 	<c:if test="${vo.boardLevel > 0}">
		    		 		<c:forEach begin="0" end="${vo.boardLevel}" step="1">
		    		 			<span style="padding-left: 15px"> </span>
		    		 		</c:forEach>
		    		 		ㄴ[RE]
		    		 	</c:if>
		    		 	<!-- 스크립트를 태그가 아닌 문자로 받음 -->
    		 			<c:out value="${vo.title}" />	
		    		 	</a>
    		 		</c:if>
    		 		
	    		 	</td>
	    		 	<td>${vo.writer}</td>
	    		 	<td>
						<fmt:formatDate value="${vo.indate}" pattern="yyyy-MM-dd"/>
					</td>
	    		 	<td>${vo.count}</td>
	    		 	
	    		 </tr>
	    		</c:forEach>
	    	</tbody>
	    	<c:if test="${not empty mvo}">
		    	<tr>
		    		<td colspan="5"> 
		    			<button id="regBtn" class="btn btn-xs btn-info pull-right">글쓰기</button>
		    		</td>
		    	</tr>
	    	</c:if>
	    </table>
	    
	    
	    <div class="panel-footer">Panel Content</div>
	  </div>
	</div>
	
	
	  <!-- Modal 어디에 있어도 상관없지. -->
	  <div class="modal fade" id="myMessage" role="dialog">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div id="messageType" class="modal-content">
	        <div class="modal-header panel-heading">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <!-- 컨트롤러에서 받아오는 msgType를 사용 -->
	          <h4 class="modal-title">${msgType}</h4>
	        </div>
	        <div class="modal-body">
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        </div>
	      </div>
	    </div>
	  </div>
		
		
	
	
	<script type="text/javascript">
		
		$(document).ready(function(){
			
			var result = "${result}";
			checkModal(result);
			
			$("#regBtn").click(function(){
				location.href="${cpath}/board/register";						
			});
			
		});
	
		function checkModal(result){
			if (result == ''){
				return;
			}
			
			if (parseInt(result) > 0){
				$(".modal-body").text("게시글" + result + "번이 등록되었습니다.")
				$("#myMessage").modal("show");
			}
		}
		
	</script>
	
</body>
</html>