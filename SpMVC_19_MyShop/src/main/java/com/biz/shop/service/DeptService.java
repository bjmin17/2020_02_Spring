package com.biz.shop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.biz.shop.domain.DeptVO;
import com.biz.shop.repository.DeptDao;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class DeptService {

	private final DeptDao deptDao;

	public List<DeptVO> selectAll() {
		List<DeptVO> deptList = deptDao.findAll();
		return deptList;
	}

	public DeptVO save(DeptVO deptVO) {
		DeptVO ret = deptDao.save(deptVO); 
		return ret;
	}

	public DeptVO findById(long id) {

		Optional<DeptVO> deptVO = deptDao.findById(id);
		return deptVO.get();
	}
	
	
	
	
	
	
	
}
