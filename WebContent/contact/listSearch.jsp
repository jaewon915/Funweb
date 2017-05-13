<%@page import="java.util.List"%>
<%@page import="data_room.Data_roomDAO"%>
<%@page import="data_room.Data_roomBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
//한글처리
request.setCharacterEncoding("utf-8");
//검색어 search 파라미터 가져오기
String search = request.getParameter("search");

// 패키지 data_room Data_roomBean
// 패키지 data_room Data_roomDAO
// 객체생성 data_roomDAO drdao
Data_roomDAO drdao = new Data_roomDAO();
// 게시판 글개수 구하는 메서드 호출
// int count = getData_roomCount()
int count = drdao.getData_roomCount(search);
// 한페이지에 보여줄 글수 설정
int pageSize=15;

// 현페이지 가져오기 pageNum 파라미터 가져오기 없으면 "1" 설정
String pageNum = request.getParameter("pageNum");
if(pageNum==null){  // pageNum없으면
	pageNum="1";	// 무조건 1페이지
}

//첫행 구하기
//int currentPage=pageNum 정수형으로 바꾸기
//시작행 구하기 1   16   31   46...    <= pageNum, pageSize 조합
int currentPage=Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;

//끝행 구하기
//int endRow = currentPage*pageSize;

List<Data_roomBean> data_roomList=null;
//List boardList =	메서드 호출 getBoardList()(시작행, 몇개)
//List boardList=bdao.getBoardList(startRow, pageSize);
// 게시판 글이 있으면 메서드 호출 getBoardList(첫행, 한페이지에 보여 줄 글 수)
if(count!=0){
	data_roomList=drdao.getData_roomList(startRow, pageSize, search);	
}
%>
<article>
<h3>Notice [전체 글개수 : <%=count %>]</h3>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
<%
	//data_roomList
	if(count!=0){
	for(int i=0; i < data_roomList.size(); i++){
		//boardBean bb= 한칸의 데이터 가져와서 저장 .get()
		Data_roomBean drb = data_roomList.get(i); //downcasting 필요없음!!!(제네릭 타입으로 형변환되어 있음) List<BoardBean>
		// 자바빈(BoardBean) 변수=배열한칸 접근 배열변수.get()
		//부모                                                      자식
%>
	<tr onclick="location.href='content.jsp?num=<%=drb.getNum()%>&pageNum=<%=pageNum%>'"><td><%=drb.getNum() %></td><td class="left">
	<%
	int wid=0;
	if(drb.getRe_lev()>0){
		wid=10*drb.getRe_lev();
	%>
	<img src="../images/center/level.gif" width="<%=wid%>" height="30">
	<img src="../images/center/re.gif">
	<%
	}
	%>
	<%= drb.getSubject()%></td><td><%= drb.getName()%></td><td><%=drb.getDate() %></td>
			<td><%=drb.getReadcount() %></td><%-- <td><%=drb.getIp() %></td> --%>
    </tr>
<%
	} //for
}  //if
%>
</table>

<div id="table_search">
<form action="listSearch.jsp" method="get">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>

<div class="clear"></div>
<div id="page_control">
<%
if(count!=0){
	//전체페이지수 구하기
	int pageCount=count/pageSize+(count%pageSize==0?0:1); // 35페이지는 3페이지블럭하고 1페이지블럭 추가
	//한페이지에 보여줄 페이지수 설정 (예 : 1)
	int pageBlock=10;
	//한페이지에 시작하는 페이지 번호 (예 : 10)
	int startPage=((currentPage-1)/pageBlock)*pageBlock+1;
	//한페이지에 보여줄 끝나는 페이지 번호
	int endPage=startPage+pageBlock-1;
	if(endPage>pageCount){  //  마지막페이지 > 페이지카운트      60페이지 밖에 없는데 100페이지까지 나오는 경우를 제외 시킴   
		endPage=pageCount;
	}
	
	//Pre
	if(startPage>pageBlock){
	%><a href="listSearch.jsp?pageNum=<%=startPage-pageBlock%>&search=<%=search%>">Prev</a><%	
	}
	//1~10 11~20 21~30 ...
	for(int i=startPage; i<=endPage; i++){
		%><a href="listSearch.jsp?pageNum=<%=i%>&search=<%=search%>">[<%=i%>]</a>&nbsp;<%
	}
	//Next
	if(endPage<pageCount){
	%><a href="listSearch.jsp?pageNum=<%=startPage+pageBlock%>&search=<%=search%>">Next</a><%
	}
}
%>

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