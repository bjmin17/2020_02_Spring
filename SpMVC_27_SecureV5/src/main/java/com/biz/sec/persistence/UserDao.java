package com.biz.sec.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.biz.sec.domain.UserDetailsVO;

public interface UserDao {

	public List<UserDetailsVO> selectAll();
	
	public void create_table(String create_table);
	
	// VO와 이름 같게 하기 위해 AS로 알리아스 설정해서 username이라고 정한다.
	
	public UserDetailsVO findByUserName(String username);
	
	public int insert(UserDetailsVO userVO);

	public UserDetailsVO findById(long id);

	public int update(UserDetailsVO userVO);
}
