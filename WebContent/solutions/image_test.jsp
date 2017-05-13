<%@page import="photo.PhotoBean"%> 
<%@page import="photo.PhotoDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 스크립트 테스트 페이지</title>
<script type="text/javascript">
function winclose(){
	window.close();
}
</script>
</head>
<body>
<h1>이미지 스크립트 테스트 페이지</h1>
<%
// num  pageNum 파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));
String picture=request.getParameter("picture");

// 객체 생성 BoardDAO bdao
PhotoDAO pdao=new PhotoDAO();


System.out.println(" picture : " + picture);
System.out.println("num : "+ num);

//PhotoBean bb = getPhoto(int num)
PhotoBean pb=pdao.getPhoto(num);
%>

<img src="../upload/<%=pb.getFile() %>" width="600" height="600" onclick="winclose()">

</body>
</html>