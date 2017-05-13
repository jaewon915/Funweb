<%@ page import="javax.activation.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메일인증 체크</title>

<%
request.setCharacterEncoding("utf-8");
String email = request.getParameter("email");//받는사람의 이메일 주소(인증받을 이메일)
String cbool = request.getParameter("cbool");//난수를 만들어야하는지 비교만 할껀지를 위한 변수
//cbool 1이면 재인증 0이면 메인에서

String checknum = "";

if(cbool.equals("0")){
	 //난수 구현
	 final char[] characters =
		    {'1','2','3','4','5','6','7','8','9','0','A','B','C','D','E','F',
		     'G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V',
		     'W','X','Y','Z'};
	 
	 Random random = new Random();
	 
	 StringBuffer buf = new StringBuffer(8);//8자리 난수를 저장할 버퍼
	   
     for (int i= 0; i < 8; i++) {
    	buf.append(characters[random.nextInt(characters.length)]);
     }
     checknum = buf.toString();
	
	String sender="jaewon915@naver.com";
	String receiver= email;
	String subject = "[인증 메일]";
	
	String content=  "인증번호는 ["+checknum +"] 입니다.";
	
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
		transport.connect(server,"jaewon915","udam5198");
		transport.sendMessage(message,message.getAllRecipients());
		transport.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
}
else{ 
	checknum = request.getParameter("checknum");
	if(checknum.equals(request.getParameter("number"))){
		%>
		<script type="text/javascript">
			alert("인증 완료");
			window.opener.document.fr.overlap2.value = '1';
			window.close();
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
			alert("인증 실패 !! \n\n새로운 인증번호를 전송했습니다.");
			location.href = "emailcheck.jsp?cbool=0&email=<%=email%>";
		</script>
		<%	
	}
}
%>

</head>
<body>
 <form action="emailcheck.jsp" method="post" class="form-horizontal" style="width: 80%; margin: auto ; margin-top: 20px;">
 
  <div class="form-group">
    <div>
      <input type="hidden" name ="email"  value="<%=email%>">
      <input type="hidden" name ="cbool"  value="1">
      <input type="hidden" name ="checknum" value="<%=checknum%>">
      <input type="text" class="form-control" name="number" id="number" placeholder="인증번호를 입력해주세요">
    </div>
  </div>
  
  <button class="btn btn-danger" type="submit" style="margin-left: 41%;">확인</button>
</form>

</body>
</html>