<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
function fun_pass(){
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
<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더파일들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<%
// 세션값 가져오기
String id =(String)session.getAttribute("id");
// 세션값 없으면 loginForm.jsp 이동
if(id==null){
	response.sendRedirect("./login.jsp");
}
%> 
<article>
<h2>회원정보 삭제</h2>
<h1>WebContent/member/deleteForm.jsp</h1>

<form action="deletePro.jsp" method="post" name="fr" id="join" onsubmit="return fun_pass()" >
<fieldset>
<label>아이디 : </label>
<input type="text" name="id" value="<%=id %>" readonly><br>
<label>비밀번호 : </label>
<input type="password" name="pass" ><br>

<input type="button" name="main" value="메인화면 GO" onclick="location.href='../main/main.jsp'">
<input type="button" name="update" value="회원정보수정" onclick="location.href='updateForm.jsp'">
<input type="submit" name="delete" value="회원정보삭제" onclick="location.href='deleteForm.jsp'"><br>
</fieldset>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>
