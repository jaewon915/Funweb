<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// 한글처리
request.setCharacterEncoding("utf-8");

// 자바빈 파일 만들기 패키지 board 파일이름 BoardBean
// java.sql.Date
// 액션태그 useBean BoardBean bb객체 생성
%>
<!-- 액션태그 객체 생성 -->
<jsp:useBean id="bb" class="board.BoardBean"/>
<!-- 액션태그 setProperty -->
<jsp:setProperty property="*" name="bb"/>

<%
// 액션태그 setProperty 폼 내용 가져와서 형변환 => 자바빈 멤버변수 저장
// setIp(request.getRemoteAddr())
bb.setIp(request.getRemoteAddr());

// 디비작업 파일 만들기 패키지 board 파일이름 BoardDAO

// BoardDAO 객체 생성 bda0
BoardDAO bdao = new BoardDAO();
// 메서드 호출 reInsertBoard(bb)
bdao.reInsertBoard(bb);

// 이동 list.jsp
response.sendRedirect("./notice.jsp");
%>
</body>
</html>