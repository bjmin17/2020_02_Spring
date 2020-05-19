package com.biz.shop.service;

import java.util.List;

import com.biz.shop.domain.ProFileVO;

public interface FileUploadService {

	public List<ProFileVO> selectAll();
	
	public List<ProFileVO> findByPCode(String file_p_code);
	
	public ProFileVO findById(long id);
	
	public int insert(ProFileVO profileVO);
	
	public int delete(long id); // 개별로 1개씩 이미지 삭제
	
	public int delete(String file_p_code); // 상품코드로 검색하여 모두 삭제
	
}
