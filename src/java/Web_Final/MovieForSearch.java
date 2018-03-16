/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Web_Final;

import java.beans.*;
import java.io.Serializable;

/**
 *
 * @author Think
 */
public class MovieForSearch implements Serializable {

    private int movieId;
    private String name;
    private String poster;
    private String release;

    public MovieForSearch() {
        movieId = 0;
        name = null;
        poster = null;
        release = null;
    }
    
    public int getMovieId() {
        return movieId;
    }
    
    public void setMovieId(int id) {
        movieId = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }

    public String getPoster() {
        return poster;
    }
    
    public void setPoster(String url) {
        poster = url;
    }
    
    public String getRelease() {
        return release;
    }
    
    public void setRelease(String date) {
        release = date;
    }
}
