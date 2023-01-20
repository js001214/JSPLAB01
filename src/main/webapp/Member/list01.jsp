<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <!--  페이징 처리 부분 추가된  -->
<%@ page import = "java.sql.*" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UT-8">
<title>DB의 내용을 가져와서 출력 하기 </title>
</head>
<body>

<%@ include file = "conn_oracle.jsp" %>

<table width = "500" border="0"> 
  <tr align="center"> 
   <td colspan="10" height="3" bgcolor="#1F4F8F"></td>
  </tr>
  
	<tr align="center" bgcolor="#87E8FF" > 
		<td width="120" bgcolor="#DFEDFF"><font size="3">아이디</font></td>  
		<td width="100" bgcolor="#DFEDFF"><font size="3">비밀번호</font></td>   
		<td width="84" bgcolor="#DFEDFF"><font size="3">이름</font></td>   
		<td width="78" bgcolor="#DFEDFF"><font size="3">email</font></td> 
		<td width="49" bgcolor="#DFEDFF"><font size="3">city</font></td>	
		<td width="49" bgcolor="#DFEDFF"><font size="3">phone</font></td> 
	</tr>
	
	<tr align="center"> 
   	<td colspan="10" height="3" bgcolor="#1F4F8F" height="1"></td>
 	</tr>
 	
 	<!-- JSP 코드 블락 : DB의 레코드를 가져와서 루프 : 시작 -->
			
		<% 
		
		/* DB에서 값을 가져와서 Vector 컬렉션에 저장후 페이징 처리 */
			
		//Vector 변수 선언
		
		Vector keyidx = new Vector();	//DB의 idx컬럼의 값을 저장하는 vector
		Vector id = new Vector();
		Vector password = new Vector();
		Vector name	= new Vector();
		Vector email = new Vector();
		Vector city = new Vector();
		Vector phone =new Vector();
		
		//페이징을 처리할 변수 선언 <<<시작>>>
		
		int where = 1;		//현재 위치한 페이징 변수
		
		// where = Integer.parseInt(request.getParameter("where"));
		
		int totalgroup = 0;	//출력할 페이징의 총 그룹수
		int maxpages = 3;
		int startpage =1;
		int endpage = startpage + maxpages -1;
		int wheregroup = 1;	//현재 위치한 페이징 그룹
		
		//go : get방식으로 해당페이지 번호로 이동하도록 설정하는 변수
			//list01.jsp?go=1
		//gogroup : get 방식으로 해당 페이지 그룹으로 이동 하도록
			//list01.jsp?go=1&gogroup=2
			
		
		//go 변수를 넘겨 받아서 wheregroup, startpage, endpage 정보를 알아낼 수 있다.
			//코드 블락
		if(request.getParameter("go") != null ){ //list01.jsp?go=1
			where = Integer.parseInt(request.getParameter("go")); //go 변수의 값을 int로 바꿔서 할당한다.
			wheregroup = (where - 1) / maxpages + 1;	//현재 내가 속한 그룹을 알수 있다.
			startpage = (wheregroup - 1) * maxpages + 1;
			endpage = startpage + maxpages - 1;
			
		//gogroup 변수를 넘겨 받아서 startpage, endpage, where 의 정보를 알아낼 수 있다.
			//코드 블락
		}else if (request.getParameter("gogroup") != null){	//list01.jsp?gogroup=
			wheregroup = Integer.parseInt(request.getParameter("gogroup"));	//현재내가 위치한 그룹
			startpage = (wheregroup - 1) * maxpages + 1;
			where = startpage;
			endpage = startpage + maxpages-1;
		}
		
		int nextgroup = wheregroup +1;
		int priorgroup = wheregroup -1;
		
		int nextpage = where + 1;
		int priorgroup = wheregroup -1 ; 
		
		int nextpage = where + 1 ;    // where : 현재 내가 위치한 페이지
		int priorpage = where -1 ; 
		int startrow = 0; 			//하나의 page에서 레코드 시작 번호 
		int endrow = 0; 			//하나의 page에서 레코드 마지막 번호 
		int maxrow = 5; 			//한페이지 내에 출력할 행의 갯수 (row, 행,레코드 갯수)
		int totalrows = 0; 			// DB에서 select 한 총 레코드 갯수 
		int totalpages = 0 ; 		// 총 페이지 갯수 
		
		// <<페이징 처리할 변수 선언 끝>>
		
		int idx = 0;	//DB의 idx 컬럼의 값을 가져오는 변수 
		String em = null; //DB에서 mail 주소를 가져와서 처리하는 변수
		
		//SQL 쿼리를 보낼 
		String sql = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		//리스트 페이지에서 답변글 처리의 출력을 하기 위한 쿼리
		sql = " select * from mbTbl order by idx desc";
			
		
		%>
		
		

</table>

</body>
</html>