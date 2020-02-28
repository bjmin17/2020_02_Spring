package com.biz.bbs.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import com.biz.bbs.domain.BBsVO;

public interface BBsDao {

	@Select("SELECT * FROM tbl_bbs ORDER BY b_date_time DESC")
	public List<BBsVO> selectAll();
	
	@Select("SELECT * FROM tbl_bbs WHERE b_id = #{b_id}")
	public BBsVO findById(long b_id);
	
	// 제목으로 검색
	@Select("SELECT * FROM tbl_bbs WHERE b_subject LIKE '%' || #{b_subject} || '%' ")
	public List<BBsVO> findBySubject(String b_subject);
	@Select("SELECT * FROM tbl_bbs WHERE b_writer LIKE '%' || #{b_writer} || '%' ")
	public List<BBsVO> findByWriter(String b_writer);
	
	public int insert(BBsVO bbsVO);
	public int update(BBsVO bbsVO);
	
	@Delete("DELETE FROM tbl_bbs WHERE b_id = #{b_id}")
	public int delete(long b_id);
}
