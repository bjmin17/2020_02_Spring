package com.biz.bucketlist.domain;

import lombok.Builder;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class BucketListVO {

	private long b_id;
	private String bucketlistname; 		// 버킷리스트 이름
	private String bucketlistsdate;		// 버킷리스트 시작 날짜
	private String bucketlistdeadline;	// 버킷리스트 기한
	private String bucketlistachivedate;	// 버킷리스트 달성일
	private int checked;
	
}
