<%@page import="board2.Board2DAO"%>
<%@page import="data_room.Data_roomDAO"%>
<%@page import="data_room.Data_roomBean"%>
<%@page import="board2.Board2Bean"%>
<%@page import="board2.Board2Bean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/board/updatePro.jsp</h1>
<%
//한글처리
request.setCharacterEncoding("utf-8");
//pageNum 파라미터 가져오기
String pageNum = request.getParameter("pageNum");
int num = Integer.parseInt(request.getParameter("num"));
int num2 = Integer.parseInt(request.getParameter("num2"));
String pass2=request.getParameter("pass2");
//액션태그 useBean BoardBean bb 객체생성
//액션태그 setProperty 폼 => 자바빈 bb 자동저장
%>

<jsp:useBean id="b2b" class="board2.Board2Bean"/>
<jsp:setProperty property="*" name="b2b"/>

<%

//BoardDAO bdao객체생성
Board2DAO b2dao = new Board2DAO();
//Data_roomDAO drdao = new Data_roomDAO();
//drdao.updateReadcount(num);
//Data_roomBean drb = drdao.getData_room(num);

//메서드 호출 updateBoard(bb)
int check =b2dao.deleteBoard2(num2, pass2);

// check==1 "수정성공" 이동 list.jsp?pageNum=
// check==0 "비밀번호" 뒤로 이동
// check==-1 "num 게시판 번호없음" 뒤로 이동
if(check == 1){
	%>
	<script type="text/javascript">
		alert("삭제성공");
	<%-- location.href="content.jsp?num=<%=drb.getNum()%>&num2=<%=b2b.getNum2()%>&pageNum=<%=pageNum%>"; --%>
	location.href="content_deForm.jsp?num=<%=num%>&num2=<%=num2%>&pageNum=<%=pageNum%>";
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
		alert("댓글과 비밀번호를 정확히 입력하세요");
		history.back();		
	</script>
	<%
}
%>

</body>
</html>