package com.biz.bucketlist.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.swing.border.EmptyBorder;

import org.apache.ibatis.ognl.NumberElementsAccessor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.biz.bucketlist.domain.BucketListVO;
import com.biz.bucketlist.persistence.BucketListDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class BucketListServiceImp{

	private final BucketListDao bDao;
	
	public List<BucketListVO> selectAll() {
		log.debug("서비스 리스트 시작");
		List<BucketListVO> bList = bDao.selectAll();
		log.debug("리스트 bList : " + bList);
		return bDao.selectAll();
	}

	public BucketListVO findById(long b_id) {


		return bDao.findById(b_id);
	}

	public int insert(BucketListVO bucketlistVO) {
		bucketlistVO.setChecked((-1));
		return bDao.insert(bucketlistVO);
	}

	public int update(BucketListVO bucketlistVO) {
//		int num = bucketlistVO.getChecked();
//		
//		int one = 1;
//		int zero = 0;
//		
//		if(num == zero) 
//			bucketlistVO.setChecked(one);
//		else 
//			bucketlistVO.setChecked( num * (-1));
		
		if(bucketlistVO.getChecked() > 0) {
			
			Date date = new Date();
			SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
			
			
			bucketlistVO.setBucketlistachivedate(sd.format(date));
		} else {
			bucketlistVO.setBucketlistachivedate("");
		}
		
		return bDao.update(bucketlistVO);
	}

	public int delete(long b_id) {
		return bDao.delete(b_id);
	}

}
