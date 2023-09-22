package kr.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

@Configuration // WebConfig.java에서 SecurityCOnfig를 읽어오기 위한 어노테이션
@EnableWebSecurity // web에서 security를 사용하겠다는 어노테이션


public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		//인코딩을 여기에서 해줌 웹컨피그에서 한걸 동일하게 해줌
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter, CsrfFilter.class);
	}
	//Spring Security 환경 설정하는 클래스
	//요청에 대한 보안 설정을 해주는 클래스

	
	//객체로 등록할때는 bean으로 등록한다. 루트컨텍스트에서 객체로 가져올때 사용했었음..
	@Bean
	public PasswordEncoder passwordEncoder() {
		// Spring security 메소드 활용한 비밀번호 암호화
		return new BCryptPasswordEncoder();
	}
	
	
	
}
