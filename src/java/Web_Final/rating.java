package Web_Final;

import java.io.IOException;
import java.sql.*;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author chracyc
 */
@WebServlet(urlPatterns = {"/rating"})
public class rating extends HttpServlet {

    private Connection conn;
    String connectionURL = "jdbc:mysql://localhost:3306/test";
    String USERNAME = "root";
    String PASSWORD = "";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        session.setAttribute("already", true);
        response.setContentType("text/html;charset=UTF-8");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(connectionURL, USERNAME, PASSWORD);
            Date time = new Date();
            java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
            PreparedStatement st0 = conn.prepareStatement(
                    "INSERT INTO comments (MovieId,Rating,Uid,Date,Comment) VALUES (?,?,?,?,?)");
            String mvid0 = request.getParameter("mvid0");
            String rating0 = request.getParameter("rating0");
            st0.setString(1, mvid0);
            st0.setFloat(2, Float.parseFloat(rating0));
            st0.setString(3, String.valueOf(session.getAttribute("uid")));
            st0.setString(4, df.format(time));
            st0.setString(5, "N/A");
            st0.executeUpdate();
            st0.close();
            PreparedStatement st1 = conn.prepareStatement(
                    "INSERT INTO comments (MovieId,Rating,Uid,Date,Comment) VALUES (?,?,?,?,?)");
            String mvid1 = request.getParameter("mvid1");
            String rating1 = request.getParameter("rating1");
            st1.setString(1, mvid1);
            st1.setFloat(2, Float.parseFloat(rating1));
            st1.setString(3, String.valueOf(session.getAttribute("uid")));
            st1.setString(4, df.format(time));
            st1.setString(5, "N/A");
            st1.executeUpdate();
            st1.close();
            PreparedStatement st2 = conn.prepareStatement(
                    "INSERT INTO comments (MovieId,Rating,Uid,Date,Comment) VALUES (?,?,?,?,?)");
            String mvid2 = request.getParameter("mvid2");
            String rating2 = request.getParameter("rating2");
            st2.setString(1, mvid2);
            st2.setFloat(2, Float.parseFloat(rating2));
            st2.setString(3, String.valueOf(session.getAttribute("uid")));
            st2.setString(4, df.format(time));
            st2.setString(5, "N/A");
            st2.executeUpdate();
            st2.close();
            PreparedStatement st3 = conn.prepareStatement(
                    "INSERT INTO comments (MovieId,Rating,Uid,Date,Comment) VALUES (?,?,?,?,?)");
            String mvid3 = request.getParameter("mvid3");
            String rating3 = request.getParameter("rating3");
            st3.setString(1, mvid3);
            st3.setFloat(2, Float.parseFloat(rating3));
            st3.setString(3, String.valueOf(session.getAttribute("uid")));
            st3.setString(4, df.format(time));
            st3.setString(5, "N/A");
            st3.executeUpdate();
            st3.close();
            PreparedStatement st4 = conn.prepareStatement(
                    "INSERT INTO comments (MovieId,Rating,Uid,Date,Comment) VALUES (?,?,?,?,?)");
            String mvid4 = request.getParameter("mvid4");
            String rating4 = request.getParameter("rating4");
            st4.setString(1, mvid4);
            st4.setFloat(2, Float.parseFloat(rating4));
            st4.setString(3, String.valueOf(session.getAttribute("uid")));
            st4.setString(4, df.format(time));
            st4.setString(5, "N/A");
            st4.executeUpdate();
            st4.close();
            PreparedStatement st5 = conn.prepareStatement(
                    "INSERT INTO comments (MovieId,Rating,Uid,Date,Comment) VALUES (?,?,?,?,?)");
            String mvid5 = request.getParameter("mvid5");
            String rating5 = request.getParameter("rating5");
            st5.setString(1, mvid5);
            st5.setFloat(2, Float.parseFloat(rating5));
            st5.setString(3, String.valueOf(session.getAttribute("uid")));
            st5.setString(4, df.format(time));
            st5.setString(5, "N/A");
            st5.executeUpdate();
            st5.close();
            PreparedStatement st6 = conn.prepareStatement(
                    "INSERT INTO comments (MovieId,Rating,Uid,Date,Comment) VALUES (?,?,?,?,?)");
            String mvid6 = request.getParameter("mvid6");
            String rating6 = request.getParameter("rating6");
            st6.setString(1, mvid6);
            st6.setFloat(2, Float.parseFloat(rating6));
            st6.setString(3, String.valueOf(session.getAttribute("uid")));
            st6.setString(4, df.format(time));
            st6.setString(5, "N/A");
            st6.executeUpdate();
            st6.close();
            PreparedStatement st7 = conn.prepareStatement(
                    "INSERT INTO comments (MovieId,Rating,Uid,Date,Comment) VALUES (?,?,?,?,?)");
            String mvid7 = request.getParameter("mvid7");
            String rating7 = request.getParameter("rating7");
            st7.setString(1, mvid7);
            st7.setFloat(2, Float.parseFloat(rating7));
            st7.setString(3, String.valueOf(session.getAttribute("uid")));
            st7.setString(4, df.format(time));
            st7.setString(5, "N/A");
            st7.executeUpdate();
            st7.close();
            PreparedStatement st8 = conn.prepareStatement(
                    "INSERT INTO comments (MovieId,Rating,Uid,Date,Comment) VALUES (?,?,?,?,?)");
            String mvid8 = request.getParameter("mvid8");
            String rating8 = request.getParameter("rating8");
            st8.setString(1, mvid8);
            st8.setFloat(2, Float.parseFloat(rating8));
            st8.setString(3, String.valueOf(session.getAttribute("uid")));
            st8.setString(4, df.format(time));
            st8.setString(5, "N/A");
            st8.executeUpdate();
            st8.close();
            PreparedStatement st9 = conn.prepareStatement(
                    "INSERT INTO comments (MovieId,Rating,Uid,Date,Comment) VALUES (?,?,?,?,?)");
            String mvid9 = request.getParameter("mvid9");
            String rating9 = request.getParameter("rating9");
            st9.setString(1, mvid9);
            st9.setFloat(2, Float.parseFloat(rating9));
            st9.setString(3, String.valueOf(session.getAttribute("uid")));
            st9.setString(4, df.format(time));
            st9.setString(5, "N/A");
            st9.executeUpdate();
            st9.close();
            conn.close();
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
