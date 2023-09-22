package kr.spring.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@MapperScan(basePackages = {"kr.spring.mapper"}) // mapper interface 메모리에 올리기 위한 경로 설정
@PropertySource({"classpath:persistence-mysql.properties"})

public class RootConfig {
	//root-context.xml를 대체할 클래스
	@Autowired
	//스프링 내의 내용을 자동으로 끌어오는 오토와이어드
	Environment env; // 내가 만든 properties 파일을 읽어오는 객체
	
	@Bean // 메모리에 사용 할 수 있게 로딩하는 어노테이션
	
	public DataSource myDataSource() {
		HikariConfig hikariConfig = new HikariConfig();
		hikariConfig.setDriverClassName(env.getProperty("jdbc.driver"));
		hikariConfig.setJdbcUrl(env.getProperty("jdbc.url"));
		hikariConfig.setUsername(env.getProperty("jdbc.user"));
		hikariConfig.setPassword(env.getProperty("jdbc.password"));
		
		HikariDataSource myDataSource = new HikariDataSource(hikariConfig);
		return myDataSource;
		
	}
	@Bean
	public SqlSessionFactory sessionFactory() throws Exception{
		SqlSessionFactoryBean sessionfactory = new SqlSessionFactoryBean();
		sessionfactory.setDataSource(myDataSource());
		return (SqlSessionFactory) sessionfactory.getObject();
	}
	
}
