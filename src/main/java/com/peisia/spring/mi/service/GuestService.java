package com.peisia.spring.mi.service;


import java.util.List;

import com.peisia.spring.mi.vo.GuestVO;

public interface GuestService {
	public List<GuestVO> getList(int currentPage);
	public GuestVO read(long bno);
	public void del(long bno);
	public void write(GuestVO gvo);
	public void modify(GuestVO gvo);
}
