package com.biz.sec.service.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.biz.sec.domain.UserDetailsVO;

public class AuthProviderImpl implements AuthenticationProvider{

	@Autowired
	@Qualifier("userDetailsService")
	private UserDetailsServiceImpl userDService;
	
	/**
	 * security-context에 bean으로 등록된 친구
	 */
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	/**
	 * spring security에서 커스터마이징을 수행하여
	 * 로그인을 세세히 제어하고자 할 때
	 * 코드를 작성해야하는 중요한 method
	 */
	// 로그인을 하면 로그인 정보가 authentication에 담겨온다.
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		/*
		 * authentication으로부터 로그인 폼에서 보낸 username 과 password를 추출 
		 */
		String username = (String) authentication.getPrincipal(); 
		String password = (String) authentication.getCredentials();
		
		// Service와 Dao를 통해서 DB로부터 사용자정보 가져오기
		UserDetailsVO userVO = (UserDetailsVO) userDService.loadUserByUsername(username);
		if(!passwordEncoder.matches(password.trim(), userVO.getPassword().trim())) {
			throw new BadCredentialsException("비밀번호 오류");
		}
		
		// enabled가 false이면, 사용금지된 username일 경우
		if(!userVO.isEnabled()) {
			throw new BadCredentialsException(username + " : 접근 권한 없음");
		}
		
		// UserDetailsService에서 보내준 사용자 정보를 Controller로 보내는
		// 일을 수행
		// **권한들도 같이 보내주는게 중요
		return new UsernamePasswordAuthenticationToken(userVO, null, userVO.getAuthorities());
	}

	@Override
	public boolean supports(Class<?> authentication) {
		// TODO Auto-generated method stub
		return true;
	}

}
