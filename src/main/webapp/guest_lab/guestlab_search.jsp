<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,java.util.*" %> 
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "conn_oracle.jsp" %>

<HTML>
<HEAD><TITLE>게시판(검색모드)</TITLE>
</HEAD>
<BODY>

<P>
<P align=center>
 <FONT color=#0000ff face=굴림 size=3>
 <STRONG>자유 게시판(검색모드)</STRONG>
 </FONT>
</P> 
<FORM method=post name=search action="guestlab_search.jsp">
 <TABLE border=0 width=95%>
  <TR>
   <TD align=left width=30% valign=bottom>
    [<A href="freeboard_list3.jsp">자유 게시판(일반모드)</A>]</TD>
   <TD align=right width=70% valign=bottom>
    <FONT size=2 face=굴림>
     <SELECT name=stype >
        <!--   stype 에 넘어오는 value 값에 따라서 다르게 출력
       <SELECT name=stype >
    <OPTION value=1 >email
    <OPTION value=2 >phone
    <OPTION value=3 >gender
    <OPTION value=4 >email+phone
    <OPTION value=5 >email+gender
    <OPTION value=6 >phone+gender
    <OPTION value=7 >email+phone+gender
   </SELECT>
        -->
<% 
      //jsp 코드 블락 : <option> 넘어오는 변수에 따라서 해당 내용을 출력
      String cond = null;    //SQL 쿼리를 담는 변수 : stype : 1
      int what = 1;         //stype 에 넘어오는 변수를 int 형으로 변환해서 담는 변수
         //2 : 제목, 3 : 내용, 4 : 이름 + 제목, ...
      String val = null; // sval 에서 넘어오는 검색어를 담는 변수
      
      what = Integer.parseInt(request.getParameter("stype"));   //옵션
      val = request.getParameter("sval");   //검색어
      
      
      if (what == 1){
          out.println("<OPTION value=1 selected >번호 </OPTION>");
          cond = "where idx like'%"+ val + "%'";
       }else {
          out.println("<OPTION value=1 >번호 </OPTION>");
       }
       
       if (what == 2){
          out.println("<OPTION value=2 selected>이메일 </OPTION>");
          cond = "where email like'%"+ val + "%'";
       }else {
          out.println("<OPTION value=2 >이메일 </OPTION>");
       }
       
       if (what == 3){
          out.println("<OPTION value=3 selected >폰 </OPTION>");
          cond = "where phone like'%"+ val + "%'";
       }else {
          out.println("<OPTION value=3 >폰 </OPTION>");
       }
       
       if (what == 4){
          out.println("<OPTION value=4 selected >성별 </OPTION>");
          cond = "where gender like'%" + val +"%'";
       }else {
          out.println("<OPTION value=4 >성별 </OPTION>");
       }
       
       if (what == 5){
          out.println("<OPTION value=5 selected >주소 </OPTION>");
          cond = "where address like '%" + val +"%'";
       }else {
          out.println("<OPTION value=5 >주소 </OPTION>");
       }
       
       if (what == 6){
          out.println("<OPTION value=6 selected >성별+주소 </OPTION>");
          cond = "where gender like'%"+ val + "%' or address like '%" + val + "%'";
       }else {
          out.println("<OPTION value=6 >성별+주소 </OPTION>");
       }
       
       if (what == 7){
          out.println("<OPTION value=7 selected >성별+주소+이메일 </OPTION>");
          cond = "where gender like'%"+ val + "%' or address like '%" + val + "%'";
          cond += " or email like '%" + val + "%'";
       }else {
          out.println("<OPTION value=7 >성별+주소+이메일 </OPTION>");
       }

      
      
      
      
%>
     </SELECT>
   </FONT>
    <INPUT type=text name="sval" value="<%=request.getParameter("sval")%>">
    <INPUT type=submit value="검색">
   </TD>
  </TR>
 </TABLE>
</FORM>
<CENTER>

<%
/*
out.println(what + "<p/>");
out.println(val + "<p/>");
if(true) return;
*/

