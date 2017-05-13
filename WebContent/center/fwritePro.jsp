<%@page import="board.BoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
<h1>WebContent/center/writePro.jsp</h1>
<%
// 업로드
// 업로드 폴더 만들기   /upload
// cos.jar 설치
// 업로드 객체 생성
String  realPath = request.getRealPath("/upload");
int maxSize = 5*1024*1024; //5M

MultipartRequest multi=new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

// 자바빈 파일 만들기 패키지 board 파일이름 BoardBean
BoardBean bb =new BoardBean();
// 폼 => 자바빈 멤버변수 저장
bb.setContent(multi.getParameter("content"));
bb.setName(multi.getParameter("name"));
bb.setPass(multi.getParameter("pass"));
bb.setSubject(multi.getParameter("subject"));
bb.setFile(multi.getFilesystemName("file"));

System.out.println("upload폴더에 올라간 파일이름 : "+multi.getFilesystemName("file"));
//사용자가 올린 원파일이름
System.out.println("사용자가 올린 원파일이름 : "+multi.getOriginalFileName("file"));
%>
<%


// setIp(request.getRemoteAddr())
bb.setIp(request.getRemoteAddr());

// 디비작업 파일 만들기 패키지 board 파일이름 BoardDAO

// BoardDAO 객체 생성 bda0
BoardDAO bdao = new BoardDAO();
// 메서드 호출 insertBoard(bb)
bdao.insertBoard(bb);

// 이동 list.jsp
response.sendRedirect("./fnotice.jsp");
%>

</body>
</html>