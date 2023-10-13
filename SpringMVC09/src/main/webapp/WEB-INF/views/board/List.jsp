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
	    		 		<a href="javascript:alert('삭제된 게시글입니다.')">
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
	    		 	<a class="move" href="${vo.idx}">
	    		 	
	    		 	<!-- 게시글 및 댓글 출력부 -->
		    		 	<c:if test="${vo.boardLevel > 0}">
		    		 		<c:forEach begin="0" end="${vo.boardLevel}" step="1">
		    		 			<span style="padding-left: 15px"></span>
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
	    
	    <!-- 검색기능 -->
	    <div style="text-align: center;">
	    	<form class="form-inline" action="${cpath}/board/List" method="post">
	    		<div class="form-group">
					<select name="type" class="form-control">
						<option value="writer">이름</option>
						<option value="title">제목</option>
						<option value="content">내용</option>
					</select>	    		
	    		</div>
				<div class="form-group">
					<input type="text" class="form-control" name="keyword">
				</div>
				<button type="submit" class="btn btn-success">검색</button>
	    	</form>
	    </div>
	    
	    
	    
	    
	    <div style="text-align:center;">
		  <ul class="pagination">
			
			<!-- 이전버튼처리 -->			
			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous">
					<a href="${pageMaker.startPage - 1}">←</a>
				</li>
			</c:if>
			
			
			<!-- 페이지 번호처리 -->
			<c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			
				<c:if test="${pageMaker.cri.page == pageNum}">
					<li class="paginate_button active"><a href="${pageNum}">${pageNum}</a></li>
				</c:if>
				
				<c:if test="${pageMaker.cri.page != pageNum}">
					<li class="paginate_button"><a href="${pageNum}">${pageNum}</a></li>
				</c:if>
			</c:forEach>

			<!-- 다음버튼처리 -->
			<c:if test="${pageMaker.next}">
				<li class="paginate_button previous">
					<a href="${pageMaker.endPage + 1}">→</a>
				</li>
			</c:if>
		  </ul>
			
			<!-- 이전,다음버튼의 경로처리를 위한 form태그 a태그에는 숫자만 넣고 form태그를 통해 작동시켜 중복을 제거하는식 -->
			<form action="${cpath}/board/List" id="pageFrm">
				<input type ="hidden" id="page" name="page" value="${pageMaker.cri.page}">
				<input type ="hidden" id="perPageNum" name="perPageNum" value="${pageMaker.cri.perPageNum}">
			</form> 
			
		</div>
	    
	    
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
			
			//페이지 번호 클릭 시 이동하기
			var pageFrm = $("#pageFrm");
			//li 태그 안의 a 태그값을 가져와서 from태그에 적용시켜 페이지를 이동함
			//클래스임으로 .을 적어주고 부모가 페이지네이트버튼인 a 태그를 클릭했을 때 함수실행
			$(".paginate_button a").on("click",function(e){
				//e->현재 클릭한 a태그 요소 자체를 말함.
				
				e.preventDefault(); //기본 a태그의 href속성 작동 막기
				var page = $(this).attr("href"); // 클릭한 a태그의 href값 가져오기
				pageFrm.find("#page").val(page);
				pageFrm.submit();
				
			});
			
			//상세보기 클릭 시 이동
			$(".move").on("click",function(e){
				e.preventDefault();
				var idx = $(this).attr("href");//클릭한 해당 a태그(여기서는 move)의 속성(attr)중 href를 가져올것임
				var tag = "<input type = 'hidden' name='idx' value='"+idx+"'>"
				pageFrm.append(tag);
				pageFrm.attr("action", "${cpath}/board/get");
				pageFrm.submit();
			});
			
			
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