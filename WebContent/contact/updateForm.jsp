<%@page import="data_room.Data_roomBean"%>
<%@page import="data_room.Data_roomDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->

<script type="text/javascript">
function check2(){
	if(document.fr.pass.value==""){
		//비밀번호를 입력하세요. 커서 깜박 되돌아가기
		alert("비밀번호를 입력하세요");
		document.fr.pass.focus();
		return false;
	}	
}
</script>
</head>
<body>
<%

//세션값 가져오기
String id = (String)session.getAttribute("id");
//세션값이 없으면 login.jsp 이동
if(id==null){
	
	response.sendRedirect("../member/login.jsp");
	
}

//int num String pageNum 파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

//Data_roomDAO drdao 객체수정
Data_roomDAO drdao= new Data_roomDAO();
//Data_roomBean drb = 메서드호출 getData_room(num)
Data_roomBean drb = drdao.getData_room(num);

%>

<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더파일들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->

<nav id="sub_menu">
<ul>
<li><a href="../center/notice.jsp">Notice</a></li>
<li><a href="#">Public News</a></li>
<li><a href="../center/fnotice.jsp">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->

<article>

<h1>WebContent/board/updateForm.jsp</h1>
<h1>게시판 글수정</h1>
<form action="updatePro.jsp?pageNum=<%=pageNum %>" method="post" name="fr" onsubmit="return check2()" enctype="multipart/form-data">

<%--        <input type="hidden" name="num" value="<%=num %>">
글쓴이 : <input type="text" name="name" value="<%=drb.getName()%>"><br>
비밀번호 : <input type="password" name="pass"><br> 
제목 : <input type="text" name="subject" value="<%=drb.getSubject() %>"><br>
내용 : <textarea rows="10" cols="20" name="content"><%=drb.getContent() %></textarea><br> --%>

<input type="hidden" name="num" value="<%=num %>">
<table>
<tr><td>글쓴이</td><td><input type="text" name="name" value="<%=id%>" readonly></td></tr>
<tr><td>비밀번호</td><td><input type="password" name="pass"></td></tr>
<tr><td>제목</td><td><input type="text" name="subject" value="<%=drb.getSubject()%>"></td></tr>
<tr><td>첨부파일</td><td><input type="file" name="file" value="<%=drb.getFile()%>"></td></tr>
<tr><td>내용</td><td><textarea rows="10" cols="20" name="content"><%=drb.getContent()%></textarea></td></tr>
</table>



<div id="table_search">
<input type="submit" value="글수정" class="btn">	
<input type="reset" value="다시쓰기" class="btn">	
<input type="button" value="글목록" class="btn" 
       onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">	
       
       
</div>


</form>


<div class="clear"></div>
<div id="page_control">

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>