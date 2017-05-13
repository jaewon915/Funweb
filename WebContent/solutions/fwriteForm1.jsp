<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자료실 글쓰기(첨부파일추가)</title>
</head>
<body>
<%
// 파일 업로드
// 업로드 프로그램 설치 WebContent -WEB-INF - lib -cos.jar
// www.servlets.com 다운로드
// com.oreilly.servlet 왼쪽메뉴 cos-26Dec2008.zip

// 1. 특정폴더(upload)에 파일을 넣고 디비에느 파일이름 저장
// 2. 파일을 => 디비저장

// 폼태그 시작부분 enctype="multipart/form-data" 꼭 넣어주기
%>

<h1>WebContent/photo/fwriteForm.jsp</h1>
<h1>포토갤러리 사진올리기</h1>
<form action="fwritePro.jsp" method="post" name="fr" enctype="multipart/form-data">
글쓴이 : <input type="text" name="name"><br>
비밀번호 : <input type="password" name="pass"><br> 
제목 : <input type="text" name="subject"><br>
파일첨부 : <input type="file" name="file"><br>
내용 : <textarea rows="10" cols="20" name="content"></textarea><br>
<input type="submit" value="사진올리기">
</form>
</body>
</html>