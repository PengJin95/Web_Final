/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Web_Final;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringEscapeUtils;

/**
 *
 * @author Think
 */
@WebServlet(name = "Search", urlPatterns = {"/Search"})
public class Search extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<MovieForSearch> movies = new ArrayList<>();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String connectionURL = "jdbc:mysql://localhost:3306/test";
            Connection conn = DriverManager.getConnection(connectionURL, "root", "");
            Statement st = conn.createStatement();
            String name = request.getParameter("name");
            String query = "SELECT MovieId, Name, PosterUrlVert, ReleaseDate FROM movies WHERE Name Like '%" + name + "%'";
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                MovieForSearch movie = new MovieForSearch();
                movie.setMovieId(rs.getInt(1));
                movie.setName(StringEscapeUtils.escapeXml10(rs.getString(2)));
                movie.setPoster(rs.getString(3));
                if (rs.getString(4) == null || rs.getString(4).equals("")) {
                    movie.setRelease("N/A");
                } else {
                    movie.setRelease(rs.getString(4));
                }
                movies.add(movie);
            }
            st.close();

            String[] namepart = name.trim().split("\\s+");
            if (namepart.length > 1) {
                String sqlpart = "(";
                for (int i = 0; i < namepart.length; i++) {
                    if (i > 0) {
                        sqlpart += " OR ";
                    }
                    sqlpart += "Name REGEXP '[[:<:]]" + namepart[i] + "[[:>:]]'";
                }
                sqlpart += ")";
                query = "SELECT MovieId, Name, PosterUrlVert, ReleaseDate FROM movies WHERE Name NOT Like '%" + name + "%' AND " + sqlpart;
                Statement st2 = conn.createStatement();
                rs = st2.executeQuery(query);
                while (rs.next()) {
                    MovieForSearch movie = new MovieForSearch();
                    movie.setMovieId(rs.getInt(1));
                    movie.setName(StringEscapeUtils.escapeXml10(rs.getString(2)));
                    movie.setPoster(rs.getString(3));
                    if (rs.getString(4) == null || rs.getString(4).equals("")) {
                        movie.setRelease("N/A");
                    } else {
                        movie.setRelease(rs.getString(4));
                    }
                    movies.add(movie);
                }
                st2.close();
            }
            conn.close();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (movies.size() == 0) {
            out.println("<empty>true</empty>");
        } else {
            int page = (request.getParameter("page") == null || request.getParameter("page").length() == 0) ? 1 : Integer.valueOf(request.getParameter("page"));
            int tpage = movies.size() / 12 + (movies.size() % 12 != 0 ? 1 : 0);
            out.println("<movies>");
            for (int i = page * 12 - 12; i < movies.size() && i < page * 12; i++) {
                out.println("<movie>");
                out.println("<id>" + movies.get(i).getMovieId() + "</id>");
                out.println("<name>" + movies.get(i).getName() + "</name>");
                System.out.println(movies.get(i).getMovieId()+ ": " + movies.get(i).getName());
                out.println("<poster>" + movies.get(i).getPoster() + "</poster>");
                out.println("<date>" + movies.get(i).getRelease() + "</date>");
                out.println("</movie>");
            }
            out.println("<page>" + page + "</page>");
            out.println("<tpage>" + tpage + "</tpage>");
            out.println("</movies>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
