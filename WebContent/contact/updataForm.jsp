<%@page import="data_room.Data_roomBean"%>
<%@page import="data_room.Data_roomDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
//int num String pageNum 파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
//Data_roomDAO drdao 객체수정
Data_roomDAO drdao= new Data_roomDAO();
//Data_roomBean drb = 메서드호출 getData_room(num)
Data_roomBean drb = drdao.getData_room(num);

%>
<h1>WebContent/board/updateForm.jsp</h1>
<h1>게시판 글수정</h1>
<form action="updatePro.jsp?pageNum=<%=pageNum %>" method="post" name="fr" onsubmit="return check2()">
       <input type="hidden" name="num" value="<%=num %>">
글쓴이 : <input type="text" name="name" value="<%=drb.getName()%>"><br>
비밀번호 : <input type="password" name="pass"><br> 
제목 : <input type="text" name="subject" value="<%=drb.getSubject() %>"><br>
내용 : <textarea rows="10" cols="20" name="content"><%=drb.getContent() %></textarea><br>
<input type="submit" value="글수정">
</form>
</body>
</html>