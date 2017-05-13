<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function result(){
		// join id텍스트 상자 value = 선택한 id값 joinIdCheck id텍스트 value
		//join창(opener)
		opener.document.fr.id.value = document.wfr.userid.value;
		// 창닫기
		window.close();
	}
</script>

<style type="text/css">
body{
	text-align: center;
}
</style>

</head>
<body bgcolor="#ffebcc" >
<p>
<br><br>
<!--  WebConten/member/joinIdCheck.jsp --><b>
<%
// String id = userid 파라미터 가져오기
String id = request.getParameter("userid");
// MemberDAO mdao 객체생성
MemberDAO mdao = new MemberDAO();
// int check = 메서드 호출 joinIdCheck(id)
int check = mdao.joinIdCheck(id);

// check==1 중복 아이디 있음, 사용중인  아이디
// check==0 중복 아이디 없음, 사용 가능한 아이디
if(check == 1){
	out.println("사용중인 아이디 입니다.</b>");
}else
	{out.println("사용 가능한 아이디 입니다.");
	%>
	<input type="button" value="아이디선택" onclick="result()">
	<%
}
%></b>
<form action="joinIdCheck.jsp" method="post" name="wfr">
<input type="text" name="userid" value="<%=id%>">
<input type="submit" name="" value="중복확인">
</form>

</body>
</html>