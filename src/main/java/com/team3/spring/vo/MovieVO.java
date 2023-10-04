package com.team3.spring.vo;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
@JsonIgnoreProperties(ignoreUnknown = true)
@Data
public class MovieVO {
	private int page;
    private ArrayList<Item> results;
    private int total_results;
}
