<%@page import="com.semi.notice.model.noticeVO"%>
<%@page import="com.semi.notice.model.noticeDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String condition=request.getParameter("searchCondition");
	String keyword=request.getParameter("searchKeyword");	
	
	//2
	noticeDAO dao=new noticeDAO();

	List<noticeVO> list=null;
	try{
		list=dao.selectAll(condition, keyword);	
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	if(keyword==null) keyword="";
	//페이징 처리
		int currentPage=1;  //현재 페이지
		
		//list.jsp?currentPage=3
		if(request.getParameter("currentPage")!=null){
			currentPage=Integer.parseInt((request.getParameter("currentPage")));
		}
		
		//[1] 현재 페이지와 무관한 변수
		int totalRecord=list.size();  //총레코드 수  17
		int pageSize=5; //한 페이지에 보여줄 레코드(행) 수
		int totalPage=(int)Math.ceil((float)totalRecord/pageSize); //총 페이지 수
		int blockSize=10; //한 블럭에 보여줄 페이지 수

		//[2] 현재 페이지를 이용해서 계산하는 변수
		int	firstPage=currentPage-((currentPage-1)%blockSize); //블럭의 시작페이지
		//=> 1, 11, 21...
		int lastPage=firstPage+(blockSize-1); //블럭의 마지막 페이지, 10,20,30...
		
		//페이지당 ArrayList에서의 시작 index => 0, 5, 10, 15, 20…
		int curPos=(currentPage-1)*pageSize;
		//페이지당 글 리스트 시작 번호
		int num=totalRecord-curPos; //17,12,7..
		
%>

<!DOCTYPE HTML>
<html lang="ko">
<head>
<style type="text/css">
<style type="text/css">
body{
		padding:5px;
		margin:5px;
	 }	
table.box2 {
	border-collapse: collapse;
	border: 1px solid black;
	}
td,th{
	border:1px solid black;
}
th {
	text-align: center;
}

p#not {
	text-align: center;
	font-size: larger;
	font-weight: bold;
}
body, td, th, span, p{
	font-family: 'nanum gothic', 맑은 고딕, 한컴돋움, 돋움;
	font-size: 0.9em;
	color:#555555;
}
	
td, th{
	padding:4px;
}

a:link{color:#555555;text-decoration:none}
a:visited{color:#555555;text-decoration:none}
a:hover{color:#047CC1;text-decoration:underline;}
a:active{color:#047CC1;text-decoration:underline;}

input,Textarea, select {
    font-family:'nanum gothic', 맑은 고딕, 한컴돋움, 돋움;
	font-size: 0.9em;
	color:#555555;
}

table{
	margin: 0;
	padding: 0;
	border-collapse: collapse;
}

table.box, table.box2{
	margin-left: auto;
	margin-right:auto;
	/* margin: 0; */
	/* padding: 0; */
	border: solid silver 1px;
	border-collapse: collapse;
	width: 80%;
}

table.box2 th{
	background-color: #eeeeee;
	border: solid silver 1px;
}

table.box2 td{
	border: solid silver 1px;	
}

td.line
{
	border-bottom:solid 1px silver;
}

.divPage {text-align: center;}
</style>
<title>공지사항</title>
<meta charset="utf-8">
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">	
	$(function(){
		$('.divList table.box2 tbody tr').hover(function(){
			$(this).css('background','lightblue');
		}, function(){
			$(this).css('background','');
		});
	});
</script>
<style type="text/css">
	body{
		padding:5px;
		margin:5px;
	 }	
</style>	
</head>	
<body>
<h2>공지사항</h2>
<% if(keyword!=null && !keyword.isEmpty()){ %>
	<p>검색어 : <%=keyword %>, <%=list.size() %>건 검색되었습니다.</p>
<%} %>

<div class="divList">
<table class="box2"
	 	summary="기본 게시판에 관한 표로써, 번호, 제목, 작성자, 작성일, 조회수에 대한 정보를 제공합니다.">
	<colgroup>
		<col style="width:10%;" />
		<col style="width:15%;" />
		<col style="width:30%;" />
		<col style="width:15%;" />
		<col style="width:10%;" />		
	</colgroup>
	<thead>
	  <tr>
	    <th scope="col">번호</th>
	    <th scope="col">분류</th>
	    <th scope="col">제목</th>
	    <th scope="col">조회</th>
	    <th scope="col">작성일</th>
	  </tr>
	</thead> 
	<tbody>  
	<%if(list.isEmpty()){ %>
		<tr>
			<td colspan="5" class="align_center">해당 글이 존재하지 않습니다.</td>
		</tr>
	<%}else{ %>	
	  <!--게시판 내용 반복문 시작  -->	
	  <%for(int i=0;i<pageSize;i++){ 
		  	if(num-- <1) break;
		  	
	  		noticeVO vo = list.get(curPos++);
	  %>	
		<tr  style="text-align:center">
			<td><%=vo.getNtNo() %></td>
			<td><%=vo.getNtCate() %></td>
			<td style="text-align:left">
			<a href="countUpdate.jsp?no=<%=vo.getNtNo()%>">
				<%=vo.getNtTitle() %> </a></td>
			<td><%=vo.getNtNum() %></td>
			<td><%=sdf.format(vo.getNtRegdate()) %></td>
		</tr>
	  <%}//for %>	 
	  <!--반복처리 끝  -->
	 <%}//if %> 
	 </tbody>
</table>	   
</div>
<div class="divPage">
		<!-- 이전블럭으로 이동 -->
	<%
		if(firstPage>1){ %>
			<a href='noticeList.jsp?currentPage=<%=firstPage-1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>'>
				<img src='../images/first.JPG'>
			</a>	
	<%	} %>

	<!-- 페이지 번호 추가 -->						
	<!-- [1][2][3][4][5][6][7][8][9][10] -->
	<%
		for(int i=firstPage;i<=lastPage;i++){
			if(i>totalPage) break;  
			
			if(i==currentPage){	%>
				<span style="color: blue;font-weight: bold;font-size: 1em">
					<%=i %></span>
			<%}else{ %>
				<a href
	='noticeList.jsp?currentPage=<%=i%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>'>
					[<%=i %>]</a>
			<%} %>		
	<%	} %>
	<!--  페이지 번호 끝 -->
	
	<!-- 다음 블럭으로 이동 -->
	<%
		if(lastPage < totalPage){ %>
			<a href='noticeList.jsp?currentPage=<%=lastPage+1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>'>
				<img src='../images/last.JPG'>
			</a>	
	<%	} %>
</div>

</body>
</html>

    