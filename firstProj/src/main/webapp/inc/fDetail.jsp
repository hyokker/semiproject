<%@page import="com.semi.common.Utility"%>
<%@page import="com.semi.freeboard.model.FreeBoardVO"%>
<%@page import="com.semi.freeboard.model.FreeBoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
   //list.jsp에서 get방식으로 이동
   //=> http://192.168.0.100:9090/herbmall/board/detail.jsp?no=2
   //1
   String no=request.getParameter("no");
   if(no==null || no.isEmpty()){%>
      <script type="text/javascript">
         alert('잘못된 url입니다.');
         location.href="freeBoard.jsp";
      </script>
      
   <%   return;
   }
   
   //2
   FreeBoardDAO dao = new FreeBoardDAO();
   FreeBoardVO vo=null;
   try{
      vo=dao.selectByNo(Integer.parseInt(no));   
   }catch(SQLException e){
      e.printStackTrace();
   }
   
   //3
   String content=vo.getContent();
   if(content!=null && !content.isEmpty()){
      content=content.replace("\r\n", "<br>");
   }else{
      content="";
   }
   
   	
	String fileInfo="", downInfo="";
	String fileName=vo.getOriginalFileName();
	if(fileName!=null && !fileName.isEmpty()){
		fileInfo=Utility.getFileInfo(fileName, vo.getFileSize());
		downInfo="다운 : " + vo.getDownCount();
	}
   
%> 
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>자유게시판 상세보기 - 허브몰</title>
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<link rel="stylesheet" type="text/css" href="../css/clear.css" />
<link rel="stylesheet" type="text/css" href="../css/formLayout.css" />
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<style type="text/css">
   body{
      padding:5px;
      margin:5px;
    }
   .divForm {
      width: 500px;
      }
</style>  
</head>
<body>
   <h2>글 상세보기</h2>
   <div class="divForm">
      <div class="firstDiv">
         <span class="sp1">제목</span> <span><%=vo.getTitle() %></span>
      </div>
      <div>
         <span class="sp1">작성자</span> <span><%=vo.getName() %></span>
      </div>
      <div>
         <span class="sp1">등록일</span> <span><%=vo.getRegdate() %></span>
      </div>
      <div>
         <span class="sp1">조회수</span> <span><%=vo.getReadcount() %></span>
      </div>
      <span class="sp1">첨부파일</span> 
			<span>
				<a href
="downCount.jsp?no=<%=no%>&fileName=<%=vo.getFileName()%>&originalFileName=<%=vo.getOriginalFileName()%>">
					<%=fileInfo %>
				</a>
			</span>
			<span><%=downInfo %></span>
		</div>
      
      <hr><hr>
      <div class="lastDiv">         
         <p class="content"><%=content %></p>
      </div>
      <div class="center">
         <a href='fEdit.jsp?no=<%=no%>'>수정</a> |
           <a href='fDelete.jsp?no=<%=no%>'>삭제</a> |
           <a href='freeBoard.jsp'>목록</a>         
      </div>
   </div>

   
</body>
</html>