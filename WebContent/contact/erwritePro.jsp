<%@page import="board2.Board2DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/board/writePro.jsp</h1>
<%
// 한글처리
request.setCharacterEncoding("utf-8");

int num = Integer.parseInt(request.getParameter("num"));
// 자바빈 파일 만들기 패키지 board 파일이름 BoardBean
// java.sql.Date

// 액션태그 useBean BoardBean bb객체 생성
%>
<!-- 액션태그 객체 생성 -->
<jsp:useBean id="b2b" class="board2.Board2Bean"/>
<!-- 액션태그 setProperty -->
<jsp:setProperty property="*" name="b2b"/>

<%
// 액션태그 setProperty 폼 내용 가져와서 형변환 => 자바빈 멤버변수 저장


// setIp(request.getRemoteAddr())
b2b.setIp2(request.getRemoteAddr());

// 디비작업 파일 만들기 패키지 board 파일이름 BoardDAO

// BoardDAO 객체 생성 bda0
Board2DAO b2dao = new Board2DAO();
// 메서드 호출 insertBoard(bb)
b2dao.insertBoard2(b2b, num);

// 이동 list.jsp
response.sendRedirect("./list.jsp");
%>

</body>
</html>