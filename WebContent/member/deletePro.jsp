<%@page import="member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/jsp6/deletePro.jsp</h1>
<%
// 세션값 가져오기
String id =(String)session.getAttribute("id");
// 세션값 없으면 loginForm.jsp 
if(id==null){
			response.sendRedirect("./loginForm.jsp");
			}
// 한글처리
request.setCharacterEncoding("utf-8");

// 파라미터 정보 가져오기
id=request.getParameter("id");
String pass=request.getParameter("pass");

//MemberDAO mdao 객체 생성
MemberDAO mdao = new MemberDAO();
//int check = deleteMember(id, pass)메서드 호출
int check = mdao.deleteMember(id, pass);

// check==1  "삭제 성공" main.jps 이동
// check==0  "비밀번호 틀림" 뒤로 이동
// check==-1  "아이디 없음" 뒤로 이동
if(check == 1){
	%>
	<script type="text/javascript">
		alert("삭제 성공");
	<%
	// 세션 초기화
	session.invalidate();
	// "세션 초기화" 이동 main.jsp
	%>
	location.href="../main/main.jsp";
	</script>
	<%
}	
//check==0
//out.println("비밀번호틀림"); //비밀번호 틀림
else if(check==0){
		//check==0
		//out.println("아이디 없음");//아이디없음	
	%>
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back();
	</script>
	<%
}
//틀리면 "비밀번호 틀림" 뒤로 이동
//없는 경우"아이디 없음" 뒤로 이동 history.back()
else{
	%>
	<script type="text/javascript">
		alert("아이디 없음 ");
		history.back();		
	</script>
	<%
}
%>
</body>
</html>