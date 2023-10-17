package com.team3.spring.service;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.team3.spring.mapper.MemberMapper;
import com.team3.spring.mapper.MovieMapper;
import com.team3.spring.mapper.TicketingMapper;
import com.team3.spring.vo.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	@Setter(onMethod_ = @Autowired)
	private MovieMapper m_mapper;
	@Setter(onMethod_ = @Autowired)
	private TicketingMapper t_mapper;
	@Setter(onMethod_ = @Autowired)
	private JavaMailSenderImpl mailSender;
	@Override
	public MemberVO login(String id, String pw) {
		return mapper.login(id, pw);
	}

	@Override
	public int signup(MemberVO memberVO) {
		return mapper.signup(memberVO);
		
	}
	// 가람님 개선
	@Override
	public int checkAccount(String account) {
		return mapper.checkAccount(account);
	}
	
	@Override
	public int checkEmail(String email1, String email2) {
		return mapper.checkEmail(email1, email2);
	}
	

	@Override
	public void userInfoModify(MemberVO membervo) {
		log.info("유저일련번호 : " + membervo.getId());
		log.info("수정된 이름 : " + membervo.getName());
		log.info("수정된 이메일 로컬주소 : " + membervo.getEmail1());
		log.info("수정된 이메일도메인주소 : " + membervo.getEmail2());
		log.info("수정된 핸드폰 번호 : " + membervo.getPhonenumber());
		log.info("수정된 나이 : " + membervo.getAge());
		mapper.userInfoModify(membervo);
		t_mapper.userInfoModify(membervo.getName(), membervo.getId());
		m_mapper.userInfoModify(membervo.getName(), membervo.getId());
		
		
	}

	@Override
	public void userPwdModify(MemberVO membervo) {
		mapper.userPwdModify(membervo);
	}

	@Override
	public void userDelete(int id) {
		mapper.userDelete(id);
		t_mapper.userDelete(id);
		m_mapper.userDelete(id);
	}

}
