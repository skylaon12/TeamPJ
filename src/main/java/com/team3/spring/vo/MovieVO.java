package com.team3.spring.vo;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class MovieVO {
	public int page;
    public ArrayList<Item> results;
}
