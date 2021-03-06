package com.biz.shop.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;

import com.biz.shop.domain.ProColorVO;
import com.biz.shop.domain.ProOptionsVO;
import com.biz.shop.domain.ProSizeVO;

public interface ProOptionsDao {

	@Select("SELECT * FROM tbl_options WHERE o_division = 'COLOR' ")
	public List<ProOptionsVO> getColorList();
	
	@Select("SELECT * FROM tbl_options WHERE o_division = 'SIZE' ")
	public List<ProOptionsVO> getSizeList();
	
	/*
	 * mysql auto_increment로 되어 있는 s_seq 칼럼을
	 * @Options로 설정을 해주면
	 * insert를 수행한 후 ProSizeVO의 s_seq 변수에
	 * 새로 생성된 s_seq값을 담아서 이후 Service, Controller 등에서
	 * 사용할 수 있도록 만들어준다.
	 */
	@Options(useGeneratedKeys = true, keyProperty = "s_seq")
	@Insert("INSERT INTO tbl_pro_size(p_code, s_size) "
			+ " VALUES(#{p_code}, #{s_size} ) ")
	public int insert_size(ProSizeVO proSizeVO);
	
	@Delete("DELETE FROM tbl_pro_size WHERE s_seq = #{s_seq} ")
	public int delete_size(ProSizeVO proSizeVO);
	
	@Options(useGeneratedKeys = true, keyProperty = "c_seq")
	@Insert("INSERT INTO tbl_pro_color (size_seq, c_color ) "
			+ " VALUES(#{size_seq}, #{c_color} ) ")
	public int insert_color(ProColorVO proColorVO);
	
	@Select("SELECT count(*) FROM tbl_pro_size WHERE p_code = #{p_code} AND s_size = #{s_size} ")
	public int getProSize(ProSizeVO proSizeVO);
	
	@Select("SELECT count(*) FROM tbl_pro_color WHERE size_seq = #{size_seq} AND c_color = #{c_color} ")
	public int getProColor(ProColorVO proColorVO);

	@Select("SELECT * FROM tbl_pro_color "
			+ " LEFT JOIN tbl_options "
			+ " 	ON c_color = o_standard "
			+ " WHERE size_seq = #{longSeq} "
			+ " ORDER BY o_name ")
	public List<ProColorVO> getColorListBySize(long longSeq);
	
	
}
