package com.biz.sec.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.sec.domain.UserDetailsVO;
import com.biz.sec.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Controller
@Slf4j
@RequestMapping(value="/user")
public class UserController {

	private final UserService userService;
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login() {
		return "auth/login";
	}
	
	@RequestMapping(value="/join",method=RequestMethod.GET)
	public String join() {
		return "auth/join";
	}
	
	@ResponseBody
	@RequestMapping(value="/join",method=RequestMethod.POST,
			produces = "text/html;charset=UTF-8")
	public String join(String username, String password) {
		
		log.debug("아이디 {}, 비번{}", username, password);
		
		userService.insert(username, password);
		
//		return "redirect:/";
		
		return String.format("아이디 : <b>%s</b>, 비밀번호 : <b>%s</b>", username, password);
	}
	
	@ResponseBody
	@RequestMapping(value="/idcheck",method=RequestMethod.GET)
	public String idcheck(String username) {
		
		boolean ret = userService.isExistsUserName(username);
		if(ret) {
			return "Exists".toUpperCase(); // EXISTS 
		}
		return "NonExists".toUpperCase(); // NONEXISTS
		
	}
	
	@ResponseBody
	@RequestMapping(value="/password",method=RequestMethod.POST)
	public String password(String password) {
		log.debug("비밀번호 : " + password);
		boolean ret = userService.check_password(password);
		
		if(ret) return "PASS_OK";
		
		return "PASS_FAIL";
	}
	
	@ResponseBody
	@RequestMapping(value="",method=RequestMethod.GET)
	public String user() {
		return "user HOME";
	}
	
	@RequestMapping(value="/mypage1",method=RequestMethod.GET)
	public String mypage(Model model) {
		// 사용자 정보 뽑아오는 방법 2가지
		// 1. principal을 가져와서 토큰으로 가져온 다음에 getPrincipal로 가져오기
//		UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken)principal;
//		UserDetailsVO userVO = (UserDetailsVO)upa.getPrincipal();
		
		// 2. securitycontextholder를 이용해서 직접 뽑아오기
		// 로그인한 사용자 정보
		UserDetailsVO userVO = (UserDetailsVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		// VO에 authorities는 null 값으로? 저장되기 때문
		// 권한(ROLE) 리스트 추출하여 userVO에 setting
		userVO.setAuthorities(SecurityContextHolder.getContext().getAuthentication().getAuthorities());
		
		model.addAttribute("userVO",userVO);
//		return "user/mypage";
		return "auth/mypage";
	}
	
	@RequestMapping(value="/mypage",method=RequestMethod.GET)
	public String mypage(Principal principal, Model model) {
		// 사용자 정보 뽑아오는 방법 2가지
		// 1. principal을 가져와서 토큰으로 가져온 다음에 getPrincipal로 가져오기
		UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken)principal;
		
		UserDetailsVO userVO = (UserDetailsVO)upa.getPrincipal();
		
		// 2. securitycontextholder를 이용해서 직접 뽑아오기
//		UserDetailsVO userVO = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		// VO에 authorities는 null 값으로? 저장되기 때문
		userVO.setAuthorities(upa.getAuthorities());
		
		model.addAttribute("userVO",userVO);
//		return "user/mypage";
		return "auth/mypage";
	}
	
	@RequestMapping(value="/mypage",method=RequestMethod.POST)
	public String mypage(UserDetailsVO userVO, String[] auth, Model model) {
		
		/*
		 * Security Session 정보가 저장된 메모리에 직접 접근하여
		 * session user 정보를 수정하는 방법
			UsernamePasswordAuthenticationToken upa = (UsernamePasswordAuthenticationToken)principal;
			
			UserDetailsVO oldUserVO = (UserDetailsVO)upa.getPrincipal();
			oldUserVO.setEmail(userVO.getEmail());
		 * 코드는 쉬워지나 보안에 치명적인 문제를 일으킬 수 있다.
		 */
		int ret = userService.update(userVO);
		
		return "redirect:/user/mypage";
		/*
		 * 기본형 변수, 객체, 배열 등을 모두 변수라고 할 수 있다.
		 * 
		 * type형 변수(참조형 변수)
		 * 객체나, 배열은 method로 해당 객체나 배열을 전달하고
		 * method에서 객체나 배열의 일부 요소의 값을 변경하면
		 * 원본의 객체나, 배열에 변경한 값이 반영이 된다.
		 * 
		 * 기본형 변수(primitive형 변수)
		 * int, char, long, double 등등으로 만든 변수는
		 * method로 전달하여 method 내에서 값을 변경하여도
		 * 원본은 절대 변경되지 않는다.
		 */
	}
	
	

}
