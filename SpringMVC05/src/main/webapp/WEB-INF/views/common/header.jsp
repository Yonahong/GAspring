<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- context-path 값을 내장 객체 변수로 저장 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="${contextPath}">스프링 띠용</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="${contextPath}">메인</a></li>
        <li><a href="boardMain.do">게시판</a></li>
      </ul>
      
      <!-- 회원가입 판별하여 메뉴 표기하거나 안하기 -->
      <!-- 세션이 저장 된 mvo가 비어있을때만 메뉴를 보여주기 -->
      
      <c:if test="${empty mvo}">
      <ul class="nav navbar-nav navbar-right">
	        <li><a href="${contextPath}/loginForm.do"><span class="glyphicon glyphicon-log-in">로그인</span></a></li>
	        <li><a href="${contextPath}/joinForm.do"><span class="glyphicon glyphicon-user">회원가입</span></a></li>
      </ul>
      </c:if>
      
      <!-- 로그인시에는 보여주지 않기 -->
      <c:if test="${not empty mvo}">
      <ul class="nav navbar-nav navbar-right">
      
      		<!-- 프로필 이미지 띄워주기 -->
      		
     		<li>
     			<c:if test="${mvo.memProfile ne ''}">
     				<img class="img-circle" style="width: 50px; height: 50px;" src="${contextPath}/resources/upload/${mvo.memProfile}">
     				${mvo.memName}님 반갑습니다.
     			</c:if>
     			
     			<c:if test="${mvo.memProfile eq ''}">
     				<img class="img-circle" style="width: 50px; height: 50px;" src="${contextPath}/resources/images/defaultpro.png">
     				${mvo.memName}님 반갑습니다.
     			</c:if>
     		</li>
     		
     
	        <li><a href="${contextPath}/updateForm.do"><span class="glyphicon glyphicon-wrench">회원정보수정</span></a></li>
	        <li><a href="${contextPath}/imageForm.do"><span class="glyphicon glyphicon-camera">프로필사진등록</span></a></li>
	        <li><a href="${contextPath}/logout.do"><span class="glyphicon glyphicon-log-out">로그아웃</span></a></li>
      </ul>
      </c:if>
      
      
    </div>
  </div>
</nav>




</body>
</html>