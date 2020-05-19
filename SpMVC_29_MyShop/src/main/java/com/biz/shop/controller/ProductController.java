package com.biz.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.biz.shop.domain.ProductVO;

@RequestMapping(value = "/product")
@Controller
public class ProductController {

	@RequestMapping(value = "/list",method=RequestMethod.GET)
	public String list() {
		
		return "product/list";
	}
	
	public String insert() {
		return "product/write";
	}
	
	public String insert(ProductVO productVO) {
		return "redirect:/product/list";
	}
	
	public String detailView(long id) {
		return "product/detail";
	}
	
	public String update(long id) {
		return "product/write";
	}
	
	public String update(ProductVO produtVO) {
		return "redirect:/product/list";
	}
	
	public String delete(long id) {
		return "redirect:/product/list";
	}
	
}
