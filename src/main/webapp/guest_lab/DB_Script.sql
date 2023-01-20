
/* Oracle XE DataBase에서 Table생성 */

Create Table guestlab (

	idx varchar2(200) Primary Key,
	ename varchar2(200),
	phone varchar2(200),
	gender varchar2(200),
	addr varchar2(200)
	);
/*							Read페이지 만들고 삭제 수정 페이지
	guestlab_list.jsp	<== 폰번호에 read.jsp?id=변수&page=변수 폰번호
	=========================================
	번호		메일		폰			성별		주소
	=========================================
	30	aaa@com 010-1111-1111   남자 		서울
	19	aaa@com 010-1111-1111   남자 		서울
	18	aaa@com 010-1111-1111   남자 		서울
	17	aaa@com 010-1111-1111   남자 		서울
	16	aaa@com 010-1111-1111   남자 		서울		 
			 
	=========================================
	[처음][이전] 1 2 3 4 5 [다음][마지막]
	
	
	
	
	guestlab_list에 search기능
	search 페이지에서 페이징 처리
			 
*/
	
	
/*
 
 guestlab_show.jsp		//rs에서 값을 가져와서 출력
 guestlab_show02.jsp	//rs의 값을 Vector에 저장후 출력
 guestlab_show03.jsp	//rs의 값을 ArrayList에 저장후 출력
 
 */	
	
/*
  1. WEB-INF\lib 라이브러리 넣어야함
  2. Oracle DB 연결 설정	
  3. 폼페이지를 생성 해야함. guestlab_write.html
  4. form에서 action을 처리하는 페이지 생성. guestlab_save.jsp
  		폼에서 넣는 값을 받아서 DB에 저장하는 페이지
  		
  */
	