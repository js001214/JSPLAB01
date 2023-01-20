<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update 를 통한 데이터 수정 </title>
</head>
<body>

	<form method = "post" action = "update01_process.jsp"> 
		<p> 아이디 : <input type = "text" name = "id">
		<p> 패스워드 : <input type = "password" name = "passwd"> 
		<p> 이름 : <input type = "text" name = "name"> 
		<p> 이메일 : <input type = "text" name = "email">
		<p> <input type = "submit" value = "전송"> 
	
	</form>

</body>
</html>