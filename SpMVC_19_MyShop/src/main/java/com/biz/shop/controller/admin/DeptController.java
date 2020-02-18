package com.biz.shop.controller.admin;

import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.biz.shop.domain.DeptVO;
import com.biz.shop.service.DeptService;

import lombok.RequiredArgsConstructor;

@SessionAttributes("deptVO")
@RequiredArgsConstructor
@RequestMapping(value="/admin/dept")
@Controller
public class DeptController {

	private final DeptService dService;
	
	@ModelAttribute("deptVO")
	public DeptVO newDept() {
		return new DeptVO();
	}
	
	
	// /admin/dept로 매핑
	@RequestMapping(value= {"","/"},method=RequestMethod.GET)
	public String input(Model model) {
	
		this.modelMapping(model);
		DeptVO deptVO = new DeptVO();
		
		List<DeptVO> deptList = dService.selectAll();
		
		model.addAttribute("DEPT_LIST",deptList);
		model.addAttribute("deptVO", deptVO);
		
		return "admin/main";
	}
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(Model model) {
		this.modelMapping(model);
		return "dept/dept_list";
	}
	
	@RequestMapping(value= "/input",method=RequestMethod.POST)
	public String input(@ModelAttribute("deptVO") @Valid DeptVO deptVO, 
			BindingResult result,
			Model model) {
		
		model.addAttribute("DEPT", deptVO);
		
		if(result.hasErrors()) {
			this.modelMapping(model);
			model.addAttribute("deptVO",deptVO);
			return "admin/main";
		}
		
		DeptVO ret = dService.save(deptVO);
		
		return "redirect:/admin/dept";
	}
	
	@RequestMapping(value="/update/{id}",method=RequestMethod.GET)
	public String update(@ModelAttribute("deptVO") DeptVO deptVO, 
			@PathVariable("id") String strId,
			Model model) {
		
		this.modelMapping(model);
		
		long id = Long.valueOf(strId);
		deptVO = dService.findById(id);
		model.addAttribute("deptVO",deptVO);
		
		return "admin/main";
		
		
	}
	
	
	private void modelMapping(Model model) {
		List<DeptVO> deptList = dService.selectAll();
		model.addAttribute("DEPT_LIST",deptList);
		model.addAttribute("BODY","DEPT");
	}
}
