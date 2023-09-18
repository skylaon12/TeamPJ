package com.team3.spring.vo;

import lombok.Data;

@Data
public class MovieVO {
	private int id;
	private String name;
	private String poster_url;
	private String trailer_url;
	private String director;
	private String actress;
	private int suitableage;
}
