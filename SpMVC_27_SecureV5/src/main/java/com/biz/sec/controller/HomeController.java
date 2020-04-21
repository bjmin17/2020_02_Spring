package com.biz.sec.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.sec.domain.UserDetailsVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "home";
	}
	
	/**
	 * security mapping을 Annotation을 사용하여 설정
	 * (value에 문자열 배열)
	 */
	
//	@Secured(value= {"ROLE_ADMIN","ROLE_USER"})
	@RequestMapping(value = "/auth", method = RequestMethod.GET)
	public String auth(Model model) {
		return "auth/auth_view";
	}
	
	/**
	 * Controller의 method에서
	 * HttpServletRequest 클래스로부터 인증(로그인한)정보를 
	 * 추출하여 세부항목을 보는 방법
	 * 
	 * @param id
	 * @param req
	 * @return
	 */
	@ResponseBody
	@Secured(value= {"ROLE_ADMIN","ROLE_USER"})
	@RequestMapping(value = "/auth/{id}", method = RequestMethod.GET)
	public Object auth(@PathVariable("id") String id, HttpServletRequest req) {
		// 클라이언트에서 웹에 정보를 요청할 때 모든 정보가 담겨있는 클래스
		// HttpServletRequest
		
		int intId = 0;
		try {
			intId = Integer.valueOf(id);
		} catch (Exception e) {
			return e.getMessage();
		}
		
		Authentication auth = (Authentication) req.getUserPrincipal();
		
		// case에 문자열로 넣고 비교를 한다면 == 로 비교하기 때문에 완전히 동작하진 않는다.
		// 따라서 equals처럼 사용하든지 아니면 정수를 넣어서 비교한다.
		
		
		// if문을 쓴다면 이런식으로
		if(intId == 1) log.debug("intId = 1");
		else if(intId == 2) log.debug("intId = 2");
		
		// switch 문
		// if 문과는 다르게 case 하나를 충족한다 하더라도 다른 모든 문장까지 실행되기 때문에 break가 필요하다.
		// return 문이 써져있기 때문에 break문 빼도 된다.
		switch (intId) {
		case 1: // if(intId == 1)
			log.debug("1일 때" + auth.getDetails().toString());
			return auth.getDetails(); // org.springframework.security.web.authentication.WebAuthenticationDetails@fffc7f0c: 
			// RemoteIpAddress: 0:0:0:0:0:0:0:1; SessionId: E7064B07FF9E9202F1F88114BE17A91A
			
		case 2: // else if(intId == 2)
			log.debug("2일 때" + auth.getCredentials().toString());
			return auth.getCredentials();
			
		case 3: // else if(intId == 3)
			log.debug("3일 때" + auth.getPrincipal().toString());
			return auth.getPrincipal(); // 3일 때UserDetailsVO(id=1, username=admin, 
			// password=$2a$04$MIOOqdErJT.wsXvLJR62JO2HelM7pzkwgKLP4Xwnq9YI3DVp5tYbq, enabled=true, 
			// accountNonExpired=true, accountNonLocked=true, credentialsNonExpired=true, authorities=[ADMIN, ROLE_ADMIN], 
			// email=bjmin17@naver.com, phone=010-111-1234, address=광주광역시)
			
		case 4: // else if(intId == 4)
			log.debug("4일 때" + auth.getAuthorities().toString());
			return auth.getAuthorities(); // 4일 때[ADMIN, ROLE_ADMIN]
			
		case 5: // else if(intId == 5)
			log.debug("5일 때" + auth.getName().toString());
			return auth.getName(); // 5일 때admin
		
		case 6: // else if(intId == 6)
			UserDetailsVO userVO = (UserDetailsVO) auth.getPrincipal();
			return userVO; // userVO의 모든 항목들을 추출해서 사용할 수 있다.
			
		default: // 그외
			return "Not Found";
		}
		
		
	}
	
}
