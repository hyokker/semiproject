<%@page import="com.semi.common.PagingVO"%>
<%@page import="com.semi.freeboard.model.FreeBoardVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<jsp:useBean id="boardService" class="com.semi.freeboard.model.BoardService" scope="session"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
	String condition=request.getParameter("searchCondition");
	String keyword=request.getParameter("searchKeyword");	
	
	//2
	List<FreeBoardVO> list = null;
	try{
		list=boardService.selectAll(condition,keyword);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	int currentPage=1; //현재 페이지
	
	
	if(request.getParameter("currentPage")!=null){
 		currentPage=Integer.parseInt((request.getParameter("currentPage")));
	}
	
	int totalRecord=list.size(); //총 레코드 수
	int pageSize=5; //한 페이지에 보여줄 레코드 
	int blockSize=5; //블록당 보여줄 페이지 수
	
	PagingVO pvo= new PagingVO(currentPage,totalRecord,pageSize,blockSize);
	
	if(keyword==null) keyword="";
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
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
.divSearch {text-align: center;padding: 5px;margin: 5px;}
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
	width: 60%;
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

.divsearch{
	text-align: center;
}
.divBtn {
	text-align: center;
}
.divPage {text-align: center;}
</style>
<title>자유게시판</title>
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
<%if(keyword!=null&&!keyword.isEmpty()){ %>
	<p>검색어 :<%=keyword %>, <%=list.size() %>건 검색되었습니다.</p>
	
	<%} %>

<h2>자유게시판 입니다</h2>


<div class="divList">
<table class="box2"
	 	summary="기본 게시판에 관한 표로써, 번호, 제목, 작성자, 작성일, 조회수에 대한 정보를 제공합니다.">
	<colgroup>
		<col style="width:10%;" />
		<col style="width:30%;" />
		<col style="width:15%;" />
		<col style="width:15%;" />
		<col style="width:10%;" />		
	</colgroup>
	<thead>
	  <tr>
	    <th scope="col">번호</th>
	    <th scope="col">제목</th>
	    <th scope="col">작성자</th>
	    <th scope="col">작성일</th>
	    <th scope="col">조회수</th>
	  </tr>
	</thead> 
	<tbody>  
	<%if(list.isEmpty()){%>
		<tr>
			<td colspan="5" class="align_center">해당 글이 존재하지 않습니다.</td>
		</tr>
		<% }else{%>
		
	  <!--게시판 내용 반복문 시작  -->	
	  <%
	  int num=pvo.getNum();
	  int curPos=pvo.getCurPos();
	  
	  for(int i=0;i<pvo.getPageSize();i++){ 
		  	if(num-- <1) break;
		  	
	  		FreeBoardVO vo = list.get(curPos++);
	  %>
			<tr style="text-align:center">
				<td><%=vo.getNo() %></td>
				<td style="text-align:left">
					<a href="countUpdate.jsp?no=<%=vo.getNo()%>">
				<%=vo.getTitle() %>
					</a>
				</td>
				<td><%=vo.getName() %></td>
				<td><%=sdf.format(vo.getRegdate()) %></td>
				<td><%=vo.getReadcount() %></td>
			</tr>
		<%}//for %>
	<%} %>
	 
	  <!--반복처리 끝  -->

	 </tbody>
</table>	   
</div>
<div class="divPage">
		<!-- 이전블럭으로 이동 -->
	<%
		if(pvo.getFirstPage()>1){%>
			<a href="freeBoard.jsp?currentPage=<%=pvo.getFirstPage()-1 %>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
				<img src="../images/btn_first.gif">
			</a>	
	<%} %>
	<!-- 페이지 번호 추가 -->						
	<!-- [1][2][3][4][5][6][7][8][9][10] -->
	
	<%
		for(int i=pvo.getFirstPage();i<=pvo.getLastPage();i++){
			if(i>pvo.getTotalPage()) break;
		
		if(i==currentPage){%>
			<span style="color: blue;font-weight: bold;font-size: 1em">
			<%=i %></span>
		<%}else{ %>
		<a href
	='freeBoard.jsp?currentPage=<%=i%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>'>
					[<%=i %>]</a>
			<%} %>		
	<%	} %>
	<!--  페이지 번호 끝 -->
	
	<!-- 다음 블럭으로 이동 -->
	<%
		if(pvo.getLastPage() < pvo.getTotalPage()){ %>
			<a href='freeBoard.jsp?currentPage=<%=pvo.getLastPage()+1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>'>
				<img src='../images/btn_next.gif'>
			</a>	
	<%	} %>
</div>
<div class="divSearch">
   	<form name="frmSearch" method="post" action='freeBoard.jsp'>
        <select name="searchCondition">
            <option value="title"
            <% if("title".equals(condition)){%>
            	selected="selected"
            <%} %>
            >제목</option>
            <option value="content"
            <% if("content".equals(condition)){%>
            	selected="selected"
            <%} %>
            >내용</option>
            <option value="name"
            <% if("name".equals(condition)){%>
            	selected="selected"
            <%} %>
            >작성자</option>
        </select>   
        <input type="text" name="searchKeyword" title="검색어 입력하세요"
        	value="<%=keyword%>">   
		<input type="submit" value="검색">
    </form>
</div>
<div class="divBtn">
    <a href='fWrite.jsp' >글쓰기</a>
</div>
<%@ include file="footer.jsp"%>

    