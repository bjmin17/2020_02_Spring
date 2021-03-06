package com.biz.sec.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.biz.sec.domain.AuthorityVO;
import com.biz.sec.domain.UserDetailsVO;
import com.biz.sec.domain.UserVO;
import com.biz.sec.persistence.AuthoritiesDao;
import com.biz.sec.persistence.UserDao;

@Service
public class UserService {
	
	// @Autowired
	private final PasswordEncoder passwordEncoder;
	
	private final UserDao userDao;
	private final AuthoritiesDao authDao;
	
	public UserService(PasswordEncoder passwordEncoder, UserDao userDao, AuthoritiesDao authDao) {
		super();
		this.passwordEncoder = passwordEncoder;
		this.userDao = userDao;
		this.authDao = authDao;
		
		String create_user_table = 
				" CREATE TABLE IF NOT EXISTS tbl_users(" + 
				"	id bigint PRIMARY KEY AUTO_INCREMENT," + 
				"	user_name varchar(50) UNIQUE," + 
				"    user_pass varchar(125)," + 
				"    enabled boolean default true," +
				"    email varchar(50)," + 
				"    phone varchar(20)," + 
				"    address varchar(125)" + 
				" ) ";
		
		String create_auth_table =
				" CREATE TABLE IF NOT EXISTS authorities(" + 
				"	id bigint PRIMARY KEY AUTO_INCREMENT," + 
				"    username varchar(50)," + 
				"    authority varchar(50)" + 
				" ) ";
		
		userDao.create_table(create_user_table);
		userDao.create_table(create_auth_table);
	}


	/**
	 * @Since 2020-04-09
	 * @author bjmin17
	 * 
	 * @param username
	 * @param password
	 * @return
	 * 
	 * 회원가입을 신청하면 비밀번호는 암호화하고
	 * 아이디와 비밀번호를 DB에 insert 수행
	 * 
	 * @update 2020-04-10
	 * Map<String, String> 구조의 VO 데이터를
	 * UserVO로 변경
	 * 
	 */
	@Transactional
	public int insert(String username, String password) {
		
		// 회원가입 form에서 전달받은 password 값을 암호화시키는 과정
		
		
		
		String encPassword = passwordEncoder.encode(password);
		// 암호화한 비밀번호를 전달
//		UserVO userVO = new UserVO(username,encPassword,true);
		UserVO userVO = UserVO.builder()
							.username(username)
							.password(encPassword).build();
		
		
		int ret = userDao.insert(userVO);
		List<AuthorityVO> authList = new ArrayList();
		authList.add(AuthorityVO.builder()
				.username(userVO.getUsername())
				.authority("ROLE_USER").build());
		authList.add(AuthorityVO.builder()
				.username(userVO.getUsername())
				.authority("USER").build());
		
		authDao.insert(authList);
		
		return ret;
	}


	public boolean isExistsUserName(String username) {

		UserDetailsVO userVO = userDao.findByUserName(username);
		// 이미 DB에 회원정보(username)이 저장되어 있다.
		if(userVO != null && userVO.getUsername().equalsIgnoreCase(username)) {
			return true;
		}
		
		return false;
		
	}


	public UserDetailsVO findById(long id) {
		UserDetailsVO userVO = userDao.findById(id);
		
		return userVO;
	}


	public boolean check_password(String password) {

		// context 뽑아오고, authentication 뽑아오고, principal 뽑아오기
		// 이 방법은 본인 것만 수정 가능, 관리자는 비밀번호를 변경 못한다.
		UserDetailsVO userVO = (UserDetailsVO) SecurityContextHolder
									.getContext()
									.getAuthentication()
									.getPrincipal();
		
		return passwordEncoder.matches(password,userVO.getPassword());
	}

	@Transactional
	public int update(UserDetailsVO userVO,String[] authList) {
		
		Authentication oldAuth = SecurityContextHolder.getContext().getAuthentication();
		
		UserDetailsVO oldUserVO = (UserDetailsVO) oldAuth.getPrincipal();
		
		oldUserVO.setEmail(userVO.getEmail());
		oldUserVO.setPhone(userVO.getPhone());
		oldUserVO.setAddress(userVO.getAddress());
		
		int ret = userDao.update(userVO);
		// DB update가 성공하면
		// 로그인된 session 정보를 update 수행
		if(ret > 0) {
			
//			ret = authDao.update(new ArrayList(Arrays.asList(authList));
			List<AuthorityVO> authCollection = new ArrayList();
			for(String auth : authList) {
				// auth가 빈칸인 경우가 생기지 않게 검사
				if(!auth.isEmpty()) {
					AuthorityVO authVO = AuthorityVO.builder()
							.username(userVO.getUsername())
							.authority(auth).build();
					authCollection.add(authVO);
				}
			}
			
			authDao.delete(userVO.getUsername());
			authDao.insert(authCollection);
			
			// 새로운 session 정보를 만들때 oldUserVO로 세팅을 한다.
			Authentication newAuth = new UsernamePasswordAuthenticationToken(oldUserVO, // 변경된 사용자 정보 
					oldAuth.getCredentials(), 
					this.getAuthorities(authList)// 변경된 ROLE 정보
					);
//			 get으로 뽑아낸것중에 credential만 new Auth로 바꾸고 context에 세팅해주기
			SecurityContextHolder.getContext().setAuthentication(newAuth);
		}
		
		return ret;
	}
	
	private Collection<GrantedAuthority> getAuthorities(String[] authList) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		
		for(String auth : authList) {
			// auth가 빈칸이 아닐 경우만 추가를 시켜라
			if(!auth.isEmpty()) {
				SimpleGrantedAuthority sAuth = new SimpleGrantedAuthority(auth);
				authorities.add(sAuth);
				
			}
		}
		
		return authorities;
	}
	
	
}
