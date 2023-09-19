package com.team3.spring.service;

import java.util.List;

import com.team3.spring.vo.Item;

public interface MovieService {
	List<Item> getTop4Movies();
}
