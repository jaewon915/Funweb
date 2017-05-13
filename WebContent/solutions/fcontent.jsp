<%@page import="photo.PhotoDAO"%>
<%@page import="photo.PhotoBean"%>
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
// int num   String pageNum 파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

// BoardDAO bdao 객체 생성 - ((기억공간 확보))
PhotoDAO pdao = new PhotoDAO();

//조회수 증가 readcount 1증가   update   readcount=readcount +1 
//주소값을 통해서 메서드 호출 updateReadcount(num)
pdao.updateReadcount(num);


// BoardBean bb = 메서드 호출 getBoard(num)
PhotoBean pb = pdao.getPhoto(num);

%>
<h1>WebContent/board/content.jsp</h1>
<h1>글내용 보기</h1>
<table border=1>
<tr><td>글번호</td><td><%=pb.getNum()%></td><td>조회수</td><td><%=pb.getReadcount()%></td></tr>
<tr><td>글쓴이</td><td><%=pb.getName()%></td><td>작성일</td><td><%=pb.getDate()%></td></tr>
<tr><td>글제목</td><td colspan=3><%=pb.getSubject()%></td></tr>
<tr><td>첨부파일</td><td colspan=3><a href="../upload/<%=pb.getFile()%>"><%=pb.getFile()%></a>
</td></tr>
<tr><td>글내용</td><td colspan=3><%=pb.getContent()%></td></tr>
<tr><td colspan=4>
<input type="button" value="글수정" onclick="location.href='fupdateForm.jsp?num=<%=pb.getNum()%>&pageNum=<%=pageNum%>'">
<input type="button" value="글삭제" onclick="location.href='fdeleteForm.jsp?num=<%=pb.getNum()%>&pageNum=<%=pageNum%>'">
<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%=pageNum%>'"></td></tr>
</table>

</body>
</html>