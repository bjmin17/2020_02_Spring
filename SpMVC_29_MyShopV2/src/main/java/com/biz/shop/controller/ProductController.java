package com.biz.shop.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.biz.shop.domain.ProColorVO;
import com.biz.shop.domain.ProSizeVO;
import com.biz.shop.domain.ProductVO;
import com.biz.shop.service.ProOptionsService;
import com.biz.shop.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@RequestMapping(value = "/product")
@Controller
@Slf4j
public class ProductController {

	private final ProductService proService;
	private final ProOptionsService proOPTService;
	
	/*
	 * spring form tag를 사용한 jsp와 연동하는 경우
	 * jsp form을 최초로 열어서 보여주는 method에서
	 * modelAttribute에 해당하는 VO 객체를 생성하고
	 * model에 담아서 jsp로 보내야 한다.
	 * 
	 * controller 클래스에
	 * @ModelAttribute() method를 작성해두면
	 * 나머지 method에서는 별도로 model에 vo를 담아서 보내지 않아도 
	 * 새로 생성된 VO를 만들어서
	 * 이 method가 jsp로 보내주는 역할을 대신 한다.
	 */
	@ModelAttribute("productVO")
	public ProductVO newProductVO() {
		return new ProductVO();
	}
	
	// product/, product/list 로 요청했을 때 처리할 method
	@RequestMapping(value = {"","/list"},method=RequestMethod.GET)
	public String list(Model model) {
		
		List<ProductVO> proList = proService.selectAll();
		model.addAttribute("proList",proList);
		return "product/pro_list";
	}
	
	@RequestMapping(value = "/insert",method=RequestMethod.GET)
	public String insert(ProductVO productVO, Model model) {
		return "product/pro_write";
	}
	
	@RequestMapping(value = "/insert",method=RequestMethod.POST)
	public String insert(ProductVO productVO, 
			
				@RequestParam("file")MultipartFile file) {
		
		log.debug("파일이름:"+file.getOriginalFilename());
		proService.insert(productVO,file);
		
		return "redirect:/product/list";
	}
	
	@ResponseBody
	@RequestMapping(value = "/code_check",method=RequestMethod.GET)
	public String code_check(String p_code) {
		ProductVO proVO = proService.findByPCode(p_code);
		if(proVO != null && proVO.getP_code().equals(p_code)) return "EXISTS";
		return "NONE";
		
	}
	
	@RequestMapping(value="/detail/{p_code}")
	public String detailView(ProductVO productVO, @PathVariable(name="p_code") String p_code
			,Model model) {
		productVO = proService.findByPCode(p_code);
		
		model.addAttribute("productVO",productVO);
		
		// option 정보 테이블에서 데이터 리스트 가져와서 사용하기
		model.addAttribute("m_color_list",proOPTService.getColorList());
		model.addAttribute("m_size_list",proOPTService.getSizeList());
		
		return "product/pro_detail";
	}
	
	@ResponseBody
	@RequestMapping(value="/insert_size",method=RequestMethod.POST)
	public Object insert_size(ProSizeVO proSizeVO) {
		log.debug("SIZE:" + proSizeVO.getS_size());
		log.debug("P_CODE:"+proSizeVO.getP_code());
		
		int ret = proOPTService.getProSize(proSizeVO);
		if(ret > 0) {
			return "EXISTS"; // 이미 등록된 사이즈 정보이므로 저장하지 않음
		}
		
		log.debug("컨트롤러 s_Seq 값은 아마 없을거야 : "+ proSizeVO.toString());
		proOPTService.insert_size(proSizeVO);
		// Dao의 Options 부분을 참조해서 사용
		log.debug("컨트롤러 s_Seq 값 : "+ proSizeVO.toString());
		//return proSizeVO;
		return proSizeVO;
	}
	
	@ResponseBody
	@RequestMapping(value="/delete_size",method=RequestMethod.POST)
	public String delete_size(ProSizeVO proSizeVO) {
		int ret = proOPTService.delete_size(proSizeVO);
		
		if(ret > 0) {
			return "DELETE";
		}
		
		return "OK"; 
	}
	
	@ResponseBody
	@RequestMapping(value="/insert_color",method=RequestMethod.POST)
	public Object insert_color(ProColorVO proColorVO) {
		log.debug("SIZE:" + proColorVO.getC_color());
		log.debug("S_SEQ:"+proColorVO.getSize_seq());
		
		return proOPTService.insert_color(proColorVO);
		
//		return proColorVO;
	}
	
	@ResponseBody
	@RequestMapping(value="/get_color_list_by_size",method=RequestMethod.GET)
	public Object get_color_list_by_size(String s_seq) {
		List<ProColorVO> proColorList = proOPTService.get_color_list_by_size(s_seq);
		
		if(proColorList == null) {
			return "FAIL";
		}
		
		return proColorList;
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
