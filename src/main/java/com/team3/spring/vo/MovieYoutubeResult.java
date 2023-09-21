package com.team3.spring.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class MovieYoutubeResult {
	public String key;
	public String type;
}
