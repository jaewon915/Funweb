<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>자바 메일 보내기 폼</title>
</head>
<body>
<center>
<form action="mailSend.jsp" method="post">
<table border=1 width=450>
	<tr><td align=center colspan=2><b>자바메일 보내기</td></tr>
	<tr><td>보내는 사람 메일 : </td><td><input type="text" name="sender" value="jaewon915@naver.com"></td></tr>
	<tr><td>받는 사람 메일 : </td><td><input type="text" name="receiver" value="udambara@gmail.com"></td></tr>
	<tr><td>제목 : </td><td><input type="text" name="subject" value="FunWeb 홈페이지  회원가입"></td></tr>
	<tr><td>내용 : </td><td><input type="text" name="content" value="회원가입을 축하합니다. 앞으로 많은 관심 부탁드립니다."></td></tr>
<!-- 	<tr>
		<td>내용 : </td>
		<td><textarea name="content"  cols=40 rows=20></textarea></td>
	</tr> -->
	<tr><td align=center colspan=2><input type="submit" value="보내기"></td></tr>
</table>
</form>
</center>
</body>
</html>
