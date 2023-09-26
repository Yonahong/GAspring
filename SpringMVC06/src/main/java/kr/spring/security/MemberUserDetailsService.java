package kr.spring.security;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.spring.entity.Member;
import kr.spring.entity.MemberUser;
import kr.spring.mapper.MemberMapper;

public class MemberUserDetailsService implements UserDetailsService {
	//Spring Security에서 mapper를 사용하기 위한 연결 클래스 -> service
	
	@Autowired
	private MemberMapper mapper;
	
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// 여기서의 username은 id를 말한다. id를 기준으로 로그인 정보를 가져올것임.
		// 보여지진 않지만 spring security가 해당 username을 가진 계정을 가져오고
		// 암호화된 비밀번호를 비교해서 로그인을 체크하는 메소드.
		
		//로그인 처리하기
		// spring security가 로그인 기능을 마친 상태로 보고
		// 개발자는 중간에 비밀번호를 알 수 있는 방법이 없음
		Member mvo = mapper.login(username);
		
		//로그인에 성공 후 session에 값을 담아야하는데, spring Security 보안 규정 상 커스텀한 클래스 객체 (VO)를 담을 수 없음
		//원하는 VO를 담을 수 있게 변환해주는 User Class가 필요함.
		
		if(mvo != null) {
			//사용자가 존재할 경우
			return new MemberUser(mvo); 
		}else {
			//유저가 존재하지 않을 경우
			throw new UsernameNotFoundException("user with username" + username + "does not exist.");			
		}
		
		
	}



	
	
	
}
