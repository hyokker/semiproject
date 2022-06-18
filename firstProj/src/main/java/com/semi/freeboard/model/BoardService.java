package com.semi.freeboard.model;

import java.sql.SQLException;
import java.util.List;

public class BoardService {
	private FreeBoardDAO freeBoardDao;
	
	public BoardService() {
		freeBoardDao=new FreeBoardDAO();
	}
	public List<FreeBoardVO> selectAll(String condition,String keyword) throws SQLException {
		List<FreeBoardVO> list = freeBoardDao.selectAll(condition, keyword);
		return list;
	}
}
