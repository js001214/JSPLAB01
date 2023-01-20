<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import ="java.sql.*" %>
<%@ include file = "conn_oracle.jsp" %>
<% request.setCharacterEncoding("UTF-8");%>

<%
int idx = Integer.parseInt(request.getParameter("idx"));
String p = request.getParameter("page");	


// 폼에서 수정되어 넘어오는 변수의 값을 재 할당

String id = request.getParameter("idx");
String em = request.getParameter("email");
String ph = request.getParameter("phone");
String ge = request.getParameter("gender");
String ad = request.getParameter("address");



// out.println(id + "<p/>");
// out.println(p + "<p/>");

// if (true) return;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정된 내용을 DB에 저장하는 페이지</title>
</head>
<body>

[<A href = "guestlab_list.jsp?go=<%=p%>">게시판 목록으로</A>]

<%
	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//DB에서 해당 id에 대한 password를 가져와서 폼에서 전송된 password와 확인
	
	sql = "select * from guestlab where idx =?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, idx);
	rs = pstmt.executeQuery();
	
	try{
	
	//rs는 DB에서 password 필드의 값을 가져와서 폼에서 넘겨받은 password와 비교후 같으면 update
	if (!(rs.next())){ //rs의 값이 존재 하지 않을때
		out.println ("DB에 해당 내용이 존재하지 않습니다");
	}else {	//rs의 값이 존재 할때
		String pwd = rs.getString("email");
		//pwd : DB의 password
		//pw : Form에서 넘겨받은 password
		/*out.println ("<p/>"+ pwd + "<p/>");
		out.println(pw + "<p/>");
		out.println(pwd.equals(pw));	//두 값이 같으면 true, 다르면 false
		
		if(true) return;
		*/
		if(pwd.equals(em)){
			//update 진행
			sql = "update guestlab set email=?, phone=?,";
			sql += "gender=?, address=? where idx =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, em); //첫번째 ?는  na
			pstmt.setString(2, ph);
			pstmt.setString(3, ge);
			pstmt.setString(4, ad);
			pstmt.setInt(5, idx);
			
			pstmt.executeUpdate();
			
			out.println("<p/>내용이 잘 수정 되었습니다.");
			
		}else {
			//패스워드가 다릅니다 출력
			out.println("이메일이 일치 하지 않습니다.");
		}
		
	}
	
	}catch (Exception e){
		out.println("DB저장시 오류가 발생되었습니다.");
		e.printStackTrace();
		
	} finally {
		if(conn != null) conn.close();
		if(pstmt != null) pstmt.close();
		if(rs != null) rs.close();
	}

%>

</body>
</html>