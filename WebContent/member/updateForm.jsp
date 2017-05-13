<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
<script type="text/javascript">
function check2(){
	if(document.fr.pass.value==""){
		//비밀번호를 입력하세요. 커서 깜박 되돌아가기
		alert("비밀번호를 입력하세요");
		document.fr.pass.focus();
		return false;
	}	
}
</script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>

<script type="text/javascript">
	
function check2(){

	if(document.fr.pass.value==""){
		//비밀번호를 입력하세요. 커서 깜박 되돌아가기
		alert("비밀번호를 입력하세요");
		document.fr.pass.focus();
		return false;
	}
	if(document.fr.pass.value!=document.fr.pass2.value){
		//비밀번호를 입력하세요. 커서 깜박 되돌아가기
		alert("비밀번호가 일치하지 않습니다.");
		document.fr.pass.focus();
		return false;
	}
	
	if(document.fr.name.value==""){
		//이름을 입력하세요. 커서 깜박 되돌아가기
		alert("이름을 입력하세요.");
		document.fr.name.focus();
		return false;
	}
	
	if(document.fr.email.value==""){
		//비밀번호를 입력하세요. 커서 깜박 되돌아가기
		alert("이메일를 입력하세요");
		document.fr.pass.focus();
		return false;
	}
	if(document.fr.email.value!=document.fr.email2.value){
		//비밀번호를 입력하세요. 커서 깜박 되돌아가기
		alert("이메일이 일치하지 않습니다.");
		document.fr.pass.focus();
		return false;
	}
	if(document.fr.address.value==""){
		//한마디 입력하세요. 커서 깜박 되돌아가기
		alert("주소를 입력하세요");
		document.fr.address.focus();
		return false;
	}
	if(document.fr.phone.value==""){
		//한마디 입력하세요. 커서 깜박 되돌아가기
		alert("전화번호를 입력하세요");
		document.fr.phone.focus();
		return false;
	}
	if(document.fr.mobile.value==""){
		//한마디 입력하세요. 커서 깜박 되돌아가기
		alert("휴대폰를 입력하세요");
		document.fr.mobile.focus();
		return false;
	}
}		
 </script>



</head>
<body>
<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더파일들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->

<%
// String id = 세션값 가져오기
String id =(String)session.getAttribute("id");

// 세션값이 없으면 loginForm.jsp 이동 
if(id==null){
	response.sendRedirect("./login.jsp");
			}

// MemberDAO객체생성 참조변수 mdao
MemberDAO mdao = new MemberDAO();
//MemberBean mb=mdao.getMember(id) 메서드 호출;
MemberBean mb=mdao.getMember(id);

//gender가 null이면 gender="남"
	String gender=mb.getGender();
		if(gender==null){
			gender="남";
		}
%>



<h2>회원정보 수정</h2>
<body>
<h2>WebContent/member/updateForm.jsp</h2>
<article>
<form action="updatePro.jsp" method="post" name="fr" onsubmit="return check2()" id="join">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" value="<%=mb.getId() %>" class="id" readonly><br>

<label>Password</label>
<input type="password" value="<%=mb.getPass() %>" name="pass" readonly><br>

<label>Retype Password</label>
<input type="password" name="pass2"><br>

<label>Name</label>
<input type="text" value="<%=mb.getName() %>" name="name"><br>

<label>나이</label>
<input type="text" value="<%=mb.getAge() %>" name="age"><br>

<label>성별 : </label>
<input type="radio" name="gender" value="남" <%if(gender.equals("남")){ %> checked <%}  %>>남
<input type="radio" name="gender" value="여" <%if(gender.equals("여")){ %>checked <%} %>>여<br>

<label>E-Mail</label>
<input type="email" value="<%=mb.getEmail() %>" name="email"><br>
<label>Retype E-Mail</label>
<input type="email" name="email2"><br>
</fieldset>

<fieldset>
<legend>Optional</legend>
<label>Address</label>
<input type="text" name="zip_code" value="<%=mb.getZip_code() %>" id="sample4_postcode" placeholder="우편번호" readonly>
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" size="30" name="address" value="<%=mb.getAddress() %>" id="sample4_roadAddress" placeholder="도로명주소">
<input type="text" size="30" name="address2" value="<%=mb.getAddress2() %>" id="sample4_jibunAddress" placeholder="지번주소">
<span id="guide" style="color:#999"></span><br>
<!-- <input type="text" name="address"><br> -->

<label>Phone Number</label>
<input type="text" value="<%=mb.getPhone() %>" name="phone"><br>
<label>Mobile Phone Number</label>
<input type="text" value="<%=mb.getMobile() %>" name="mobile"><br>
</fieldset>
<div class="clear"></div>

<input type="button" name="main" value="메인화면 GO" onclick="location.href='../main/main.jsp'">
<input type="submit" name="update" value="회원정보수정" onclick="location.href='updateForm.jsp'">
<input type="button" name="delete" value="회원정보삭제" onclick="location.href='deleteForm.jsp'"><br>
</fieldset>
</form>
</article>

<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>