package com.biz.bbs.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.biz.bbs.domain.CommentVO;
import com.biz.bbs.repository.CommentDao;

@Service
public class CommentServiceImpl implements CommentService{

	protected final CommentDao cmtDao;
	
	public CommentServiceImpl(CommentDao cDao) {
		super();
		this.cmtDao = cDao;
	}

	@Override
	public List<CommentVO> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public CommentVO findById(long c_id) {
		CommentVO cmtVO = cmtDao.findById(c_id);
		return cmtVO;
	}

	@Override
	public List<CommentVO> findByBId(long c_b_id) {
		return cmtDao.findByBId(c_b_id);
	}
	
	@Override
	public List<CommentVO> findByPId(long c_p_id) {
		return cmtDao.findByPId(c_p_id);
	}

	@Override
	public int insert(CommentVO commentVO) {
		// 작성일자를 현재 저장하는 날짜로 세팅을 하자
		LocalDateTime ldt = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
		commentVO.setC_date_time(ldt.format(dtf).toString());
		
		return cmtDao.insert(commentVO);
	}

	@Override
	public int update(CommentVO commentVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(long c_id) {
		int ret = cmtDao.delete(c_id);
		return ret;	
	}



}