%>
<TABLE border=0 width=600 cellpadding=4 cellspacing=0>
 <tr align="center"> 
  <td colspan="5" height="1" bgcolor="#1F4F8F"></td>
 </tr>
 <tr align="center" bgcolor="#87E8FF"> 
  <td width="42" bgcolor="#DFEDFF"><font size="2">idx</font></td>
  <td width="340" bgcolor="#DFEDFF"><font size="2">email</font></td>
  <td width="84" bgcolor="#DFEDFF"><font size="2">phone</font></td>
  <td width="78" bgcolor="#DFEDFF"><font size="2">gender</font></td>
  <td width="49" bgcolor="#DFEDFF"><font size="2">address</font></td>
 </tr>
 <tr align="center"> 
  <td colspan="5" bgcolor="#1F4F8F" height="1"></td>
 </tr>
 <%   
    Vector email = new Vector();    //name 컬럼의 모든값을 저장하는 vector  
   Vector phone = new Vector();
   Vector gender = new Vector();
   Vector addr = new Vector();
   Vector keyid = new Vector();      //DB의 id컬럼의 값을 저장하는 vector
   
   
   // 페이징을 처리할 변수 선언  <<<시작>>> 
   
   int where = 1;          //현재 위치한 페이징 변수 
   
   //  where = Integer.parseInt(request.getParameter("where"));  
      
   int totalgroup = 0 ;       //출력할 페이징의 총 그룹수  
   int maxpages = 5;          //하단의 페이지 출력 부분에서 출력할 최대 페이지 갯수 
   int startpage = 1; 
   int endpage = startpage + maxpages -1 ; 
   int wheregroup = 1;       //현재 위치한 페이징 그룹 
   
   //go  : get 방식으로 해당 페이지 번호로 이동 하도록 설정하는 변수 
      //freeboard_list03.jsp?go=3 
   //gogroup  : get 방식으로 해당 페이지 그룹으로 이동 하도록 
      //freeboard_list03.jsp?go=3&gogroup=2    
   
   //go 변수 를 넘겨 받아서 wheregroup, startpage, endpage 정보를 알아낼 수 있다. 
      //코드 블락
   if (request.getParameter("go") != null ){   // freeboard_list03.jsp?go=3
      where = Integer.parseInt(request.getParameter("go"));  // go 변수의 값을 where변수에 할당
      wheregroup = (where - 1) / maxpages + 1 ;  //현재 내가 속한 그룹을 알수 있다.
      startpage = (wheregroup - 1) * maxpages +1 ; 
      endpage = startpage + maxpages -1 ; 
   
      
   //gogroup 변수를 넘겨 받아서 startpage, endpage, where 의 정보를 알아낼 수 있다. 
      //코드 블락 
   }else if (request.getParameter("gogroup") != null){  //freeboard_list03.jsp?gogroup= 
      wheregroup = Integer.parseInt(request.getParameter("gogroup"));  //현재내가 위치한 그룹
      startpage = (wheregroup - 1) * maxpages +1 ; 
      where = startpage; 
      endpage = startpage + maxpages -1;  
   }
   
   int nextgroup = wheregroup +1 ; 
   int priorgroup = wheregroup -1 ; 
   
   int nextpage = where + 1 ;    // where : 현재 내가 위치한 페이지
   int priorpage = where -1 ; 
   int startrow = 0;          //하나의 page에서 레코드 시작 번호 
   int endrow = 0;          //하나의 page에서 레코드 마지막 번호 
   int maxrow = 2;          //한페이지 내에 출력할 행의 갯수 (row, 행,레코드 갯수)
   int totalrows = 0;          // DB에서 select 한 총 레코드 갯수 
   int totalpages = 0 ;       // 총 페이지 갯수 
   
   // <<<페이징 처리할 변수 선언 끝>>>
   
   
   int id = 0 ;    // DB의  id 컬럼의 값을 가져오는 변수 
   String em = null ;    //DB에서 mail 주소를 가져와서 처리하는 변수 
 
 //검색된 내용을 출력하는 블락
    String sql = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    //cond : option 에 선택자에 따라서 다른 쿼리가 변수로 들어옴
    sql = "select * from guestlab " + cond;
    sql += " order by idx desc";
    
    /*
    out.println(sql);
    if(true) return;
    */
    
    stmt = conn.createStatement();
    rs = stmt.executeQuery(sql);
    
    if(!(rs.next())){
       out.println("not exist in DB");
    }else{   //검색이 되었다면
       
      do {
         
         //정수 형으로 변환 필요: id , readcount, step 컬럼은 DB에서 값을 가져와서 정수형으로 변환 
         keyid.addElement(rs.getString("idx"));    
         email.addElement(rs.getString("email")); 
         phone.addElement(rs.getString("phone")); 
         gender.addElement(rs.getString("gender")); 
         addr.addElement(rs.getString("address")); 
            
         } while  (rs.next());    
      }
      
      totalrows = email.size();       //DB에서 가져온 총 레코드 갯수 
      totalpages = (totalrows-1) / maxrow + 1;    // 전체 페이지 갯수 출력 
      startrow = (where - 1) * maxrow ;       //해당 페이지에서 Vector의 방번호 : 시작
      endrow = startrow + maxrow - 1 ;       //해당 페이지에서 Vector의 방번호 : 마지막
      
      totalgroup = (totalpages -1) / maxpages + 1 ; 
         // 전체 페이지 그룹, 하단에 출력할 페이지 갯수(5개)의 그룹핑   
      
      
      //endrow 가 totalrows보다 크면 totalrows -1로 처리해야함.
      if ( endrow >= totalrows) {
         endrow = totalrows -1 ; 
      }
      if (endpage > totalpages){
         endpage = totalpages; 
      }
      
      
      
      // 페이징 변수 출력 
      /*
      out.println ( "<p/> 총 레코드 갯수 (totalrows : ) : " + totalrows + "<p/>" ); 
      out.println ( "<p/> 전체 페이지 수 (totalpage : ) : " + totalpages + "<p/>" ); 
      out.println ( "<p/> 시작 row 갯수 (startrow : ) : " + startrow + "<p/>" ); 
      out.println ( "<p/> 마지막 row 갯수 (endrow : ) : " + endrow + "<p/>" ); 
      */
           // 프로그램 멈춤 
      
      
      
      //if (true) return;
      
      
   //행당 페이지를 처리하면서 해당 페이지에 대한 내용을 출력 (rs의 값을 vector에 저장했으므로 for )
   for ( int j = startrow ; j <= endrow ; j++){
   
   
   %>

  <tr>
     <td> <%= keyid.elementAt(j) %> </td>
     <td> <%= email.elementAt(j) %></td>
     <td> <%= phone.elementAt(j) %></td>
     <td> <%= gender.elementAt(j) %></td>
     <td> <%= addr.elementAt(j) %></td>
  </tr>
  
  <%
   }
  
 %>

