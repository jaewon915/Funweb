<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더파일들어가는 곳 -->
<header>

<%
// String id = 세션값 가져오기
String id =(String)session.getAttribute("id");

//세션값 있으면    ...님  logout 
//없으면    login
if(id!=null){
	%>
	<div id="login"><a href="../member/member.jsp"><%=id %>님</a> <a href="../member/logout.jsp">logout</a></div>
	<%	
}else{
	%>
	<div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div>
	<%
}
%>


<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><img src="../images/logo.gif" width="265" height="62" alt="Fun Web"></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../company/welcome.jsp">COMPANY</a></li>
	<li><a href="../solutions/photo.jsp">사진갤러리</a></li>
	<li><a href="../center/notice.jsp">CUSTOMER CENTER</a></li>
	<li><a href="../contact/list.jsp">자료실</a></li>
</ul>
</nav>
</header>
<!-- 헤더파일들어가는 곳 -->