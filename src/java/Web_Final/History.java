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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.StringEscapeUtils;

/**
 *
 * @author Think
 */
@WebServlet(name = "History", urlPatterns = {"/History"})
public class History extends HttpServlet {

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
        response.setContentType("text/xml;charset=UTF-8");
        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String connectionURL = "jdbc:mysql://localhost:3306/test";
            Connection conn = DriverManager.getConnection(connectionURL, "root", "");
            Statement st = conn.createStatement();
            String query = "SELECT * FROM comments WHERE Uid='" + session.getAttribute("uid") + "'";
            ResultSet rs = st.executeQuery(query);
            out.println("<movies>");
            while (rs.next()) {
                int movieId = Integer.valueOf(rs.getString(1));
                out.println("<movie>");
                out.println("<rating>" + ((int)rs.getFloat(3) == 0 ? "0":String.valueOf((int) rs.getFloat(3))) + "</rating>");
                out.println("<date>" + ((rs.getString(4)== null)?"N/A":rs.getString(4).substring(0,10)) + "</date>");
                out.println("<comment>"+ ((rs.getString(5)==null || rs.getString(5).equals(""))?"N/A":StringEscapeUtils.escapeXml10(rs.getString(5))) + "</comment>");
                Statement st1 = conn.createStatement();
                String query1 = "SELECT Name FROM movies WHERE MovieId='" + movieId +"'";
                System.out.println(query1);
                ResultSet rs1 = st1.executeQuery(query1);
                rs1.next();
                System.out.println(StringEscapeUtils.escapeXml10(rs1.getString(1)));
                out.println("<name>"+ StringEscapeUtils.escapeXml10(rs1.getString(1)) +"</name>");
                out.println("</movie>");
                rs1.close();
            }
            out.println("</movies>");
            rs.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
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
