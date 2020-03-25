package com.biz.bucketlist.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.biz.bucketlist.domain.BucketListVO;
import com.biz.bucketlist.service.BucketListServiceImp;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class BucketListController {

	private final BucketListServiceImp bSerice;
	
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(Model model) {
		log.debug("컨트롤러 cu");
		List<BucketListVO> bucketList = bSerice.selectAll();
		log.debug("컨트롤러 list에서 " + bucketList);
		
		model.addAttribute("BODY","BUCKETLIST");
		model.addAttribute("BUCKETLIST",bucketList);
		
		return "home";
	}
	
	@RequestMapping(value="/insert",method=RequestMethod.GET)
	public String insert(Model model) {
		log.debug("insert 진입");
//		model.addAttribute("BODY","LISTINSERT");
		return "insert";
	}
	
	@RequestMapping(value="/insert",method=RequestMethod.POST)
	public String insert(BucketListVO bucketlistVO, Model model) {
		log.debug("insert POST로 보내기 완료");
		int ret =  bSerice.insert(bucketlistVO);
		log.debug("insert 값 : " + ret);
		return "redirect:/";
	}
	
	@RequestMapping(value="/update",method=RequestMethod.GET)
	public String update(@RequestParam("b_id") String b_id, BucketListVO bucketlistVO, Model model) {
		
		BucketListVO bVO = bSerice.findById(Long.valueOf(b_id));
		
		model.addAttribute("bVO",bVO);
		model.addAttribute("BODY","UPDATE");
		
		return "insert";
	}
	
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public String update(BucketListVO bucketlistVO, Model model, String dummy) {
		log.debug("컨트롤러 VO : "  + bucketlistVO.getChecked());
		int ret = bSerice.update(bucketlistVO);
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	public String delete(@RequestParam("b_id") long b_id) {
		
		int ret = bSerice.delete(b_id);
		
		return "redirect:/";
	}
	
}
