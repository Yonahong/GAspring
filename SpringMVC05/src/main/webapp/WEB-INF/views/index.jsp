<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!-- 아래 3줄의 코드는 절대경로를 선택할 때 필요함. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- context-path 값을 내장 객체 변수로 저장 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    
    
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>



<div class="container">
	<jsp:include page="common/header.jsp"></jsp:include>
	  <h3>Spring MVC05</h3>
	  <div class="panel panel-default">
	  	<div>
	  		<img style="width:50% height:400px;" src="${contextPath}/resources/images/main.jpg">
	  	</div>
	  	<div>
	  		<ul class="nav nav-tabs">
		    <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
		    <li><a data-toggle="tab" href="#menu1">게시판</a></li>
		    <li><a data-toggle="tab" href="#menu2">공지사항</a></li>
		    <li><a data-toggle="tab" href="#menu3">Menu 3</a></li>
			  </ul>
			
			  <div class="tab-content">
			    <div id="home" class="tab-pane fade in active">
			      <h3>HOME</h3>
			      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
			    </div>
			    <div id="menu1" class="tab-pane fade">
			      <h3>게시판</h3>
			      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
			    </div>
			    <div id="menu2" class="tab-pane fade">
			      <h3>공지사항</h3>
			      <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
			    </div>
			    <div id="menu3" class="tab-pane fade">
			      <h3>Menu 3</h3>
			      <p>Eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
			    </div>
			  </div>
		  	</div>
	  	<div class="panel-footer">
	  		Tomorrow's too late, accept Him today
	  	</div>
			  
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
        <!-- 아래의 p태그 안에 상황에 따라 달라지는 메시지 작성 -->
          <p id="">${msg}</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

	<script type="text/javascript">
	//페이지 로딩이 되고나서 실행할것.
	$(document).ready(function(){
		if(${not empty msgType}){
			if(${msgType eq "성공메세지" }){
				$("#messageType").attr("class","modal-content panel-success");
			}
			$("#myMessage").modal("show");
		}
	});
	
	</script>

</body>
</html>
