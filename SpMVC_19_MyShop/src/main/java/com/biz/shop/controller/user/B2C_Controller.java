package com.biz.shop.controller.user;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.biz.shop.domain.ProductVO;
import com.biz.shop.service.ProductService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping(value="/user/product")
@Controller
public class B2C_Controller {

	private final ProductService proService;
	
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(@ModelAttribute("productVO") ProductVO productVO,Model model) {
		
		productVO = new ProductVO();
		 List<ProductVO>proList = proService.selectAll();
		model.addAttribute("B2C_LIST",proList);
		model.addAttribute("BODY","B2C");
		model.addAttribute("productVO",productVO);
		
		return "admin/main";
//		return "users/user_product_list";
	}
	
	@RequestMapping(value="/detail/{id}",method=RequestMethod.GET)
	public String detail(@ModelAttribute("productVO") ProductVO productVO,
					@PathVariable("id") String strId, Model model) {
		
		model.addAttribute("BODY","B2C_DETAIL");
		
		long id = Long.valueOf(strId);
		productVO = proService.findById(id);
		model.addAttribute("pVO", productVO);
		
		return "admin/main";
	}
}
