package com.semi.freeboard.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.semi.db.ConnectionPoolMgr2;

public class FreeBoardDAO {
	private ConnectionPoolMgr2 pool;
	
	public FreeBoardDAO() {
		pool = new ConnectionPoolMgr2();
	}
	
	public List<FreeBoardVO> selectAll(String condition,String keyword) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<FreeBoardVO> list = new ArrayList<FreeBoardVO>();
		try {
			con=pool.getConnection();
			
			String sql="select * from freeboard";
			 if(keyword!=null && !keyword.isEmpty()) {
		     sql+=" where "+condition+" like '%' || ? || '%'";
		     }
			 sql+=" order by no desc";
			 ps=con.prepareStatement(sql);
	         if(keyword!=null && !keyword.isEmpty()) {
	             ps.setString(1, keyword);
	          }
			
			rs=ps.executeQuery();
			while(rs.next()) {
				int no=rs.getInt("no");
				int readcount=rs.getInt("readcount");
				String name=rs.getString("name");
				String pwd=rs.getString("pwd");
				String title=rs.getString("title");
				String email=rs.getString("email");
				String content=rs.getString("content");
				Timestamp regdate=rs.getTimestamp("regdate");
				
				int groupNo=rs.getInt("groupno");
				int step=rs.getInt("step");
				int sortNo=rs.getInt("sortno");
				String delflag=rs.getString("delflag");
			
				String filename=rs.getString("filename");
				String originalFilename=rs.getString("originalFilename");
				long fileSize=rs.getLong("filesize");
				int downcount=rs.getInt("downcount");
				
				FreeBoardVO vo =new FreeBoardVO(no, name, pwd, title, email, regdate, readcount, content, groupNo, step, sortNo, delflag, filename, fileSize, downcount, originalFilename);
				
				list.add(vo);
			}
			System.out.println("전체 조회 결과 list.size()="+list.size()
			+", 매개변수 condition="+condition+", keyword ="+ keyword);
			
			return list;
		}finally {
				pool.dbClose(rs, ps, con);	
		}
	}
	public int updateCount(int no) throws SQLException {
	      Connection con = null;
	      PreparedStatement ps = null;
	      
	      try {
	         //1,2
	         con=pool.getConnection();
	         
	         //3
	         String sql="update Freeboard"
	               + " set readcount=readcount+1"
	               + " where no=?";
	         ps=con.prepareStatement(sql);
	         
	         ps.setInt(1, no);
	         
	         int cnt = ps.executeUpdate();
	         
	         System.out.println("조회수 증가 결과 cnt="+cnt+", 매개변수 no="+no);
	          
	         return cnt;
	      }finally {
	         pool.dbClose(ps, con);
	      }
	   }
	
	public FreeBoardVO selectByNo(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;

		FreeBoardVO vo = new FreeBoardVO();
		try {
			//1,2
			con=pool.getConnection();

			//3
			String sql="select * from freeBoard where no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, no);

			//4
			rs=ps.executeQuery();
			if(rs.next()) {
				vo.setNo(no);
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setName(rs.getString("name"));
				vo.setEmail(rs.getString("email"));
				vo.setPwd(rs.getString("pwd"));
				vo.setRegdate(rs.getTimestamp("regdate"));
				vo.setReadcount(rs.getInt("readcount"));
				
				//
				vo.setGroupNo(rs.getInt("groupno"));
				vo.setStep(rs.getInt("step"));
				vo.setSortNo(rs.getInt("sortno"));
				vo.setDelFlag(rs.getString("delflag"));		
				
				//
				vo.setFileName(rs.getString("filename"));
				vo.setOriginalFileName(rs.getString("originalFilename"));
				vo.setFileSize(rs.getLong("filesize"));
				vo.setDownCount(rs.getInt("downcount"));
				
			}

			System.out.println("글 상세보기 결과 vo="+vo+", 매개변수 no="+no);

			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	public int updateDownCount(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;

		try {
			con=pool.getConnection();

			String sql="update reBoard set downcount=downcount+1"
		               + " where no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, no);

			int cnt=ps.executeUpdate();
			System.out.println("다운로드수 증가 결과 cnt="+cnt+", 매개변수 no="+no);

			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	public int insertFreeBoard(FreeBoardVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;

		try {
			//1,2
			con=pool.getConnection();

			//3
			String sql="insert into freeBoard(no, name, pwd, title, email, "
					+ "content, groupNo, filename, originalFilename,filesize)"
					+ "values(freeboard_seq.nextval, ?,?,?,?,?"
					+ ",freeboard_seq.nextval,?,?,?)";
			ps=con.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getContent());
			ps.setString(6, vo.getFileName());
			ps.setString(7, vo.getOriginalFileName());
			ps.setLong(8, vo.getFileSize());

			//4
			int cnt=ps.executeUpdate();
			System.out.println("글등록 결과 cnt="+cnt+", 매개변수 vo="+vo);

			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}

}
