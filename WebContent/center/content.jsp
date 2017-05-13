<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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
// num pageNum 파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));
// 객체 생성 BoardDAO bdao
String pageNum = request.getParameter("pageNum");
// 패키지 board BoardBean
// 객체생성 BoardDAO bdao
BoardDAO bdao = new BoardDAO();
BoardBean bb = bdao.getBoard(num);
// 게시판 num글에 해당하는 글 가져오기 메서드 호출

//엔터키 (\r\n) => <br> 바꾸기
String content = bb.getContent();
if(content !=null){
	content=bb.getContent().replace("\r\n", "<br>");
	}
%>

<article>
<h3>Notice Content</h3>
<table id="notice">
<tr><td class="left">글번호</td><td class="left"><%=bb.getNum()%></td></tr>
<tr><td class="left">조회수</td><td class="left"><%=bb.getReadcount()%></td></tr>
<tr><td class="left">작성자</td><td class="left"><%=bb.getName()%></td></tr>
<tr><td class="left">작성일</td><td class="left"><%=bb.getDate()%></td></tr>
<tr><td class="left">글제목</td><td colspan=3 class="left"><%=bb.getSubject()%></td></tr>
<tr><td class="left">글내용</td><td colspan=3 class="left"><%=content%></td></tr>

</table>

<div id="table_search">
<%
//세션값 가져오기
String id =(String)session.getAttribute("id");
//세션값이 있으면 글수정, 글삭제, 답글쓰기 버튼 보이기

if(id!=null){
	if(id.equals(bb.getName())){ //로그인 = 글쓴이 같으면 글수정, 글삭제 보임
	%>
	<input type="button" value="글수정" class="btn" onclick="location.href='update.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	<input type="button" value="글삭제" class="btn" onclick="location.href='delete.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	<%
	}
	%>
	<input type="button" value="답글쓰기" class="btn" onclick="location.href='reWrite.jsp?num=<%=num%>&re_ref=<%=bb.getRe_ref()%>&re_lev=<%=bb.getRe_lev()%>&re_seq=<%=bb.getRe_seq()%>'">
	<%-- <input type="button" value="답글쓰기" class="btn" onclick="location.href='reWrite.jsp?num=<%=num%>&re_ref=<%=bb.getRe_ref()%>&re_lev=<%=bb.getRe_lev()%>&re_seq=<%=bb.getRe_seq()%>'"> --%>	           
	
	<%
}
%>

<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">



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