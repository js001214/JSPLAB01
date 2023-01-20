<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page language="java" import="java.sql.*" %>
<%@ include file ="conn_oracle.jsp" %>

<%
	//DB 접근시 기본 변수 선언
	String sql = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	int idx = Integer.parseInt(request.getParameter("idx"));
	String p = request.getParameter("page");
	
	/*
	out.println(idx + "<p/>");
	out.println(p);

	if (true) return;
	*/
	
	try {
		sql = "select * from guestlab where idx=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,idx);
		rs = pstmt.executeQuery();
		
		//rs의 값이 잘 가져왔을때
		
		if(!(rs.next())){
			//값이 없을때
			out.println("해당 내용이 DataBase에 존재 하지 않습니다.");
		}else {
			//값이 있을때
		
		
	

%>
<HTML>
<HEAD>
<SCRIPT language="javascript">
function check() {
 with(document.msgwrite){			
  if(email.value.length == 0){
   alert("메일을 입력 해주세요!");
   email.focus();
   return false;
  }
  if(phone.value.length == 0){
   alert("번호를 입력해 주세요!!");
   phone.focus();
   return false;
  }
  if(gender.value.length == 0){
   alert("성별을 입력해 주세요!!");
   gender.focus();
   return false;
  }
  if(address.value.length == 0){
   alert("주소를 입력해주세요!!");
   address.focus();
   return false;
  }
  document.msgwrite.submit();
 }
}
</SCRIPT> 
<link href="filegb.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>


<P>

<FORM name="msgwrite" method=POST action="guestlab_upddb.jsp">
	<input type="hidden" name = "idx" value = "<%=idx%>">
	<input type="hidden" name = "page" value = "<%=p%>">
	
	
 <table width="600" cellspacing="0" cellpadding="2" align = "center">
  <tr> 
   <td colspan="2" bgcolor="#1F4F8F" height="1"></td>
  </tr>
  <tr> 
   <td colspan="2" bgcolor="#DFEDFF" height="20" class="notice">&nbsp;&nbsp;<font size="2">글 수정하기</font></td>
  </tr>
  <tr> 
   <td colspan="2" bgcolor="#1F4F8F" height="1"></td>
  </tr>
  <tr> 
   <td width="124" height="30" align="center" bgcolor="#f4f4f4">메 일</td>
   <td width="494"  style="padding:0 0 0 10"> 
    <input type=text name=email value="<%= rs.getString("email") %>" class="input_style1">
   </td>
  </tr>
  <tr> 
   <td width="124" align="center"  bgcolor="#f4f4f4">폰</td>
   <td width="494" style="padding:0 0 0 10" height="25"> 
    <input type=text name=phone value="<%= rs.getString("phone") %>" class="input_style1">
   </td>
  </tr>
  <tr> 
   <td width="124" align="center"  bgcolor="#f4f4f4">성별</td>
   <td width="494" style="padding:0 0 0 10" height="25"> 
    <input type=text name=gender size="60" value="<%= rs.getString("gender") %>" class="input_style2">
   </td>
  </tr>
  <tr> 
   <td width="124" height="162" align="center" valign="top" bgcolor="#f4f4f4" style="padding-top:7;">주소</td>
   <td width="494" valign="top"  style="padding:5 0 5 10"> 
    <textarea name=address cols="65" rows="10" class="textarea_style1">
    	<%= rs.getString("address") %>
     </textarea>
   </td>
  </tr>
  <tr> 
   <td width="124" align="center"  bgcolor="#f4f4f4">암 호</td>
   <td width="494" style="padding:0 0 0 10" height="25"> 
    <input type='password' name='password'  class="input_style1"><br>(정확한 비밀번호를 입력해야만 수정이 됩니다.)
   </td>
  </tr>
  <tr> 
   <td colspan="2" height="1" class='button'></td>
  </tr>
  <tr> 
   <td colspan="2" height="1" bgcolor="#1F4F8F"></td>
  </tr>
  <tr> 
   <td colspan="2" height="10"></td>
  </tr>
  <tr> 
   <td colspan="2" align="right"> 
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
     <tr> 
      <td width="64%">&nbsp;</td>
      <td width="12%"><a href="#" onClick="check()"><img src="image/ok.gif" border="0"></a></td>
      <td width="12%"><a href="#" onClick="history.go(-1)"><img src="image/cancle.gif"  border="0"></a></td>
      <td width="12%"><A href="guestlab_list.jsp?go=<%= request.getParameter("page")%>"> <img src="image/list.jpg" border=0></a></td>
     </tr>
    </table>
   </td>
  </tr>
 </table>
</FORM>

<%
	}	//if 문 종료

}catch (Exception e){
		
		// e.printStackTrace();	//디버깅
	}finally {
		if (conn != null) conn.close();
		if (stmt != null) stmt.close();
		if (pstmt != null) pstmt.close();
		if (rs != null) rs.close();
	}


%>

</BODY>
</HTML>