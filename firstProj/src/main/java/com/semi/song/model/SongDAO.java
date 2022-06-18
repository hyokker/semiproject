package com.semi.song.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.semi.db.ConnectionPoolMgr2;

public class SongDAO {
	private ConnectionPoolMgr2 pool;
	
	public SongDAO() {
		pool=new ConnectionPoolMgr2();
	}

	/*
	 * public int insertSong(SongVO vo) throws SQLException { Connection con=null;
	 * PreparedStatement ps=null;
	 * 
	 * try { con=pool.getConnection();
	 * 
	 * String
	 * sql="insert into song(sno, salbum, singer, stitle, producer, ondate, img, imgpath)"
	 * + " values(song_seq.nexval, ?, ?, ?, ?,?,?,?)"; ps=con.prepareStatement(sql);
	 * 
	 * ps.setString(1, vo.getAlbum()); ps.setString(2, vo.getSinger());
	 * ps.setString(3, vo.getTitle()); ps.setString(4, vo.getProducer());
	 * ps.setTimestamp(5, vo.getOndate()); ps.setString(6, vo.getImg());
	 * ps.setString(7, vo.getImgpath());
	 * 
	 * int cnt = ps.executeUpdate();
	 * System.out.println("음악 등록 성공 cnt="+cnt+"매개변수 ="+vo); return cnt; }finally {
	 * pool.dbClose(ps, con); } }
	 */
		public List<SongVO> selectByNo(int no) throws SQLException {
			Connection con=null;
			PreparedStatement ps =null;
			ResultSet rs=null;
			
			
			List<SongVO> list =new ArrayList<SongVO>();
			try{
				//1,2
				con=pool.getConnection();
				
				//3
				String sql="select sno, stitle, slike, smp3, smp3path, ano from song where ano=?";
				ps=con.prepareStatement(sql);
				
				ps.setInt(1, no);
				
				rs=ps.executeQuery();
				while(rs.next()) {
					int sno=rs.getInt("sno");
					String stitle=rs.getString("stitle");
					int slike=rs.getInt("slike");
					String smp3=rs.getString("smp3");
					String smp3path=rs.getString("smp3path");
					int ano=rs.getInt("ano");
					SongVO vo =new SongVO(sno, stitle, slike, smp3, smp3path, ano);
					
					list.add(vo);
				}
				System.out.println("글 상세보기 결과 매개변수 no="+no);
				return list;
				
			}finally {
				pool.dbClose(rs, ps, con);
				
		}
	}
}

