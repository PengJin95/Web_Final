package Web_Final;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author chracyc
 */
@WebServlet(name = "recommendbase", urlPatterns = {"/recommendbase"})
public class recommendbase extends HttpServlet {
    private Connection conn;
    String connectionURL = "jdbc:mysql://localhost:3306/test";
    String USERNAME = "root";
    String PASSWORD = "";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(connectionURL, USERNAME, PASSWORD);
            Statement st1 = conn.createStatement();
            ResultSet rs1 = st1.executeQuery(
            "SELECT m.movieId,m.PosterUrlVert,m.Name,c.Name as director " +
            "FROM movies m,credit c " +
            "WHERE m.movieId = c.movieId AND c.Character = 'director' " +
            "ORDER BY rand() " + 
            "LIMIT 8");
            
            out.println("<movies>");
            while(rs1.next()){
                out.println("<movie>");
                out.println("<mid>"+rs1.getString("movieId")+"</mid>");
                out.println("<name>"+rs1.getString("name")+"</name>");
                out.println("<director>"+rs1.getString("director")+"</director>");
                out.println("<postervert>"+rs1.getString("PosterUrlVert")+"</postervert>");
                out.println("</movie>");
            }
            out.println("</movies>");
            rs1.close();
            st1.close();
            conn.close();
        }catch (SQLException e1){
            e1.printStackTrace();
        }catch (ClassNotFoundException e2){
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
