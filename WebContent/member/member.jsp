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
<article>
<h1>회원정보조회</h1>

</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<%
// String id = 세션값 가져오기
String id =(String)session.getAttribute("id");
%>

<h2>회원정보 조회</h2>
<h1>WebContent/member/member.jsp</h1>
<%

// 세션값이 없으면 loginForm.jsp 이동 
if(id==null){
	response.sendRedirect("./login.jsp");
}

// MemberDAO 객체 생성 참조변수 mdao
MemberDAO mdao=new MemberDAO();
// MemberBean mb = getMember(id) 메서드 호출
MemberBean mb=mdao.getMember(id);
%>
<form id="join">
<fieldset>
<label>아이디 : </label>
<input type="text" name="id" value="<%=mb.getId()%>" readonly><br>
<label>비밀번호 : </label>
<input type="password" name="pass" value="<%=mb.getPass()%>" readonly><br>
<label>이름 : </label>
<input type="text" name="name" value="<%=mb.getName() %>" readonly><br>
<label>회원가입일자 : </label>
<input type="text" name="reg_date" value="<%=mb.getReg_date() %>" readonly><br>
<label>나이 : </label>
<input type="text" name="age" value="<%=mb.getAge() %>" readonly><br>
<label>성별 : </label>
<input type="text" name="gender" value="<%=mb.getGender() %>" readonly><br>
<label>이메일 : </label>
<input type="text" name="email" value="<%=mb.getEmail() %>" readonly><br>		
<label>일반전화 : </label>
<input type="text" name="phone" value="<%=mb.getPhone() %>" readonly><br>
<label>휴대폰 : </label>
<input type="text" name="mobile" value="<%=mb.getMobile() %>" readonly><br>
<label>우편번호 : </label>
<input type="text" name="zip_code" value="<%=mb.getZip_code() %>" readonly><br> 
<label>주소1 : </label>
<input type="text" name="address" value="<%=mb.getAddress() %>" size=30 readonly><br>
<label>주소2 : </label>
<input type="text" name="address2" value="<%=mb.getAddress2() %>" size=30 readonly><br>

<input type="button" name="main" value="메인화면 GO" onclick="location.href='../main/main.jsp'">
<input type="button" name="update" value="회원정보수정" onclick="location.href='updateForm.jsp'">
<input type="button" name="delete" value="회원정보삭제" onclick="location.href='deleteForm.jsp'"><br>
</fieldset>
</form>
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>
