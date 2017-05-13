<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자료실 글쓰기(첨부파일추가)</title>
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
</head>
<body>
<%
//세션값 가져오기
String id = (String)session.getAttribute("id");
//세션값이 없으면 login.jsp 이동
if(id==null){
	
	response.sendRedirect("../member/login.jsp");
	
}
// 파일 업로드
// 업로드 프로그램 설치 WebContent -WEB-INF - lib -cos.jar
// www.servlets.com 다운로드
// com.oreilly.servlet 왼쪽메뉴 cos-26Dec2008.zip

// 1. 특정폴더(upload)에 파일을 넣고 디비에느 파일이름 저장
// 2. 파일을 => 디비저장

// 폼태그 시작부분 enctype="multipart/form-data" 꼭 넣어주기
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
<h2>WebContent/contact/fwriteForm.jsp</h2>
<h2>자료실 글쓰기(첨부파일추가)</h2>
<form action="fwritePro.jsp" method="post" name="fr" enctype="multipart/form-data">
<table id="notice">
<!-- 글쓴이 : <input type="text" name="name"><br>
비밀번호 : <input type="password" name="pass"><br> 
제목 : <input type="text" name="subject"><br>
파일첨부 : <input type="file" name="file"><br>
내용 : <textarea rows="10" cols="20" name="content"></textarea><br> -->
<tr><td>글쓴이</td><td><input type="text" name="name" value="<%=id%>" readonly></td></tr>
<tr><td>비밀번호</td><td><input type="password" name="pass"></td></tr>
<tr><td>제목</td><td><input type="text" name="subject"></td></tr>
<tr><td>첨부파일</td><td><input type="file" name="file"></td></tr>
<tr><td>내용</td><td><textarea rows="10" cols="20" name="content"></textarea></td></tr>
</table>

<div id="table_search">
<input type="submit" value="글쓰기" class="btn">
	<input type="reset" value="다시쓰기" class="btn">	
<input type="button" value="글목록" class="btn" 
       onclick="location.href='list.jsp'">
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