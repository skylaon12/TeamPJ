package com.team3.spring.vo;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class MovieDetailVO {
	private boolean adult;
    private int budget;
    private ArrayList<MovieDetailGenre> genres;
    private int id;
    private String original_title;
    private String overview;
    private String poster_path;
    private String release_date;
    private int revenue;
    private int runtime;
    private String status;
    private String title;
    private double vote_average;
    private int vote_count;
}
