package com.team3.spring.config;

import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;

// Spring security 동작 클래스
// AbstractSecurityWebApplicationInitializer클래스를 상속하여 SecurityInitializer를 생성한다.
// - 내부적으로 DelegatingFilterProxy를 스프링에 등록하여 Spring security를 내부적으로 동작시킨다

public class SecurityInitializer extends AbstractSecurityWebApplicationInitializer{
	/*
	 * 이곳에서 따로 코딩해줄 것은 없고
	 * 클래스Name 에 AbstractSecurityWebApplicationInitializer 상속시켜서 security 동작 클래스로 만들고
	 * 동작 클래스로 인해서 spring security를 쓸수있는 일반적인 api들을 메모리 위에다가 객체를 생성
	 * 
	 */
}
