/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package getMovieInfo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author wangshuang
 */
@WebServlet(name = "getMovieInfo", urlPatterns = {"/getMovieInfo"})
public class getMovieInfo extends HttpServlet {

    private Connection conn;
    String connectionURL = "jdbc:mysql://localhost:3306/test";
    String USERNAME = "root";
    String PASSWORD = "";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml;charset=UTF-8");
        System.out.println("This is servlet");
        HttpSession session = request.getSession();
        String uid = (String) session.getAttribute("uid");
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(connectionURL, USERNAME, PASSWORD);
            Statement st1 = conn.createStatement();
            Statement st2 = conn.createStatement();
            Statement st3 = conn.createStatement();
            Statement st4 = conn.createStatement();
            ResultSet rs1 = st1.executeQuery(
                    "SELECT m.movieId,m.Name,m.PosterUrlVert,m.ReleaseDate,m.Overview,m.Duration,c.name as director,m.trailerurl "
                    + "FROM movies m,credit c "
                    + "WHERE m.movieId=c.MovieId AND c.Character='director' AND m.MovieID="
                    + request.getParameter("MovieId"));
            ResultSet rs2 = st2.executeQuery(
                    "SELECT c.name as actor "
                    + "FROM credit c "
                    + "WHERE c.Character not like 'director' AND c.movieId="
                    + request.getParameter("MovieId"));
            ResultSet rs3 = st3.executeQuery(
                    "SELECT cm.Comment,cm.Date,Users.username "
                    + "FROM comments cm "
                    + "INNER JOIN Users on cm.Uid=Users.uid "
                    + "WHERE cm.Uid!='"+ uid +"' AND cm.MovieID="
                    + request.getParameter("MovieId")
            //  "EXCEPT "+                           
            //SELECT all comments except current user's, 
            //"SELECT cm.Comment,User.username "+
            //"From comments cm "+
            //"INNER JOIN User on cm.Uid=Users.uid "+
            //"WHERE cm.Uid='1'AND cm.MovieID="+
            //request.getParameter("MovieId")
            );

            System.out.println("This is servlet2");

            out.println("<movieinfo>");
            if (rs1.next()) {
                out.println("<movieid>" + rs1.getString("movieId") + "</movieid>");
                out.println("<name>" + rs1.getString("name") + "</name>");
                out.println("<director>" + rs1.getString("director") + "</director>");
                out.println("<postervert>" + rs1.getString("PosterUrlVert") + "</postervert>");
                out.println("<releasedate>" + rs1.getString("ReleaseDate") + "</releasedate>");
                out.println("<overview>" + rs1.getString("Overview") + "</overview>");
                out.println("<duration>" + rs1.getString("Duration") + "</duration>");
                out.println("<trailer>" + rs1.getString("trailerurl") + "</trailer>");
            }
            rs1.close();
            st1.close();
            out.println("<actors>");
            while (rs2.next()) {
                out.println("<actor>" + rs2.getString("actor") + "</actor>");
            }
            out.println("</actors>");
            rs2.close();
            st2.close();
            out.println("<comments>");
            int i = 0;
            while (rs3.next()) {
                out.println("<comment>" + rs3.getString("Comment") + "</comment>");
                out.println("<username>" + rs3.getString("username") + "</username>");
                out.println("<date>" + rs3.getString("date") + "</date>");
            }
            System.out.println("output comment times:" + i);
            out.println("</comments>");
            rs3.close();
            st3.close();
            out.println("</movieinfo>");

        } catch (SQLException e1) {
            e1.printStackTrace();
        } catch (ClassNotFoundException e2) {
            e2.printStackTrace();
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
