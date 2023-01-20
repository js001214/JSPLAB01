<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

	<!-- 필요한 라이브러리 Import  -->
<%@ page import = "java.sql.*, java.util.*, java.text.*" %>
	<!-- DB include -->
<%@ include file ="conn_oracle.jsp" %>
	<!-- form에서 넘어오는 값의 한글 처리 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- form에서 넘어오는 데이터는 모두 String으로 넘어온다.
	Integer.parseInt()
 -->
 
 <!--  form에서 넘어오는 변수의 값을 받아서 새로운 변수에 할당 -->
 <%
 String id = request.getParameter("id");
 String pw = request.getParameter("password");
 String na = request.getParameter("name");
 String em = request.getParameter("email");
 String ci = request.getParameter("city");
 String ph = request.getParameter("phone");
 
 int idx = 1;	//idx에 처음 값을 할당 할때 기본값으로 1 을 할당.
 				//다음부터는 테이블의 id 컬럼에서 Max값을 가져와서 +1해서 처리

 /*		out.println(id);
		out.println(pw);
		out.println(na);
		out.println(em);
		out.println(ci);
		out.println(ph);
 		if (true) return;
*/
 
 //날짜 처리
 /*
	 java.util.Date yymmdd = new java.util.Date();
	 out.println(yymmdd); //Thu Jan 12 11:17:13 KST 2023 19-01-01 16:37 오전
	 SimpleDateFormat myformat = new SimpleDateFormat ("yy-dd-d h:m a");
	 String ymd = myformat.format(yymmdd);
	 out.println(ymd);		//23-19-01 16:37 오전
 */
 //DB에 값을 처리할 변수 선언 : Connection <== Include 되어 있음.

 String sql = null;
 Statement stmt = null;	//sql을 실행하는 인스턴스
 PreparedStatement pstmt = null;	
 ResultSet rs = null;	//idx 컬럼의 최대값을 select
 
 
 try {
 //DB에서 값을 처리
 
	stmt = conn.createStatement(); //connection의 정보를 담은 객체, conn으로부터 Statement 인스턴스를 생성
	sql = "select max(idx) as idx from mbTbl";	//idx : Primary Key
	
	rs = stmt.executeQuery(sql);	//sql문을 실행하고 리턴타입 : ResultSet 형식의 결과를 리턴한다. 
	//쿼리 결과가 rs에 다긴다
		 
	//테이블의 idx 컬럼의 값을 적용 : 최대 값을 가져와서 + 1
 	if(!(rs.next())){
 		idx = 1;
 	}else {
 		idx = rs.getInt(1)+ 1;
 	}
 
 	//Statement 객체는 변수값을 처리하는 것이 복잡하다. PreparedStatement를 사용한다.
 	//form에서 넘겨받은 값을 DB에 insert하는 쿼리(주의 : masterid : id컬럼에 들어오는 값으로 처리해야함)
 	
 	sql = "insert into mbTbl(idx, id, password, name, email, city, phone)";
 	sql += "values (?,?,?,?,?,?,?)";
 


 	
 	//PreparedStatement 객체 생성
 		//객체 생성시 sql 구문을 넣는다.
 	pstmt = conn.prepareStatement(sql);
 	
 	//? 변수값을 할당
	pstmt.setInt(1, idx); 			
 	pstmt.setString(2, id);
 	pstmt.setString(3, pw);
 	pstmt.setString(4, na);
 	pstmt.setString(5, em);
 	pstmt.setString(6, ci);
 	pstmt.setString(7, ph);
 	
 	
 	pstmt.executeUpdate();	//pstmt를 실행하는 구문 //stmt와다르게 매개변수를 넣지않는다.


 	
 	// stmt.executeUpdate(sql);
 }catch(Exception e) {
	 out.println("예상치 못한 오류가 발생했습니다. <p/>");
	 out.println("고객 센터 : 02-1111-1111 <p/>");
	 e.printStackTrace();//만약 오류가 나면 어떤 오류가 나는지 알려준다.
 }finally {
	 if( conn != null) conn.close();
	 if( stmt != null) stmt.close();
	 if( rs != null) rs.close();
 }
 //Try carch 블락으로 프로그램이 종료 되지 않도록 처리후 객체 제거
 
 
 
 %>
 
 <!-- 
 	페이지 이동 :
 		response.sendRedirect : 클라이언트에서 페이지를 재요청 : URL 주소가 바뀜
		foward : 서버에서 페이지를 이동 : RUL 주소가 바뀌지 않는다. 
  -->
 
 <%// response.sendRedirect("list01.jsp"); %>
 
 <jsp:forward page ="list01.jsp">


 
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>