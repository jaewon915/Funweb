
<%@page import="data_room.Data_roomDAO"%>
<%@page import="data_room.Data_roomBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/contact/fwritePro.jsp</h1>
<%

// 파일 업로드 cos.jar => MultipartRequest 프로그램 이용
//MultipartRequest 객체 생성 => 파일 업로드, multi파라미터 정보 저장
//MultipartRequest nulti=new MultipartRequest(request, 파일을 업로드할 폴더 물리적 위치, 파일 최대크기, 한글처리, 파일이름이 동일할 때 파일이름을 변경);
// 파일을 업로드할 폴더 물리적 위치
//WebContent에  폴더 만들기(upload)
//upload폴더를 물리적 경로 만들기
String realPath=request.getRealPath("upload");
System.out.println("물리적 경로 : "+realPath);
int maxSize=5*1024*1024; //5M
//한글처리 utf-8
//파일이름이 동일할때 파일이름을 변경
// new DefaultFileRenamePolicy()

MultipartRequest multi=new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());


// 디비작업 파일 만들기 패키지 board 파일이름 BoardDAO
//자바빈 객체 생성 BoardBena bb
Data_roomBean drb=new Data_roomBean();

// set메서드호출 폼 => 자바빈 멤버변수 저장
drb.setName(multi.getParameter("name"));
drb.setPass(multi.getParameter("pass"));
drb.setSubject(multi.getParameter("subject"));
drb.setContent(multi.getParameter("content"));
// upload 폴더에 올라간 파일이름
drb.setFile(multi.getFilesystemName("file"));

System.out.println("upload폴더에 올라간 파일이름 : "+multi.getFilesystemName("file"));
//사용자가 올린 원파일이름
System.out.println("사용자가 올린 원파일이름 : "+multi.getOriginalFileName("file"));

//setIp(request.getRemoteAddr())
drb.setIp(request.getRemoteAddr());

//BoardDAO 객체 생성 bda0
Data_roomDAO drdao = new Data_roomDAO();
// 메서드 호출 insertBoard(bb)
drdao.insertData_room(drb);

// 이동 list.jsp
response.sendRedirect("./list.jsp");
%>

</body>
</html>