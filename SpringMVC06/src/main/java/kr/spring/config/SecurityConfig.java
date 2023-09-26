package kr.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import kr.spring.security.MemberUserDetailsService;

@Configuration // WebConfig.java에서 SecurityCOnfig를 읽어오기 위한 어노테이션
@EnableWebSecurity // web에서 security를 사용하겠다는 어노테이션


public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Bean // 만들어 놓은 MemberUserDetailService 메모리로 올려서 사용한다.
	public UserDetailsService MemberUserDetailsService() {
		return new MemberUserDetailsService();
	}
	

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		// 만든 memberuserdetailsservice와 암호화 및 복호화를 해주는 패스워드 인코더를 Spring security에 등록하는 메소드 
		auth.userDetailsService(MemberUserDetailsService()).passwordEncoder(passwordEncoder());
	}



	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		//인코딩을 여기에서 해줌 웹컨피그에서 한걸 동일하게 해줌
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter, CsrfFilter.class);
	
		//Spring Security 환경 설정하는 클래스
		//요청에 대한 보안 설정을 해주는 클래스
	
		//원하는 보안은 http에 적용시켜주면 됨.(클라이언트의 요청을 디스페쳐가 받기 전 시큐리티가 먼저 받아주기때문)
		
		http
			.authorizeRequests() /* 요청에 따른 권한을 처리하겠다. (요청에 따라서 권한을 주겠다) */
				.antMatchers("/") /* 컨텍스트 뒤 (/)까지 요청했을때는 모든 사람에게 오픈해준다 어떤 경로로 왔을때 권한처리를 할지 */
					.permitAll() /* 누구나 접근 가능하도록 전체에게 권한을 줌 */
						.and() /*로그인과 회원가입은 누구에게나 접근 가능하게 오픈해줘야함.*/
					.formLogin() /* 로그인 보안기능을 추가하겠다. */
						.loginPage("/loginForm.do") /* spring security에서 제공하는 로그인 폼이 아닌 자체제작 로그인 폼 사용하겠다. */
						.loginProcessingUrl("/login.do") /* 해당 url로 요청이 들어왔을 때 Spring Security 자체 로그인 기능을 수행하겠다. */
						.permitAll() /* 모두에게 로그인 권한을 줌. */
						.and() /* 권한 추가 */
					.logout() /* 로그아웃 기능 */
						.invalidateHttpSession(true) /* 스프링 시큐리티를 이용하여 세션 만료를 통한 로그아웃 진행 */
						.logoutSuccessUrl("/") /* 로그아웃 성공 후 메인페이지로 이동할 페이지. */
						.and() /* 권한추가 */
					.exceptionHandling().accessDeniedPage("/access-denied"); /* 특정 페이지는 로그인 안할 경우 접근 불가하게 하고, denied 페이지로 이동 */
	}
	
	

	
	//객체로 등록할때는 bean으로 등록한다. 루트컨텍스트에서 객체로 가져올때 사용했었음..
	@Bean
	public PasswordEncoder passwordEncoder() {
		// Spring security 메소드 활용한 비밀번호 암호화
		return new BCryptPasswordEncoder();
	}
	
	
	
}
