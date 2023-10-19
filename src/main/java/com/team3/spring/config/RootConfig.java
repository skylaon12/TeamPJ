package com.team3.spring.config;

import org.apache.commons.dbcp2.BasicDataSource;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@MapperScan(basePackages = {"com.team3.spring.mapper"}) // 이 부분이 <mybatis-spring:scan base-package="com.board.mapper" /> 부분
@ComponentScan(basePackages = {"com.team3.spring.service"})
@Import(value=MailConfig.class)
// @PropertySource({"classpath:persistence-mysql.properties"}) // 외부에서 가져올 경우에만
// propertysource는 resources에서 데이터 끌어오기
// autowired environment 이어주고 resources 에서 데이터 가져오기
public class RootConfig {
	
//	@Autowired
//	private Environment env;
	// DB 설정
	@Bean
	public BasicDataSource dataSource() {
		BasicDataSource datasource = new BasicDataSource();
		datasource.setDriverClassName("com.mysql.cj.jdbc.Driver");
		datasource.setUrl("jdbc:mysql://localhost:3306/movie_db");
		datasource.setUsername("root");
		datasource.setPassword("root");
//		datasource.setDriverClassName(env.getProperty("jdbc.driver")); @propertysource 용
//		datasource.setUrl(env.getProperty("jdbc.url")); 
//		datasource.setUsername(env.getProperty("jdbc.user"));
//		datasource.setUsername(env.getProperty("jdbc.password"));
		System.out.println("datasource빈 초기화");
		return datasource;
	}
	
	// mybatis 설정
	@Bean
	public SqlSessionFactoryBean sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
		sqlSessionFactory.setDataSource(dataSource());
		// sqlSessionFactory.setConfigLocation(new PathMatchingResourcePatternResolver().getResources(locationPattern));
		// 위 사항은 root-context쪽에 <property name="configLocation" value="classpath:...."이 있을시에만 작성
		System.out.println("SqlSession빈 초기화");
		 return sqlSessionFactory;
//		return (SqlSessionFactory)sqlSessionFactory.getObject(); // 형변환 만약 public SqlSessionFactory 일시 형변환해서 타입 넘겨주기
		 
	}
}
