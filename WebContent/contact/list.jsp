<%@page import="java.util.List"%>
<%@page import="data_room.Data_roomDAO"%>
<%@page import="data_room.Data_roomBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
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
// 디비객체 생성 Data_roomDAO frdao
Data_roomDAO drdao = new Data_roomDAO();

// 전체 글의 개수 구하기
// int count = getData_roomCount() 메서드 호출   mysql함수 count(*)이용
int count = drdao.getData_roomCount();

// 한 페이지에 보여줄 글의 개수
int pageSize=10;
//현페이지가 몇 페이지인지 가져오기
String pageNum = request.getParameter("pageNum");
if(pageNum==null){  // pageNum없으면
	pageNum="1";	// 무조건 1페이지
}

//시작행 구하기 1   11   21   31...    <= pageNum, pageSize 조합
int currentPage=Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;

//끝행 구하기
int endRow = currentPage*pageSize;

// List data_roomList =	메서드 호출 getBoardList()(시작행, 몇개)
//List data_roomList=null;

List<Data_roomBean> data_roomList=drdao.getData_roomList(startRow, pageSize);

%>
<article>
<h3>Notice [전체 글개수 : <%=count %>]</h3>
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
	for(int i=0; i < data_roomList.size(); i++){
		//data_roomBean drb= 한칸의 데이터 가져와서 저장 .get()
		Data_roomBean drb = data_roomList.get(i); //downcasting
		// 자바빈(Data_roomBean) 변수=배열한칸 접근 배열변수.get()
		//부모                                                      자식
		
%>
	<tr onclick="location.href='content.jsp?num=<%=drb.getNum()%>&pageNum=<%=pageNum%>'"><td><%=drb.getNum() %></td><td class="left">
<%
//답글 들여쓰기 모양
int wid=0;
if(drb.getRe_lev()>0){
	wid=10*drb.getRe_lev();
	%>
	<img src="../images/center/level.gif" width="<%=wid%>" height="15px">
	<img src="../images/center/re.gif">
	<%	
}
%>
<%= drb.getSubject()%></td><td><%= drb.getName()%></td><td><%=drb.getDate() %></td>
<td><%=drb.getReadcount() %></td><%-- <td><%=drb.getIp() %></td> --%>
</tr>
<%
}
%>
</table>


<div id="table_search">


<%
//세션값 가져오기
String id =(String)session.getAttribute("id");
//세션값이 있으면 글쓰기 버튼 보이기

if(id!=null){
	%>
	<input type="button" value="글쓰기" class="btn" onclick="location.href='fwriteForm.jsp'">
	<%
}
%>
</div>

<div id="table_search">
<form action="listSearch.jsp" method="get">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>

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