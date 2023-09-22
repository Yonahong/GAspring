package kr.spring.config;

import javax.servlet.Filter;

import org.springframework.beans.propertyeditors.ClassArrayEditor;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {
		//web.xml를 대체할 java class
		//web.xml의 기능을 담고있는 클래스를 상속받는다

		
	
	
	
	
		@Override
		protected Class<?>[] getRootConfigClasses() {
			// DB 설정관련 RootCOnfig.java 파일을 가져온다.
			// DB 관련 설정이 RootConfig 외의 다른 설정도 있을 수 있음으로
			//리턴타입이 배열로 되어있음
			return new Class[] {RootConfig.class, SecurityConfig.class};
		}

		@Override
		protected Filter[] getServletFilters() {
			// 인코딩 설정하는 부분
			
			//선언
			CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
			
			//
			encodingFilter.setEncoding("UTF-8");
			encodingFilter.setForceEncoding(true);
			return new Filter[] {encodingFilter};
		}

		@Override
		protected Class<?>[] getServletConfigClasses() {
			// Servlet 설정 관련 있는 ServletConfig.java 파일을 가져온다
			
			return new Class[] {ServletConfig.class};
		}

		@Override
		protected String[] getServletMappings() {
			// url의 시작점 컨텍스트패쓰 뒤의 "/"를 지정해주는부분
			return new String[] {"/"};
		}
		
	}

	
	


