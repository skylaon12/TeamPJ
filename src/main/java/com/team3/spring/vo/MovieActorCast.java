package com.team3.spring.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class MovieActorCast {
	private String original_name;
	private String profile_path;
	private String character;
}
