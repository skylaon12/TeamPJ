package com.team3.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import com.team3.spring.security.MemberUserDetailService;

// Spring security 환경 설정
/*
 *WebSecurityConfigurerAdapter클래스를 상속하여 SecurityConfig객체를 생성한다.
 *- @EnableWebSecurity는 SpringMVC와 Spring security를 결합하는 클래스(어노테이션?)이다
 *- configure() 메소드를 Override하고 관련 설정을 한다. 
 *Spring security를 웹에서 적용하는것이기 때문에 spring과 spring security를 연결시키기 위한 어노테이션이 @enableWebsecurity
 *
 */

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	// 회원 인증 부분
	@Bean
	public UserDetailsService memberUserDetailsService() {
		return new MemberUserDetailService();
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(memberUserDetailsService())
		.passwordEncoder(passwordEncoder());
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// 보안과 관련된 요청이 왔을때 SecurityConfig 클래스가 configure() 메소드안에서 동작을 한다
		// 요청에대한 보안 설정
		
		// 한글 인코딩 부분
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter,CsrfFilter.class); 
		
		// 요청에따른 권한을 확인하여 서비스하는 부분
		http
			.authorizeRequests() // 리소스의 접근
				.antMatchers("/").permitAll()	// antMatchers 설정한 리소스의 접근을 인증절차 없이 허용한다는 의미
				// 이렇게 필터로 처리하게 되면 modal창을 띄우지를 못해서 컨트롤러 자체에서 권한 확인 진행함
				.antMatchers("/admin/**").hasRole("ADMIN") // 권한이 있는 사용자만 접근 가능
				.antMatchers("/notice/write").hasRole("ADMIN") // 권한이 있는 사용자만 접근 가능
				.and()
			.formLogin() // 로그인 페이지와 기타 로그인 처리 및 성공 실패 처리를 사용하겠다는 의미
				.loginPage("/member/login") // 사용자가 따로 만든 로그인 페이지를 사용하려고 할때 설정
				.loginProcessingUrl("/member/loginProc").permitAll() // 로그인 즉 인증 처리를 하는 URL을 설정(인증처리필터 호출)
//				.defaultSuccessUrl("/") // 정상적으로 인증성공 했을 경우 이동하는 페이지를 설정
				.and()
			.logout() // 로그아웃 처리
				.logoutUrl("/logout")
				.invalidateHttpSession(true) // 세션 제거
				.logoutSuccessUrl("/") // 로그아웃처리 성공 처리후 이동(/)
				.and()
			.exceptionHandling().accessDeniedPage("/access-denied"); // 오류페이지 이동
	}
	// 패스워드 인코딩 객체
	// 메모리에 만들어진 객체를 의존성 주입해서 사용
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
