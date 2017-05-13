<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
    <%@ page import="javax.activation.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String sender=request.getParameter("sender");
	String receiver=request.getParameter("email");
	String subject=request.getParameter("subject");
	String content=request.getParameter("content");
	
	String server = "smtp.naver.com";
	
	try{
		Properties properties = new Properties();
		properties.put("mail.smtp.host", server);
		Session s = Session.getDefaultInstance(properties, null);
		Message message = new MimeMessage(s);
		
		Address sender_address=new InternetAddress(sender);
		Address receiver_address=new InternetAddress(receiver);
		
		message.setHeader("content-type","text/html;charset=utf-8");
		message.setFrom(sender_address);
		message.addRecipient(Message.RecipientType.TO,receiver_address);
		message.setSubject(subject);
		message.setContent(content,"text/html;charset=utf-8");
		message.setSentDate(new java.util.Date());
		
		Transport transport= s.getTransport("smtp") ;
		transport.connect(server,"jaewon915","");
		transport.sendMessage(message,message.getAllRecipients());
		transport.close();
		
		out.println("<h3>메일이 정상적으로 전송되었습니다.</h3>");
	}catch(Exception e){
		out.println("SMTP 서버가 잘못 설정되었거나, 서비스에 문제가 있습니다.");
		e.printStackTrace();
	}
%>
    
    
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1></h1>
<%
//request 한글처리
request.setCharacterEncoding("utf-8");

//자바빈 패키지 member 파일이름 MemberBean
//액션태그 userBean 객체생성 MemberBean mb
%>

<jsp:useBean id="mb" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/>

<!-- <br>액션태그를 이용한 자바빈 멤버변수 id :  -->
<%-- <jsp:getProperty property="id" name="mb"/><br> --%>
<!-- <br>액션태그를 이용한 자바빈 멤버변수 pass : -->
<%-- <jsp:getProperty property="pass" name="mb"/><br> --%>
<!-- <br>액션태그를 이용한 자바빈 멤버변수 name : -->
<%-- <jsp:getProperty property="name" name="mb"/><br> --%>
<!-- <br>액션태그를 이용한 자바빈 멤버변수 나이 : -->
<%-- <jsp:getProperty property="age" name="mb"/><br> --%>
<!-- <br>액션태그를 이용한 자바빈 멤버변수 인성 : -->
<%-- <jsp:getProperty property="gender" name="mb"/><br> --%>
<!-- <br>액션태그를 이용한 자바빈 멤버변수 email : -->
<%-- <jsp:getProperty property="email" name="mb"/><br> --%>
<!-- <br>액션태그를 이용한 자바빈 멤버변수 address : -->
<%-- <jsp:getProperty property="address" name="mb"/><br> --%>
<!-- <br>액션태그를 이용한 자바빈 멤버변수 address2 : -->
<%-- <jsp:getProperty property="address2" name="mb"/><br> --%>
<!-- <br>액션태그를 이용한 자바빈 멤버변수 zip_code : -->
<%-- <jsp:getProperty property="zip_code" name="mb"/><br> --%>
<!-- <br>액션태그를 이용한 자바빈 멤버변수 phone : -->
<%-- <jsp:getProperty property="phone" name="mb"/><br> --%>
<!-- <br>액션태그를 이용한 자바빈 멤버변수 mobile : -->
<%-- <jsp:getProperty property="mobile" name="mb"/><br> --%>

<%

//액션태그 setProperty 폼 => 자바빈 저장

// setReg_date 호출 Timestamp 현시스템의 날짜 시간 저장
//날짜 => 자바빈 저장
mb.setReg_date(new Timestamp(System.currentTimeMillis()));
%>
<!-- <br>액션태그를 이용한 자바빈 멤버변수 reg_date : -->
<%-- <jsp:getProperty property="reg_date" name="mb"/><br> --%>
<%
//디비작업 패키지member 파일이름 MemberDAO

//객체 생성 MemberDAO mdao
MemberDAO mdao = new MemberDAO();
//매서드호출 insertMember(mb)
mdao.insertMember(mb);
%>
<script type="text/javascript">
	alert("회원가입성공");
	location.href="login.jsp";
</script>
</body>
</html>