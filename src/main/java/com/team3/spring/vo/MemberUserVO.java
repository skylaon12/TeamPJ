package com.team3.spring.vo;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

@Data
public class MemberUserVO  extends User{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private MemberVO memberVO;
	
	public MemberUserVO(String username, String password,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public MemberUserVO(MemberVO memberVO) {
		super(memberVO.getAccount(), memberVO.getPwd(), memberVO.getAuthList().stream()
				.map(auth->new SimpleGrantedAuthority(auth.getAuth()))
				.collect(Collectors.toList()));
		this.memberVO = memberVO;
	}
}
