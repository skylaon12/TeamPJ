package com.team3.spring.vo;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class MovieDetailVO {
	public boolean adult;
    public int budget;
    public ArrayList<MovieDetailGenre> genres;
    public int id;
    public String original_title;
    public String overview;
    public String poster_path;
    public String release_date;
    public int revenue;
    public int runtime;
    public String status;
    public String title;
    public double vote_average;
    public int vote_count;
}
