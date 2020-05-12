package com.biz.shop.controller;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value = "/admin")
@Controller
public class AdminController {

	@ResponseBody
	@RequestMapping(value="",method=RequestMethod.GET)
	public Principal view_principal(Principal principal) {
		
		log.debug("로그인 정보 : " + principal.toString());
		
		return principal;
	}
}
