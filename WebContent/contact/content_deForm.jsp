<%@page import="java.util.List"%>
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

<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->


</head>
<body>
<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더파일들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
		<ul>
			<li><a href="../center/notice.jsp">Notice</a></li>
			<li><a href="#">Public News</a></li>
			<li><a href="../center/fnotice.jsp">Driver Download</a></li>
			<li><a href="#">Service Policy</a></li>
		</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
<!-- 게시판 -->
<%
// int num   String pageNum 파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

// BoardDAO bdao 객체 생성 - ((기억공간 확보))
Data_roomDAO drdao = new Data_roomDAO();

//조회수 증가 readcount 1증가   update   readcount=readcount +1 
//주소값을 통해서 메서드 호출 updateReadcount(num)
drdao.updateReadcount(num);


// BoardBean bb = 메서드 호출 getBoard(num)
Data_roomBean drb = drdao.getData_room(num);

String content = drb.getContent();
if(content !=null){
	content=drb.getContent().replace("\r\n", "<br>");
	}

%>

<article>
<h1>글내용 보기</h1>
<h1>WebContent/contact/content.jsp</h1>
<table id="notice">
<tr><td class="left">글번호</td><td class="left"><%=drb.getNum()%></td></tr>
<tr><td class="left">조회수</td><td class="left"><%=drb.getReadcount()%></td></tr>
<tr><td class="left">작성자</td><td class="left"><%=drb.getName()%></td></tr>
<tr><td class="left">작성일</td><td class="left"><%=drb.getDate()%></td></tr>
<tr><td class="left">글제목</td><td colspan=3 class="left"><%=drb.getSubject()%></td></tr>
<tr><td class="left">첨부파일</td><td colspan=3 class="left">
<a href="../upload/<%=drb.getFile()%>"><%=drb.getFile()%></a>
</td></tr>
<tr><td class="left">글내용</td><td colspan=3 class="left"><%=content%></td></tr>
</table>

<%-- <table border=1>
<tr><td>글번호</td><td><%=drb.getNum()%></td><td>조회수</td><td><%=drb.getReadcount()%></td></tr>
<tr><td>글쓴이</td><td><%=drb.getName()%></td><td>작성일</td><td><%=drb.getDate()%></td></tr>
<tr><td>글제목</td><td colspan=3><%=drb.getSubject()%></td></tr>
<tr><td>첨부파일</td><td colspan=3>
<a href="../upload/<%=drb.getFile()%>"><%=drb.getFile()%></a>
</td></tr>
<tr><td>글내용</td><td colspan=3><%=drb.getContent()%></td></tr> --%>

<div id="table_search">
<%
int num2 = Integer.parseInt(request.getParameter("num2"));

//세션값 가져오기
String id =(String)session.getAttribute("id");
//세션값이 있으면 글수정, 글삭제, 답글쓰기 버튼 보이기

if(id!=null){
	if(id.equals(drb.getName())){ //로그인 = 글쓴이 같으면 글수정, 글삭제 보임
	%>
	<input type="button" value="글수정" class="btn" onclick="location.href='updateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	<input type="button" value="글삭제" class="btn" onclick="location.href='deleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	<%
	}
	%>
	<%-- <input type="button" value="댓글쓰기" class="btn" onclick="location.href='erwriteForm.jsp?num=<%=num%>&re_ref=<%=drb.getRe_ref()%>&re_lev=<%=drb.getRe_lev()%>&re_seq=<%=drb.getRe_seq()%>'"> --%>
	<%-- <input type="button" value="답글쓰기" class="btn" onclick="location.href='reWrite.jsp?num=<%=num%>&re_ref=<%=bb.getRe_ref()%>&re_lev=<%=bb.getRe_lev()%>&re_seq=<%=bb.getRe_seq()%>'"> --%>	           
	


<table id="notice">

<form action="erwritePro.jsp" method="post" name="fr" id="center">


<br><br>댓글쓰기 : <textarea rows="3" cols="78" name="content2"></textarea><br><br>
이름 : <input type="text" name="name2" value="<%=id%>" readonly>
패스워드 : <input type="text" name="pass2" value="" >
<input type="submit" value="댓글쓰기" class="btn" >
<input type="hidden" name="num" value="<%=drb.getNum()%>" class="btn">
<input type="button" value="글목록" class="btn" onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">


<%-- <br><br>댓글쓰기 : <textarea rows="3" cols="78" name="content2"></textarea><br><br>
<input type="submit" value="댓글쓰기" class="btn" >
<input type="hidden" name="num" value="<%=drb.getNum()%>" class="btn">
<input type="button" value="글목록" class="btn" onclick="location.href='list.jsp?pageNum=<%=pageNum%>'"> --%>
</form>
</table>


	<%
}
%>



<%
// 디비객체 생성 Data_roomDAO frdao
Board2DAO b2dao = new Board2DAO();

// 전체 글의 개수 구하기
// int count = getData_roomCount() 메서드 호출   mysql함수 count(*)이용
int count = b2dao.getBoard2Count();


// List data_roomList =	메서드 호출 getBoardList()(시작행, 몇개)
//List data_roomList=null;

List<Board2Bean> board2List=b2dao.getBoard2List(num);

%>



<h3> 댓글 수 : [<%=count %>]</h3>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>

<%-- <h1>WebContent/board/list.jsp</h1>
<h1> 자료실 글 목록 [전체 글의 개수 : <%=count %>] </h1>
<h3><a href="fwriteForm.jsp">글쓰기</a></h3>
<table border=1>
<tr bgcolor="orange">
<td>번호</td><td>제목</td><td>작성자</td><td>날짜</td><td>조회수</td><td>IP</td>
</tr> --%>
<%
	for(int i=0; i < board2List.size(); i++){
		//board2Bean b2b= 한칸의 데이터 가져와서 저장 .get()
		Board2Bean b2b = board2List.get(i); //downcasting
		// 자바빈(Board2Bean) 변수=배열한칸 접근 배열변수.get()
		//부모                                                      자식
		
%>

<%
if(id!=null ){
	if(id.equals(b2b.getName2()) && num2==b2b.getNum2()){ //로그인 = 글쓴이 같으면 글수정, 글삭제 보임
%>
<tr><td><%=b2b.getNum2() %></td><td class="left">
 <form action="content_dePro.jsp?num=<%=drb.getNum()%>&num2=<%=b2b.getNum2()%>&pageNum=<%=pageNum%>" method="post" name="fr" id="center">
<input type="text" name="content2" value="<%= b2b.getContent2()%>">
<input type="hidden" name="name2" value="<%= b2b.getName2()%>">
<input type="submit" value="삭제">
pw : <input type="password" name="pass2" value="" size="6">
<input type="hidden" name="num" value="<%=drb.getNum()%>">
<input type="hidden" name="num2" value="<%= b2b.getNum2()%>" >
</form>
</td>

<td><%= b2b.getName2()%></td>



<td><%=b2b.getDate2() %></td>
<td><%=b2b.getReadcount2() %></td><%-- <td><%=drb.getIp() %></td> --%>

<%
	}
}  //if
%>
</tr>
<%
} //for
%>
</table>



<div class="clear"></div>
<div id="page_control">
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>