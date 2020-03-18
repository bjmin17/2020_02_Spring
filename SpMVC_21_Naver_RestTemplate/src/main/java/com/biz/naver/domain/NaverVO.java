package com.biz.naver.domain;

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

public class NaverVO {

	// 뉴스
	private String title;//": "정덕남 안양시의원 <b>코로나</b>19 기부행렬 동참",
	private String originallink;//": "http://www.fnnews.com/news/202003181324332626",
	private String link;//": "https://news.naver.com/main/read.nhn?mode=LSD&mid=sec&sid1=102&oid=014&aid=0004392134",
	private String description;//": "정덕남 안양시의회 의원은 17일 저소득 취약계층 지원 및 <b>코로나</b>19 긴급구호활동 등에 사용해 달라며... 100만원을 <b>코로나</b>19로 인해 힘들어 하고 있는 이웃을 위해 쾌척했다. 정덕남 의원은 “국가적으로 어려운 시기에... ",
	private String pubDate;//": "Wed, 18 Mar 2020 13:27:00 +0900"
	
	// 영화
	private String image;//": "https://ssl.pstatic.net/imgmovie/mdi/mit110/1604/160441_P01_144910.jpg",
	private String subtitle;//": "Lost Cat Corona",
	private String director;//": "안토니 타르시타노|",
	private String actor;//": "숀 영|지나 거손|랄프 마치오|데이빗 제야스|아담 페라라|제프 코버|폴 소르비노|톰 우팻|",
	private String userRating;//": "6.00"

	// 도서
	private String author;//": "윌 <b>코로나</b> 필그림",
	private String price;//": "12000",
	private String discount;//": "10800",
	private String publisher;//": "시공사",
	private String pubdate;//": "20180425",
	private String isbn;//": "8952790677 9788952790675",
}
