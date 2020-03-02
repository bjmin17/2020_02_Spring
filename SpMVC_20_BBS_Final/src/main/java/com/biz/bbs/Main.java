package com.biz.bbs;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import com.biz.bbs.domain.BBsVO;
import com.biz.bbs.service.FileReaderService;

public class Main {

	// 진입점, endpoint method
	public static void main(String[] args) {
		
		FileReaderService fService = new FileReaderService();
		List<BBsVO> bbsList = fService.getBBsData();
		
		Collections.sort(bbsList,new Comparator<BBsVO>() {
			@Override
			public int compare(BBsVO o1, BBsVO o2) {
				int s = (int)(o1.getB_id() - o2.getB_id());
				return s;
			}
		});
		
		// 람다코드로 똑같이 써준 것
		// sort() method의 정의에 
		// 첫번째 매개변수는 정렬할 List
		// 두번째 매개변수는 Comparator인터페이스를 이용한
		// 구현체가 오도록 되어 있기 때문에 가능하다
		

		Collections.sort(bbsList,(o1,o2)->
			(int)(o1.getB_id() - o2.getB_id())
		);
		
		// 날짜, 시간 역순 정렬
		Collections.sort(bbsList,(o1,o2)->
			o2.getB_date_time().compareTo(o1.getB_date_time())
		);

		// 부모id(b_p_id)가 0인 리스트만 추출
		List<BBsVO> pList = new ArrayList<BBsVO>(); 
				
		// 전통적인 코드
		for(BBsVO vo : bbsList) {
			if(vo.getB_p_id() == 0) pList.add(vo);
		}
		
		// 람다코드로
		bbsList.forEach(vo->{
			if(vo.getB_p_id() == 0) pList.add(vo);
		});
		
		// 람다를 이용한 화면출력
		bbsList.forEach(vo->{
			System.out.println(vo);
		});
		
		// 자바 1.8 이상을 보면 이런 코드가 나옴, sysout이 간소화된 코드
		bbsList.forEach(System.out::println);
		
	}
}