</TABLE>

<%

//  [처음][이전]
if (wheregroup > 1){    //현재 나의 그룹이 1 이상일때 처음
   out.println ("[<a href='guestlab_search.jsp?gogroup=1'>처음</a>]");
   out.println ("[<a href='guestlab_search.jsp?gogroup="+priorgroup +"&stype="+what+"&sval="+val+"'>이전</a>]");
}else {         // 현재 나의 페이지 그룹이 1일때는 
   out.println ("[처음]"); 
   out.println ("[이전]"); 
}
//페이징 갯수를 출력 : 1 2 3 4 5 

if (email.size() != 0 ) {      //name.size() : 총 레코드의 갯수 가 0이 아니라면  
   for ( int jj = startpage; jj <= endpage ; jj++){
      if (jj == where) {      //jj 가 자신의 페이지 번호라면 링크 없이 출력
         out.println ("["+jj+"]"); 
      }else {      //jj가 현재 자신의 페이지 번호가 아니라면 링크를 걸어서 출력
         out.println ("[<a href=guestlab_search.jsp?go="+ jj +"&stype="+what+"&sval="+val+">" +jj+ "</a>]");
      }
   }
}

// [다음][마지막]
if (wheregroup < totalgroup ) {  //링크를 처리
   out.println ("[<A href=guestlab_search.jsp?gogroup="+ nextgroup +"&stype="+what+"&sval="+val+ ">다음</A>]"); 
   out.println ("[<A href=guestlab_search.jsp?gogroup="+ totalgroup +"&stype="+what+"&sval="+val+ ">마지막]</A>"); 
}else {  // 마지막 페이지에 왔을때 링크를 해지 
   out.println ("[다음]"); 
   out.println ("[마지막]"); 
}

out.println("전체 글수 : " + totalrows); 



%>
 
</BODY>
</HTML>