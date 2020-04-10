package com.biz.sec.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import com.biz.sec.domain.UserVO;

public interface UserDao {

	public List<UserVO> selectAll();
	
	// VO와 이름 같게 하기 위해 AS로 알리아스 설정해서 username이라고 정한다.
	@Select("SELECT user_name AS username "
			+ " FROM tbl_users WHERE user_name = #{username}")
	public String findByUserName(String username);
	
	public int insert(Map<String,String> userMap);
}
