<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <SCRIPT language="javascript">                              
    function check(){                                         
     with(document.msgwrite){                      
      if(id.value.length == 0){                  
       alert("아이디를 입력해 주세요!!");                       
       id.focus();                           
       return false;                             
      }                                                                
      if(password.value.length == 0){              
       alert("비밀번호를 입력해주세요!!");              
       password.focus();                            
       return false;                               
      }
      if(name.value.length == 0){                   
          alert("이름을 입력해주세요!!");                  
          name.focus();                              
          return false;                                  
         }   
      if(email.value.length == 0){                    
       alert("이메일을 입력해주세요!!");                   
       email.focus();                         
       return false;                           
      }
      if(city.value.length == 0){
    	alert("도시를 입력해주세요!!");
    	city.focus();
      }
      if(phone.value.length == 0){
      	alert("전화번호를 입력해주세요!!");
      	phone.focus();
        }
      document.msgwrite.submit();                       
     }                                          
    }                                            
    </SCRIPT>

</head>
<body>
	<form name="msgwrite" method = "post" action = "save01.jsp"> 
	<table width="400"cellspacing="0" cellpadding="2">
	<tr>
	<td colspan="2" bgcolor="#1F4F8F" height="1"></td> 
	</tr>
	
	<tr>                                        
    <td colspan="2" bgcolor="#DFEDFF" height="20" class="notice">&nbsp;&nbsp;</td> 
    </tr>
    
    <tr>
    <td colspan="2" bgcolor="#1F4F8F" height="1"></td>
    </tr>
    
		<tr>
		<td width="250" height="10" align="center" bgcolor="#f4f4f4">아이디 :</td>
		<td width="300"  style="padding:0 30 0 30"><input type = "text" name = "id"></td>
		</tr>
		
		 <tr>
		 <td width="250" height="10" align="center" bgcolor="#f4f4f4">패스워드 :</td> 
		 <td width="494"  style="padding:0 0 0 10"><input type = "password" name = "password"></td>
		 </tr>	
		 
		 <tr>
		 <td width="250" height="10" align="center" bgcolor="#f4f4f4">이름 :</td> 
		 <td width="494"  style="padding:0 0 0 10"><input type = "text" name = "name"></td>
		 </tr>
		 
		 
		 <tr>
		 <td width="250" height="10" align="center" bgcolor="#f4f4f4">이메일 :</td> 
		 <td width="494"  style="padding:0 0 0 10"><input type = "text" name = "email"></td>
		 </tr>
		 
		 
		 <tr>
		 <td width="250" height="10" align="center" bgcolor="#f4f4f4">도시 :</td> 
		 <td width="494"  style="padding:0 0 0 10"><input type = "text" name = "city"></td>
		 </tr>
		 

		 
		 <tr>
		 <td width="250" height="10" align="center" bgcolor="#f4f4f4">전화번호 :</td> 
		 <td width="494"  style="padding:0 0 0 10"><input type = "text" name = "phone"></td>
		 </tr>
		 
		 
	<tr>
	<td colspan="2" bgcolor="#1F4F8F" height="1"></td> 
	</tr>
	
	<tr>                                        
    <td colspan="2" bgcolor="#DFEDFF" height="20" class="notice">&nbsp;&nbsp;</td> 
    </tr>
	
	<tr>
    <td colspan="2" bgcolor="#1F4F8F" height="1"></td>
    </tr>
	
	
	<tr>
	<td><a href="#" onClick="check();"><input type = "submit" values = "전송"></a></td>
	</tr>
	</table>
	</form>

</body>
</html>

