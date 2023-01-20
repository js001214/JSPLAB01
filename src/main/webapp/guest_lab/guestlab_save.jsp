<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!-- 사용할 클래스를 해당 패키지에서 import -->
    <%@ page import = "java.sql.*, java.util.*" %>

<!-- 클라이언트에서 유니코드를 UTF-8로 처리 해야함 (MVC Model 1)  -->
<!-- JSP에서 내장 객체 : Import없이 사용가능 한 객체
	 request 객체 : 클라이언트에서 넘겨주는 정보를 서버에서 받아서 처리, 
	 response 객체 : 서버에서  클라이언트에게 정보를 처리하는 객체 -->

<% request.setCharacterEncoding("UTF-8"); %>

<!-- DB를 접속하는 파일을 include 해서 사용 -->
<%@ include file = "conn_oracle.jsp" %>

<!--  품에서 넘겨주는 변수와 값을 받아서 저장 : request.getParameter("변수명"); -->
<%
	String idx = request.getParameter("idx");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String gender = request.getParameter("gender");
	String address = request.getParameter("address");
%>
<!--품에서 넘긴 변수를 출력후 주석 처리 -->
<%
//	out.println("na 변수의 담긴 값 : " + na + "<p/>");
	//out.println("em 변수의 담긴 값 : " + em + "<p/>");
	//out.println("sub 변수의 담긴 값 : " + sub + "<p/>");
	//out.println("cont 변수의 담긴 값 : " + cont + "<p/>");
	//out.println("ymd 변수에 담긴 값 : " + ymd + "<p/>");
	
%>

<%= "id 변수의 담긴 값 : " + idx + "<p/>" %>

<!--  변수에 넘어오는 값을 SQL 쿼리에 담아서 DB에 저장 -->

<%
String sql = null;	//sql <== SQL 쿼리를 담는 변수
Statement stmt = null ; //SQL 쿼리를 DB에 적용하는 객체

//Connection 객체에서 conn.createStatement() 메소드를 써서 stmt 객체에 할당.
stmt = conn.createStatement();

sql = "insert into guestlab(idx, email, phone, gender, address)";
sql = sql + "values ('" + idx + "','" + email + "','" + phone + "','" + gender + "','" + address + "')";

//out.println(sql);



//Statement 객체나 PreparedStatement 객체를 사용해서 Insert/Update/Delete
//저장할 경우 commit는 자동으로 처리됨.

int cnt = 0; // sql 쿼리가 잘 처리되었는 지 확인 변수 

//Statement 객체가 sql 쿼리를 실행해서 DB에 저장

cnt = stmt.executeUpdate(sql);

//stmt.executeUpdate(sql); // Statement 객체의 excuteUpdate(sql) : insert, update, delete
//stmt.executeQuery(sql); // Statement 객체의 executeQuery(sql) : selet
		// Recordest 객체로 리턴을 시켜줌 : select한 결과를 담은 객체

//out.println(cnt);
if(cnt > 0){
	out.println("DB에 잘 insert 되었습니다.");
} else {
	out.println("DB에 저장을 실패했습니다.");
}


%>

<jsp:forward page ="guestlab_list.jsp"/>