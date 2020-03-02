package com.biz.bbs;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.biz.bbs.domain.BBsVO;
import com.biz.bbs.service.FileReaderService;

public class Main2 {

	public static void main(String[] args) {
		FileReaderService fService = new FileReaderService();
		
		List<BBsVO> bbsList = fService.getBBsData();
		List<BBsVO> pList = fService.getMain(bbsList);
		
		List<BBsVO> prList = new ArrayList<BBsVO>();
		pList.forEach(vo->{
			// add는 VO를 하나씩 넣어주고
			prList.add(vo);
			// addAll은 리스트를 통째로 다른 리스트로 복사해주는 코드
			prList.addAll(fService.getRepl(bbsList, vo));
		});
		prList.forEach(System.out::println);
		
	}
	
	
}
