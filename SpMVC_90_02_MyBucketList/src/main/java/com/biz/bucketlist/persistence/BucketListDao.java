package com.biz.bucketlist.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.biz.bucketlist.domain.BucketListVO;

public interface BucketListDao {

	public List<BucketListVO> selectAll();
	
	public BucketListVO findById(long id);
	
	public int insert(BucketListVO bucketVO);
	public int update(BucketListVO bucketVO);
	public int delete(long id);
	
}
