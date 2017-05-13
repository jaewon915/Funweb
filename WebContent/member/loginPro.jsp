<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/member/loginPro.jsp</h1>
<%
//한글처리
request.setCharacterEncoding("utf-8");
//폼에서 입력한 id pass 파라미터 가져오기
String id=request.getParameter("id");
String pass=request.getParameter("pass");
// MemberDAO  mdao객체생성
MemberDAO mdao = new MemberDAO();

// int check = 메서드 호출 (id, pass)
int check = mdao.idCheck(id, pass);
// check==1 로그인 인증 "id" id   main.jsp이동
// check==0 "비밀번호 틀림" 뒤로 이동
// check==-1 "아이디 없음" 뒤로 이동
if(check == 1){
	session.setAttribute("id", id);
	response.sendRedirect("../main/main.jsp");
}	
//check==0
					//out.println("비밀번호틀림"); //비밀번호 틀림
//							  틀리면 "비밀번호 틀림" 뒤로 이동
//					  없는 경우"아이디 없음" 뒤로 이동 history.back()
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
else{
	%>
	<script type="text/javascript">
	alert("아이디 없음");
	history.back();		
	</script>
	<%
}
%>
</body>
</html>