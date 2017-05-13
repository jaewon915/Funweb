<%@page import="photo.PhotoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/solutions/fdeletePro.jsp</h1>
<%
//한글처리
request.setCharacterEncoding("utf-8");
//pageNum 파라미터 가져오기
String pageNum = request.getParameter("pageNum");
//글번호, 비밀번호 파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));
String pass=request.getParameter("pass");

//액션태그 useBean BoardBean bb 객체생성
//액션태그 setProperty 폼 => 자바빈 bb 자동저장
%>

<jsp:useBean id="pb" class="photo.PhotoBean"/>
<jsp:setProperty property="*" name="pb"/>

<%

//BoardDAO bdao객체생성
PhotoDAO pdao = new PhotoDAO();

//메서드 호출 updateBoard(bb)
int check = pdao.deletePhoto(num, pass);

// check==1 "수정성공" 이동 notice.jsp?pageNum=
// check==0 "비밀번호" 뒤로 이동
// check==-1 "num 게시판 번호없음" 뒤로 이동
if(check == 1){
	%>
	<script type="text/javascript">
		alert("삭제 성공");
		location.href="photo.jsp?pageNum=<%=pageNum%>";

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
		alert("글번호 없음 ");
		history.back();		
	</script>
	<%
}
%>

</body>
</html>