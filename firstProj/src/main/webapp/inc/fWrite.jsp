<%@page import="com.semi.freeboard.model.FreeBoardDAO"%>
<%@page import="com.semi.freeboard.model.FreeBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	//[1] 글쓰기 :  list.jsp에서 [글쓰기]클릭하면 get방식으로 이동 
	//[2] 답변화면 : detail.jsp에서 [답변]클릭하면 get방식으로 이동
	//1
	String no=request.getParameter("no");
	
	FreeBoardVO vo=null;	
	boolean isReply=false;
	String url="", btLabel="";
	if(no!=null && !no.isEmpty()){
		isReply=true; //답변화면
		url="reply_ok.jsp";
		btLabel="답변";
		
		//2
		FreeBoardDAO dao=new FreeBoardDAO();
		try{
			vo=dao.selectByNo(Integer.parseInt(no));	
		}catch(SQLException e){
			e.printStackTrace();
		}
	}else{
		url="fWrite_ok.jsp";
		btLabel="등록";		
	}
	
	//3
%>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<link rel="stylesheet" type="text/css" href="../css/clear.css" />
<link rel="stylesheet" type="text/css" href="../css/formLayout.css" />
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />

<title>답변형게시판 
<%if(isReply){ %>
	답변하기
<%}else{ %>
	글쓰기
<%} %>
 - 허브몰</title>
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btList').click(function(){
			location.href = 'freeBoard.jsp';
		});
		
		$('form[name=frmWrite]').submit(function(){
			$('.infobox').each(function(idx, item){
				if($.trim($(this).val()).length<1){
					alert($(this).prev().text() + '을(를) 입력하세요');
					$(item).focus();
					event.preventDefault();
					return false;  //each 탈출
				}
			});			
		});
		
	});
</script>

</head>
<body>
<div class="divForm">
<form name="frmWrite" method="post" action="<%=url %>" 
	enctype="multipart/form-data">
	<%if(isReply){ %>
		<input type="text" name="groupNo" value="<%=vo.getGroupNo()%>">
		<input type="text" name="step" value="<%=vo.getStep()%>">
		<input type="text" name="sortNo" value="<%=vo.getSortNo()%>">
	<%} %>
 <fieldset>
	<legend><%if(isReply){ %>
				답변하기
			<%}else{ %>
				글쓰기
			<%} %>
	</legend>
        <div class="firstDiv">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" class="infobox" 
            	<%if(isReply){ %>
					value="Re : <%=vo.getTitle() %>"
				<%} %>
            />
        </div>
        <div>
            <label for="name">작성자</label>
            <input type="text" id="name" name="name" class="infobox"/>
        </div>
        <div>
            <label for="pwd">비밀번호</label>
            <input type="password" id="pwd" name="pwd" class="infobox"/>
        </div>
        <div>
            <label for="email">이메일</label>
            <input type="text" id="email" name="email" />
        </div>
        <div>  
        	<label for="content">내용</label>        
 			<textarea id="content" name="content" rows="12" cols="40"></textarea>
        </div>
        <div>
            <label for="upfile">첨부파일</label>
            <input type="file" id="upfile" name="upfile" />
            <span>(최대 2M)</span>
        </div>
        
        <div class="center">
            <input type = "submit" value="<%=btLabel%>"/>
            <input type = "Button" value="글목록" id="btList"/>         
        </div>
    </fieldset>
</form>
</div>   

              
</body>
</html>