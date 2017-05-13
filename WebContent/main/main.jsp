<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
 a {text-decoration: none; color:black} /* 밑에 줄이 않나오게 */
/*  a:visited {text-decoration: none; color: gray}
 a:active {text-decoration: none; color: gray}
 a:hover {text-decoration: none; color: gray}
 */
</style>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

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
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/main_img.jpg"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<div id="solution">
<div id="hosting">
<h3>2017년 동물자유연대 풀뿌리 동물 보호단체 지원사업</h3>
<p><a href="http://www.animals.or.kr/newmain/board/board.asp?num=301&bname=zetyx_board_issu_ban&ct=yes&cpage=1&search=&keyword=&cate1=&menu1=">우리지역 안락사 위기의 동물을 구하는
동물지킴이들을 지원합니다.
지원을 원하는 봉사모임이나 단체는 2017년 3월 30일까지 신청해 주세요.</a> 
</p>
</div>
<div id="security">
<h3>유기동물 구조</h3>
<p><a href="http://www.animals.or.kr/newmain/06community/community03.asp">유기동물을 발견했을 때 이렇게 대처하세요.
상황에 맞게 조치하세요!<br>
1. 긴급동물 발견시 대처요령<br> 2. 이런동물은 구조를 미뤄보세요<br>
3. 긴급동물보호조치 접수방법<br> 4. 야생동물 구조관련 단체 및 기관<br></a>
</p>
</div>
<div id="payment">
<h3>사지마세요! 입양하세요!</h3>
<p><a href="http://www.animals.or.kr/newmain/07welfare/welfare03.asp">Oh! Boy와 함께하는 스타입양 <br>
캠페인<br>
동물자유연대 보호동물 및 외부의
 요청으로 입양을기다리는
 동물들이 대기중입니다.</a>
</p>
</div>
</div>
<div class="clear"></div>
<div id="sec_news">
<h3><span class="orange">Security</span> News</h3>
<dl>
<dt>Vivamus id ligula....</dt>
<dd>Proin quis ante Proin quis anteProin 
quis anteProin quis anteProin quis anteProin 
quis ante......</dd>
</dl>
<dl>
<dt>Vivamus id ligula....</dt>
<dd>Proin quis ante Proin quis anteProin 
quis anteProin quis anteProin quis anteProin 
quis ante......</dd>
</dl>
</div>
<div id="news_notice">
<h3 class="brown">News &amp; Notice</h3>
<table>
<%
//전체 글개수
// 객체생성 BoardDAO bdao
BoardDAO bdao = new BoardDAO();
// 게시판 글개수 구하는 메서드 호출
// int count = getBoardCount()
int count = bdao.getBoardCount();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
// 게시판에 글이 있으면
// 1, 5 최근글 5개 가죠오기
// List boardList=bdao.getBoardList(startRow, pageSize);
// for

if(count!=0){
	List<BoardBean> boardList = bdao.getBoardList(1, 5);	
//for
	for(int i=0; i < boardList.size(); i++){
		//boardBean bb= 한칸의 데이터 가져와서 저장 .get()
		BoardBean bb = boardList.get(i); //downcasting 필요없음!!!(제네릭 타입으로 형변환되어 있음) List<BoardBean>
		// 자바빈(BoardBean) 변수=배열한칸 접근 배열변수.get()
		//부모                                                      자식
%>
<tr><td class="contxt">
<%
int wid=0;
if(bb.getRe_lev()>0){
	wid=10*bb.getRe_lev();
%>
<img src="../images/center/level.gif" width="<%=wid%>" height="10">
	<img src="../images/center/re.gif">
	<%
}
%>
<a href="../center/content.jsp?num=<%=bb.getNum()%>&pageNum=1"><%=bb.getSubject() %></a></td>
    <td><%=sdf.format(bb.getDate()) %></td></tr>

<%
	}
}
%>
</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>