package com.team3.spring.config;

import javax.servlet.Filter;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

// web.xml => WebConfig.java로 대체
public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer{
	
	// Root WebApplicationContext
	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] { RootConfig.class };
	}
	
	// Servlet WebApplicationContext
	@Override
	protected Class<?>[] getServletConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] { ServletConfig.class };
	}
	
	// DispatcherServlet Mapping
	@Override
	protected String[] getServletMappings() {
		// TODO Auto-generated method stub
		return new String[] { "/" }; // 경로
	}
	
	// 한글 filter
	@Override
	protected Filter[] getServletFilters() {	// 한글 인코딩 처리
		CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
		encodingFilter.setEncoding("UTF-8");
		encodingFilter.setForceEncoding(true);
		return new Filter[] {encodingFilter};	
	}

}
