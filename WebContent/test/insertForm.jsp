<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메일인증 입력프로그램</title>

<script type="text/javascript">
function emailcheck(){
	//새창의 크기
	cw=400;
	ch=150;
	
	//스크린의 크기
	sw=screen.availWidth;
	sh=screen.availHeight;

	//열 창의 포지션
	px=(sw-cw)/2;
	py=(sh-ch)/2-200;
			
	var email = document.fr.email.value;
	
	if(email == ""){alert("입력 된 이메일이 없습니다.");}
	else{
	window.open("./emailcheck.jsp?email="+email+"&cbool=0","",'left='+px+',top='+py+',width='+cw+',height='+ch+',toolbar=no,menubar=no,status=no,scrollbars=no,resizable=no');
	}

}

</script>
</head>
<body>
		
		      <div class="modal-body">
	            
	            <div class="page-header">
       			   <h1>회원가입 </h1>
        		</div>

          		<form role="form" name="fr" method="post" action="/homepage/MyHomePage/member/insertPro.jsp"
          			  onsubmit="return check();" enctype="multipart/form-data">
		           
		           <input type="hidden" name="overlap" value="0">
		           <input type="hidden" name="overlap2" value="0">
		            
		            <div class="form-group">
		              <label for="userEmail">이메일</label>
		              <div class="input-group">
		           
		                 <input type="email" class="form-control" name="email" id="userEmail" placeholder="이메일을 입력해 주세요">
		                <span class="input-group-btn">
		                  <button type="button" class="btn btn-success" onclick="emailcheck()">인증번호 전송</button>
		                </span>
		              </div>
		            </div>
		            
		            <div class="form-group text-center" >
		              <button type="submit" class="btn btn-info" >회원가입</button>
		              <button type="button" class="btn btn-warning"  data-dismiss="modal">가입취소</button>
		            </div>
         	 </form>
    			
		   </div>

</body>
</html>