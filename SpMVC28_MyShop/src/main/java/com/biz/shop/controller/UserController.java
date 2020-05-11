package com.biz.shop.controller;

import java.security.Principal;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.shop.domain.UserDetailsVO;
import com.biz.shop.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/user")
@Controller
public class UserController {

	private final UserService userService;
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login() {
		return "user/login";
	}
	
	@RequestMapping(value="/join",method=RequestMethod.GET)
	public String join() {
		return "user/join";
	}
	
//	@ResponseBody
	@RequestMapping(value = "/join",method=RequestMethod.POST,
			produces = "text/html;charset=UTF-8")
	public String join(String username, String password) {
		
		int ret = userService.insert(username,password);
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="/mypagetest",method=RequestMethod.GET)
	public String mypageTest(Principal principal, Model model) {
		
		return principal.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/password",method=RequestMethod.POST)
	public String password(String password) {
		boolean ret = userService.check_password(password);
		if(ret) return "PASS_OK";
		return "PASS_FAIL";
	}
	
	@RequestMapping(value="/mypage",method=RequestMethod.GET)
	public String mypage(Principal principal, Model model) {
	
		UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken) principal;
		
		UserDetailsVO userVO = (UserDetailsVO)upa.getPrincipal();
		
		userVO.setAuthorities(upa.getAuthorities());
		
		model.addAttribute("userVO",userVO);
		
		return "user/mypage";
	}
	
	@RequestMapping(value="/mypage",method=RequestMethod.POST)
	public String mypage(UserDetailsVO userVO, String[] auth, Model model) {
		log.debug("마이페이지 userVO : "+userVO.toString());
		int ret = userService.update(userVO);
		
		return "redirect:/user/mypage";
	}
}
