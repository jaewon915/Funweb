<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="photo.PhotoBean"%>
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
<h1>WebContent/center/fupdatePro.jsp</h1>
<%
String pageNum = request.getParameter("pageNum");
String  realPath = request.getRealPath("/upload");
int maxSize = 5*1024*1024; //5M

MultipartRequest multi=new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

PhotoBean pb=new PhotoBean();
//폼 => 자바빈 저장
pb.setNum(Integer.parseInt(multi.getParameter("num")));
pb.setName(multi.getParameter("name"));
pb.setPass(multi.getParameter("pass"));
pb.setSubject(multi.getParameter("subject"));
pb.setContent(multi.getParameter("contnet"));
//첨부파일 있으면 getFilesystemName("file") => 자바빈 저장
//첨부파일 없으면 getParameter("file2") => 자바빈 저장

if (multi.getFilesystemName("file")!=null){
	pb.setFile(multi.getFilesystemName("file"));
}else {
	pb.setFile(multi.getFilesystemName("file2"));
}

System.out.println("upload폴더에 올라간 파일이름 : "+multi.getFilesystemName("file"));
//사용자가 올린 원파일이름
System.out.println("사용자가 올린 원파일이름 : "+multi.getOriginalFileName("file"));

//BoardDAO bdao객체생성
PhotoDAO pdao = new PhotoDAO();

//메서드 호출 updateBoard(bb)
int check =pdao.fupdatePhoto(pb);

// check==1 "수정성공" 이동 notice.jsp?pageNum=
// check==0 "비밀번호" 뒤로 이동
// check==-1 "num 게시판 번호없음" 뒤로 이동
if(check == 1){
	%>
	<script type="text/javascript">
		alert("수정성공");
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