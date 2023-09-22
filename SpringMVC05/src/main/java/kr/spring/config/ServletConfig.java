package kr.spring.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import lombok.extern.apachecommons.CommonsLog;

@EnableWebMvc // config java ㅋ를래스가 Spring mvc 구조상에서 작동하기 위한 어노테이션
@Configuration // webCOnfig에서 설정파일로 인식될 수 있게 달아주는 어노테이션
@ComponentScan (basePackages = {"kr.spring.controller"}) // controller 패키지가 여러개일 시 {},{} 처럼 추가해줄 수 있다.



public class ServletConfig implements WebMvcConfigurer{ // servlet-context.xml의 기능을 가지고 있는 interface
	//servlet-context.xml를 대체할 클래스
	
	
	
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		InternalResourceViewResolver bean = new InternalResourceViewResolver();
		bean.setPrefix("/WEB-INF/views/");
		bean.setSuffix(".jsp");
		
		//만들은 빈을 레지스트리에 담아줘야함
		registry.viewResolver(bean);
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
		WebMvcConfigurer.super.addResourceHandlers(registry);
		
	}
	
	
	
	
	
}
