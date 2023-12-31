package com.team3.spring.config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailConfig {
	@Bean
	public JavaMailSender javaMailSender() {
		Properties mailProperties = new Properties();
		System.out.println("메일 빈 초기화");
		mailProperties.put("mail.transport.protocol", "smtp");
		mailProperties.put("mail.smtp.auth","true");
		mailProperties.put("mail.smtp.starttls.enable","true");
		mailProperties.put("mail.smtp.debug", "true");
		mailProperties.put("mail.smtp.ssl.trust","smtp.gmail.com");
		mailProperties.put("mail.smtp.ssl.protocols","TLSv1.2");
		
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setJavaMailProperties(mailProperties);
		mailSender.setHost("smtp.gmail.com");
		mailSender.setPort(587);
		mailSender.setUsername("이메일 주소 입력");
		mailSender.setPassword("패스워드 입력");
		mailSender.setDefaultEncoding("utf-8");
		
		return mailSender;
	}
	
	
}
