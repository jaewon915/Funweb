<%@page import="java.util.List"%>
<%@page import="photo.PhotoDAO"%>
<%@page import="photo.PhotoBean"%>
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
PhotoDAO pdao = new PhotoDAO();

// 전체 글의 개수 구하기
// int count = getData_roomCount() 메서드 호출   mysql함수 count(*)이용
int count = pdao.getPhotoCount();

// 한 페이지에 보여줄 글의 개수
int pageSize=12;
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

List<PhotoBean> photoList=pdao.getPhotoList(startRow, pageSize);

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
	for(int i=0; i < photoList.size(); i++){
		//data_roomBean drb= 한칸의 데이터 가져와서 저장 .get()
		PhotoBean pb = photoList.get(i); //downcasting
		// 자바빈(Data_roomBean) 변수=배열한칸 접근 배열변수.get()
		//부모                                                      자식
		
%>
	<tr><td><%=pb.getNum() %></td><td class="left">

<a href="content.jsp?num=<%=pb.getNum()%>&pageNum=<%=pageNum%>"><%= pb.getSubject()%></a></td><td><%= pb.getName()%></td><td><%=pb.getDate() %></td>
<td><%=pb.getReadcount() %></td><%-- <td><%=drb.getIp() %></td> --%>
</tr>
<%
}
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
//세션값 가져오기
String id =(String)session.getAttribute("id");
//세션값이 있으면 글쓰기 버튼 보이기

if(id!=null){
	%>
	<input type="button" value="글쓰기" class="btn" onclick="location.href='write.jsp'">
	<%
}
%>




<%
//페이지 출력
if(count!=0){
	//전체 페이지 수 구하기   게시판글  50개 한 화면에 보여줄 글개수 10 => 5 페이지
	//						56개 한 화면에 보여줄 글개수 10 => 5 페이지 + 1(나머지) =>6
	int pageCount =count/pageSize + (count%pageSize==0 ? 0 : 1);
	//한 화면에 보여줄 페이지 번호 개수
	int pageBlock=10;
	//시작페이지 번호 구하기   1~10=>1   11~20=>11   21~30=>21
	int startPage=((currentPage-1)/pageBlock)*pageBlock+1;
	//끝페이지 번호 구하기
	int endPage=startPage+pageBlock-1;
	
	if(endPage > pageCount){
		endPage=pageCount;
	}
	//이전 페이지
	if(startPage>pageBlock){ // 스타트페이지가 페이지블럭보다 많을 때
		%><a href="list.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>&nbsp;<%
	}
	//1...10   11...20   21...30
	for(int i=startPage; i<=endPage; i++){
		%><a href="list.jsp?pageNum=<%=i%>">[<%=i%>]</a>&nbsp;<%
	}
	//다음 페이지
	if(endPage<pageCount){ //엔트페이지가 페이지블록보다 작을 때
		%><a href="list.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a><%
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