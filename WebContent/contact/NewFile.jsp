<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>ex1</title>
<script language="javascript">

function conf(){

    if (confirm("정말로 삭제하시겠습니까?")) {

            alert("성공");

        } else {

            history(-1);

        }

    }
</script>
</head>

<body bgcolor=white>
<a href="javascript:conf();">[분기]</a> &nbsp;&nbsp;
</body>

</html>


