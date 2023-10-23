package com.team3.spring.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.team3.spring.service.MemberService;
import com.team3.spring.vo.MemberUserVO;
import com.team3.spring.vo.MemberVO;

public class MemberUserDetailService implements UserDetailsService{

	@Autowired
	private MemberService service;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		MemberVO memberVO = service.login(username);
		
		if(memberVO != null) {
//			return new MemberUserVO(memberVO);
			List<GrantedAuthority> authorities = new ArrayList<>();
            String role = "ROLE_USER";
            if(memberVO.getAuthList().size() > 0 ) {
                role = memberVO.getAuthList().get(0).getAuth(); // db 값 
                System.out.println("ROLE:" + role);
            }
            authorities.add(new SimpleGrantedAuthority(role));
            return new MemberUserVO(memberVO);
		}else {
			throw new UsernameNotFoundException("user with username" + username + "dose not exist.");
		}
		
	}

}
