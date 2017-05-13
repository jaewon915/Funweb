<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// WebContent/member/logout.jsp
// 세션 초기화
	session.invalidate();
// "세션 초기화" 이동 sessionMain.jsp
%>
<script type="text/javascript">
	alert("로그 아웃하셨습니다.");
	location.href="../main/main.jsp";
</script>
</body>
</html>
