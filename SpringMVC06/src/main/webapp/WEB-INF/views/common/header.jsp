<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- context-path 값을 내장 객체 변수로 저장 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!-- spring security에서 제공하는 태그라이브러리 -->
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<!-- spring security에서 제공하는 계정정보 (SecurityContext) 안의 계정정보 가져오기 -->
<!-- 로그인 한 계정정보 맴버유저디테일의 memberusermvo를 가져온것임 -->

<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/>

<!-- 권한정보 호출 -->
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/>

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
      <!-- 보안처리를 하면서 추가된 taglib(상단에 있음) security를 사용함 -->
      <security:authorize access="isAnonymous()">
      <ul class="nav navbar-nav navbar-right">
	        <li><a href="${contextPath}/loginForm.do"><span class="glyphicon glyphicon-log-in">로그인</span></a></li>
	        <li><a href="${contextPath}/joinForm.do"><span class="glyphicon glyphicon-user">회원가입</span></a></li>
      </ul>
      </security:authorize>
      
      <!-- 로그인시에는 보여주지 않기 is authenticated는 로그인 여부를 판별해줌 -->
      <security:authorize access="isAuthenticated()">
      <ul class="nav navbar-nav navbar-right">
      
      		<!-- 프로필 이미지 띄워주기 -->
      		<!-- 아래는 memberuser.java에서 그 안의 맴버메소드. 그 안의 프로필을 가져오는 코드임 -->
     		<li>
     			<c:if test="${mvo.member.memProfile ne ''}">
     				<img class="img-circle" style="width: 50px; height: 50px;" src="${contextPath}/resources/upload/${mvo.member.memProfile}">
     				
     			</c:if>
     			
     			<c:if test="${mvo.member.memProfile eq ''}">
     				<img class="img-circle" style="width: 50px; height: 50px;" src="${contextPath}/resources/images/defaultpro.png">
     			</c:if>
     			
     			${mvo.member.memName}님 반갑습니다.
     			[
     				<security:authorize access="hasRole('ROLE_USER')">
     				U
     				</security:authorize>
     				<security:authorize access="hasRole('ROLE_MANAGER')">
     				M
     				</security:authorize>
     				<security:authorize access="hasRole('ROLE_ADMIN')">
     				A
     				</security:authorize>
     			
					<!-- 권한 정보 표기창.-->     			
					<!-- 가진 권한리스트의 수만큼 반복하며 출력.-->
					<%--<c:forEach items="${mvo.authList}" var="auth">
						<c:choose>
							<c:when test="${auth.auth eq 'ROLE_USER'}">
								U
							</c:when>
							<c:when test="${auth.auth eq 'ROLE_MANAGER'}">
								M
							</c:when>
							<c:when test="${auth.auth eq 'ROLE_ADMIN'}">
								A
							</c:when>
						</c:choose>
					</c:forEach>     	 --%>		
     			
     			]
     		</li>
	        <li><a href="${contextPath}/updateForm.do"><span class="glyphicon glyphicon-wrench">회원정보수정</span></a></li>
	        <li><a href="${contextPath}/imageForm.do"><span class="glyphicon glyphicon-camera">프로필사진등록</span></a></li>
	        <!-- 아래는 자바스크립트의 로그아웃 기능을 실행하겠다는 href -->
	        <li><a href="javascript:logout()"><span class="glyphicon glyphicon-log-out">로그아웃</span></a></li>
      </ul>
      
     </security:authorize>
      
      
    </div>
  </div>
</nav>

<script type="text/javascript">
	//토큰값 가져오기 (CSRF)
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	function logout(){
		$.ajax({
			url : "${contextPath}/logout",
			//위는 이전과 동일하게 로그아웃처리 진행하는 코드이지만
			//아래의 타입(방식)을 post방식으로 하면 시큐리티의 로그아웃을 진행한다.
			type : "post",
			beforeSend : function(xhr){
				//실행할때 가장 위쪽에서 실행되는 부분 beforesend
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			
			
			},
			success : function(){
				//성공 시 페이지로 돌아오며 새로고침이 되어야한다. location 사용
				location.href = "${contextPath}/"
			},
			error : function(){
				alert("error");
			}
		});
	}
</script>


</body>
</html>