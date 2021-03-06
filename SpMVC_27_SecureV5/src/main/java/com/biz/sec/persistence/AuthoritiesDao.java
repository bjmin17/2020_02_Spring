package com.biz.sec.persistence;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import com.biz.sec.domain.AuthorityVO;

public interface AuthoritiesDao {

	/*
	 * 사용자 이름으로 권한 테이블에서 권한 리스트를 SELECT
	 */
	@Select("SELECT * FROM authorities "
			+ " WHERE username = #{username} ")
	public List<AuthorityVO> findByUserName(String username);

	public int insert(List<AuthorityVO> authList);
	
	@Delete("DELETE FROM authorities WHERE username = #{username}")
	int delete(String username);

	@Delete("DELETE FROM authorities WHERE id = #{id}")
	public int delete_id(long id);
	
	
	
}
