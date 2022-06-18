<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.semi.song.model.SongVO"%>
<%@page import="com.semi.song.model.SongDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.semi.album.model.AlbumVO"%>
<%@page import="com.semi.album.model.AlbumDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
	<link rel="stylesheet" href="../css/main-style.css">
<%
	//요청파라미터 받아오기
	request.setCharacterEncoding("utf-8");

	String sno="1";
	
	//db작업
	AlbumDAO dao= new AlbumDAO();
	AlbumVO vo= new AlbumVO();
	try{
		vo=dao.showAlbumByNo(Integer.parseInt(sno));
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	
	SongDAO sDao = new SongDAO();
	SongVO sVo = new SongVO();
	List<SongVO> list= null;
	try{
		list=sDao.selectByNo(Integer.parseInt(sno));
	}catch(SQLException e){
		e.printStackTrace();
	}

	
	SimpleDateFormat sdf=new SimpleDateFormat("yy-MM-dd");
%>
	<section>
	<h1>앨범 상세보기</h1>
	<span><a href="../firstProj/albumlist.jsp">앨범 목록으로 돌아가기</a></span>
	<div class="divForm">
		<!--앨범 정보   -->
		<div class="Div2">
			<div>
				<span class="sp1">
				<!-- <img src="../img/albumImg/melomans.jpg"> -->
				<img src="<%=vo.getImgpath()+vo.getImg() %>">
				</span>
			</div>
			<div>
				<span class="sp1" style="font-weight: bold;">앨범번호 :</span> <span><%=sno%></span>
			</div>
			<div>
				<span class="sp1" style="font-weight: bold;">앨범명 :</span> <span><%=vo.getAname()%></span>
			</div>
			<div>
				<span class="sp1" style="font-weight: bold;">발매일 :</span> <span><%=sdf.format(vo.getOndate())%></span>
			</div>
			<div>
				<span class="sp1" style="font-weight: bold;">장르 :</span> <span><%=vo.getGenre()%></span>
			</div>
			<div>
				<span class="sp1" style="font-weight: bold;">발매사 :</span> <span><%=vo.getAgency()%></span>
			</div>
			<div>
				<span class="sp1" style="font-weight: bold;">기획사 :</span> <span><%=vo.getAcomp()%></span>
			</div>
			
		</div>
		
	</div>
	<hr>
	<%=vo.getInfo() %><hr>
	<div class="divForm2">
		<table id="songlist">
			<tr>
				<th>번호 </th>
				<th style="width: 300px">곡 정보 </th>
				<th>좋아요 </th>
				<th>듣기 </th>
				<th>담기 </th>
				<th>다운 </th>
			</tr>
			<%for(int i=0;i<list.size();i++){
				sVo=list.get(i);%>
			<tr>
				<td><%=sVo.getsNo() %></td>
				<td class="name"><%=sVo.getStitle() %></td>
				<td><%=sVo.getSlike() %></td>
				<td>
				<audio src="../aud/You.mp3"></audio>
				<audio controls src="<%=sVo.getSmp3path()%><%=sVo.getSmp3()%>"></audio>
				</td>
				<td><a href="#">담기</a></td>
				<td><a href="#">다운</a></td>
			</tr>
			<%}//for %>
		</table>
	
	</div>
	</section>
<%@ include file="footer.jsp"%>