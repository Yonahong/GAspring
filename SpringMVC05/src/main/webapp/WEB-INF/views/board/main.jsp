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
	<jsp:include page="../common/header.jsp"></jsp:include>
	  <h2>SpringMVC05</h2>
	  <div class="panel panel-default">
	    <div class="panel-heading">성철성철성철성철성철성철성철성철성철성철성철성철성철성철성철</div>
	    <div class="panel-body">성철성철성철성철성철성철성철성철성철성철성철성철성철성철성철
	    
    		<table id="boardList" class ="table table-bordered table-hover">
	    		<tr class="active">
					<td>번호</td>	    		
					<td>제목</td>	    		
					<td>작성자</td>	    		
					<td>작성일</td>	    		
					<td>조회수</td>	
					    		
	    		</tr>
	    		
	    		<tbody id='view'>
	    		<!-- 테이블의 몸통을 구성하는 별 기능은 없는 tbody태그 안에
	    		비동기 방식으로 가져온 게시글을 나오게 할것임 , 아래에 script에서 목록불러오기 함수를 만들것임
	    		-->
	    		<!-- 테이블의 구역을 구분하여 일정 부분에만 태그를 적용하려는 등의 용도로 테이블을 나눔 -->
	    		
	    		
	    		
	    		
	    		</tbody>
	    		<c:if test="${not empty mvo}">
		    		<tr>
		    			<td colspan="5">
		    				<button onclick ="goForm()" class = " btn btn-primary btn-sm">글쓰기</button>
		    			</td>
		    		</tr>
	    		</c:if>
	    	</table>
	    </div>
	    
	    <!-- 글쓰기 폼은 테이블을 감싸고있는 div 바깥에.
	    보드 form 구조와 같음 -->
		<div class="panel-body" id="wform" style="display : none;">
		<!-- 폼태그는 동기방식임으로 폼태그를 삭제한다. -->
			<form id="frm">
			<input type="hidden" name="memID" value="${mvo.memID}">
	    	<table class="table">
	    	
	    		<tr>
		    		<td>제목</td>
		    		<td><input type="text" name="title" class="form-control"></td>
	    		</tr>
	    		
	    		<tr>
		    		<td>내용</td>
		    		<td><textarea rows="7" name="content" class="form-control" cols=""></textarea></td>
	    		</tr>
	    		
	    		<tr>
		    		<td>작성자</td>
		    		<td><input readonly="readonly" value="${mvo.memName}" type="text" name="writer" class="form-control"></td>
	    		</tr>
	    		
	    		<tr>
	    			<td colspan="2" align="center">
	    				<!-- 버튼의 type ="submit"은 폼태그로 이동을 하는역할을 하기때문에 타입을 버튼으로 해준다
	    				그리고 온클릭 이벤트를 주고 함수를 실행하도록한다. -->
	    				<button  class="btn btn-success btn-sm" type="button" onclick="goInsert()">등록</button>
	    				<button class="btn btn-warning btn-sm" type="reset" id = "fclear">취소</button>
	    				<!-- 비동기방식(한페이지에서 모두 처리)이기때문에 a태그로 이동을 하지않고 버튼의 온클릭이벤트로 함수를 실행해준다.-->
	    				<button onclick="goList()" class="btn btn-info btn-sm">목록</button>
	    			</td>
	    		</tr>
	    		
	    	</table>
	  	  	</form>	
		
		
		</div>
	    <div class="panel-footer">성철성철성철성철성철성철성철성철성철성철성철성철성철성철성철</div>
	  </div>
	</div>
	
	<script type="text/javascript">
	
		//ajax에서도 post방식으로 데이터 전송하기 위해선
		//csrf token값을 전달해야한다
		//token의 이름과 값을 가져오기
		//ajax에서 csrf의 이름을 사용할 때에는 parameterName이 아니라 headerName을 사용함.
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}"; // 값
	
		$(document).ready(function(){
			//html이 다 로딩되고 나서 아래의 코드를 실행하겠다는 코드
			loadList();
		});
	
		//게시글 가져오는 함수
		function loadList(){
			//비동기방식으로 게시글 리스트 가져오기 기능
			//부트스트랩에 있는 ajax 쓸것임
			//ajax에 요청 url, 어떻게 데이터를 받을지, 요청 방식등을 객체 형식으로 가져옴
			$.ajax({
				//요청url
				url : "board/all",
				//어떻게 받을것인지
				type : "get",
				//요청할 데이터의 타입
				dataType : "json",
				//요청에 성공하면 실행하는 함수(콜백함수)
				success : makeView,
				//실패했을 때 함수
				error :function() {alert("error");}
			});
		}
		function makeView(data){
			//서버로부터 비동식 통신 후 성공했을때 실행되는 makeview임으로 위 소괄호 매개변수로 받아온다
			console.log(data);
			
			var listHtml ="";
			
			//자바스크립트는 for 문을 반복문으로 시작하는데
			//j쿼리는 항상 $로 시작하는데 $.each(데이터,한번 반복마다 실행해줄 기능(펑션){반복의회차,obj데이터배열한열씩담김}); 반복문 사용
			$.each(data,function(index,obj){
				listHtml += "<tr>";
				listHtml += "<td>" + (index + 1) + "</td>";
				listHtml += "<td id ='t" + obj.idx + "'>";
				listHtml += "<a href='javascript:goContent("+obj.idx+")'>";
				listHtml += obj.title;
				listHtml += "</a>";
				listHtml += "</td>";
				listHtml += "<td id ='w" + obj.idx +"'>" + obj.writer + "</td>";
				listHtml += "<td>" + obj.indate + "</td>";
				listHtml += "<td>" + obj.count + "</td>";
				listHtml += "</tr>";
				
				//상세보기 화면
				//글의 내용을 아래에 표시해줌
				//tr에 id를 부여해서 해당 글이 클릭 시 보여지도록 함
				listHtml += "<tr id='c"+obj.idx+"' style='display : none'>";
				listHtml += "<td>내용</td>";
				listHtml += "<td colspan='4'>";
				listHtml += "<textarea id='ta" + obj.idx + "' readonly rows='7' class='form-control'>";
				//listHtml += obj.content;
				listHtml += "</textarea>";
				
				//수정 삭제 화면
				//조건문 안에서 EL식을 쓰고싶다면 문자열로 감싸줘야함
				//1개 게시글 안의 모든 정보가 담겨있는 obj에서 memid를 사용
				if("${mvo.memID}" == obj.memID){
				listHtml += "<br>";
				listHtml += "<span id='ub"+obj.idx+"'>";
				listHtml += "<button onclick='goUpdateForm(" + obj.idx + ")' class='btn btn-sm btn-success'>수정화면</button></span> &nbsp;"
				listHtml += "<button onclick='goDelete(" + obj.idx + ")' class='btn btn-sm btn-warning'>삭제</button> &nbsp;"
				}else{
					listHtml += "<br>";
					listHtml += "<span id='ub"+obj.idx+"'>";
					listHtml += "<button disabled onclick='goUpdateForm(" + obj.idx + ")' class='btn btn-sm btn-success'>수정화면</button></span> &nbsp;"
					listHtml += "<button disabled onclick='goDelete(" + obj.idx + ")' class='btn btn-sm btn-warning'>삭제</button> &nbsp;"
					}
				
				
				listHtml += "</td>";
				listHtml += "</tr>";
				
				
			});
			
			//j쿼리 2개 넣을건데 
			
			
			
			$("#view").html(listHtml);
			
			goList();
			
		}
		
		function goForm(){
			//goForm 함수를 만들어서 view는 감추고 wform은 보이게 하시오
		
		    // view를 감춘다.
		    //$("#boardList").hide();
		    $("#boardList").css("display", "none");
		    // wform을 보인다.
		    //$("#wform").show();
		    $("#wform").css("display", "block" )
		}
		
		function goList(){
			//goForm 함수를 만들어서 view는 감추고 wform은 보이게 하시오
		
		    // view를 감춘다.
		    //$("#boardList").show();
		    $("#boardList").css("display", "block");
		    // wform을 보인다.
		    //$("#wform").hide();
		    $("#wform").css("display", "none" );
		}
		
	
		function goInsert(){
			//비동기방식의 글쓰기를 하기 위해 컨텐츠, 라이터, 타이틀값을 가져오는데 이 3가지의 input태그 값을 가져오는 내용을 적어야하는데
			//3개의 내용을 감싸고있는 form태그에 id를 줘서 해당 폼을 id값을 통해 가져온다
			//아래는 해당 3개의 내용을 직렬화(한줄로 get방식과 비슷한)(시리얼) 방식으로 가져온다
			//ex)title="하이"&content="반가워"&writer="방가맨"
			var fData = $("#frm").serialize();
			//console.log()
			
			$.ajax({
				url : "board/new",
				type : "post",
				data : fData,
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success: loadList,
				error: function(){alert("error");}
			})
			
			$("#fclear").trigger("click");
			
		}
		
		function goContent(idx){
			
			//if문은 열어주는부분
			if($("#c"+idx).css("display") == "none"){
				
				$.ajax({
					//게시글을 보려할때 해당 게시글의 json을 받아와
					//보여줄것임.
					url : "board/"+idx,
					type : "get",
					data : "json",
					success : function(data){
						$("#ta"+idx).val(data.content);
					},
					error : function() {alert("error");}
				});
				
				
				$("#c"+idx).css("display","table-row");				
				
			}else{
				//else문은 닫아주는 부분
				$("#c"+idx).css("display","none");
				//boardCount.do로 요청해서 조회수를 1 올리고
				//게시글을 다시 불러와 적용시키시오
				$.ajax({
					url : "board/count/"+idx,
					//경로에 슬래쉬를 하고 값을 보내주는 방식 - 패쓰 베리어블 path variable - url 간편화
					type : "put",
					beforeSend : function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					success : loadList,
					error : function() {alert("error");}
				});
			}
			
		}
		
		//해당 주소를 그대로 넣어서 외부의 오접근을 막을것임
		//타입을 delete로 해줄것인데 delete 타입은 
		//해당 서버에서만 접근이 됨
		function goDelete(idx){
			$.ajax({
				url : "board/" + idx,
				type : "delete",//delete는 post방식의 하위방식이다.
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : {"idx" : idx},
				success : loadList, 
				error : function(){alert("error");}
			});
		}
		
		//function goUpdateForm(idx){
			
		//	$("#ta" + idx).attr("readonly", false);
			
		//	var title = $("#t"+idx).text();
		//	var newTitle = "<input id='nt"+idx+"' value='" + title + "'type='text' class='form-control'>"
		//	$("#t"+idx).html(newTitle);
		
		//	var writer = $("#w"+idx).text();
		//	var newWriter = "<input id='nw"+idx+"' value='" + writer + "'type='text' class='form-control'>"
		//	$("#w"+idx).html(newWriter);
		
		//	var newBtn = "<button onclick='goUpdate("+idx+")' class='btn btn-primary btn-sm'>수정</button>"
		//	$("#ub"+idx).html(newBtn);
			
		//}
		
		function goUpdateForm(idx){
         
         $("#ta" + idx).attr("readonly", false);
         
         var title = $("#t" + idx).text();
         var newTitle = "<input id='nt"+idx+"' value='" + title + "' type='text' class='form-control' >";
         $("#t" + idx).html(newTitle);
         
         var writer = $("#w" + idx).text();
         var newWriter = "<input id='nw"+idx+"' value='" + writer + "' type='text' class='form-control' >";
         $("#w" + idx).html(newWriter);
         
         var newBtn = "<button onclick='goUpdate("+idx+")' class='btn btn-primary btn-sm'>수정</button>";
         $("#ub" + idx).html(newBtn);
         
      }
		
		function goUpdate(idx){
			
			var title =$("#nt" + idx).val();
			var content =$("#ta" + idx).val();
			var writer =$("#nw" + idx).val();
			
			console.log(title+"/"+content+"/"+writer);
			
			//boardUpdate.do로 요청을 통해 게시글을 수정하고
			//수정된 게시글 다시 불러와서 적용(숙제)
			
			$.ajax({
				url : "board/update",
				type : "put",
				contentType : "application/json;charset=utf-8",
				//put방식으로 하면 json을 객체가 아닌 문자열로 바꿔서 보내줘야함
				data : JSON.stringify({"idx" : idx, "title" : title, "content" : content, "writer" : writer}),
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : loadList,
				error : function() {alert("error");}
				
			});
			
			
		}		
		
		
	</script>
	
</body>
</html>