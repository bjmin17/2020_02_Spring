package com.biz.shop.controller;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.biz.shop.domain.DeptVO;

@RequestMapping(value="/admin/dept")
@Controller
public class DeptController {

	
	@RequestMapping(value= {"","/"},method=RequestMethod.GET)
	public String dept(Model model) {
		
		DeptVO deptVO = new DeptVO();
		
		model.addAttribute("DeptVO", deptVO);
		model.addAttribute("BODY","DEPT");
		
		return "dept/main";
	}
	
	@RequestMapping(value= "/input",method=RequestMethod.POST)
	public String dept(@ModelAttribute("deptVO") @Valid DeptVO deptVO, 
			BindingResult result,
			Model model) {
		
		model.addAttribute("DEPT", deptVO);
		
		if(result.hasErrors()) {
			model.addAttribute("BODY","DEPT");
			return "dept/main";
		}
		
		return "redirect:/admin/dept";
	}
}
