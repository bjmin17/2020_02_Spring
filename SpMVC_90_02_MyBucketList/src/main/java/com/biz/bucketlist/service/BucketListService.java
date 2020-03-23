package com.biz.bucketlist.service;

import java.util.List;

import com.biz.bucketlist.domain.BucketListVO;

public interface BucketListService {

	public List<BucketListVO> selectAll();
	public BucketListVO findById();
	public BucketListVO insert();
	public BucketListVO update();
	public BucketListVO delete();
}
