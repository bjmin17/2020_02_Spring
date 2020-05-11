package com.biz.shop.persistence;

import org.apache.ibatis.annotations.Select;

import com.biz.shop.domain.UserDetailsVO;

public interface UserDao {

	public int insert(UserDetailsVO userVO);

	public UserDetailsVO findByUserName(String username);

	public int update(UserDetailsVO userVO);

}
