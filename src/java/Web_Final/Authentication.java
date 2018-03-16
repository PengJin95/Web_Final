package Web_Final;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

/**
 *
 * @author Think
 */
@WebServlet(urlPatterns = {"/Authentication"})
public class Authentication extends HttpServlet {

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

        //If visit "/Authentication" directly, jump to other page
        if (request.getParameter("login") == null
                && request.getParameter("register") == null
                && request.getParameter("prepare") == null
                && request.getParameter("update") == null
                && request.getParameter("logout") == null) {
            if (session.getAttribute("uid") != null) {
                response.sendRedirect("index.jsp");
                return;
            } else {
                response.sendRedirect("login.jsp");
                return;
            }
        }

        if (request.getParameter("logout") != null) {
            session.invalidate();
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String connectionURL = "jdbc:mysql://localhost:3306/test";
            Connection conn = DriverManager.getConnection(connectionURL, "root", "");
            Statement st = conn.createStatement();

            if (request.getParameter("login") != null) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String query = "SELECT Uid FROM users WHERE Username = '"
                        + username + "' AND Password = '" + password + "'";
                ResultSet rs = st.executeQuery(query);
                if (rs.next()) {
                    session.setAttribute("uid", String.valueOf(rs.getInt(1)));//Store current user's information 
                    session.setAttribute("uname", username);
                    Statement st1 = conn.createStatement();
                    query = "SELECT COUNT(*) FROM comments WHERE Uid='" + session.getAttribute("uid") + "'";
                    ResultSet rs1 = st1.executeQuery(query);
                    rs1.next();
                    int cnt = Integer.valueOf(rs1.getString(1));
                    if (cnt < 10) {
                        out.println("<result>2</result>");
                    } else {
                        out.println("<result>0</result>");
                        session.setAttribute("already", true);
                    }
                } else {
                    out.println("<result>1</result>");
                }
                st.close();
                conn.close();
            } else if (request.getParameter("register") != null) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String email = request.getParameter("email");
                String first_name = request.getParameter("first_name");
                String last_name = request.getParameter("last_name");
                String query = "SELECT * FROM users WHERE Username='" + username + "" + "'";
                ResultSet rs = st.executeQuery(query);
                if (rs.next()) {
                    out.println("<result>1</result>");
                } else {
                    query = "SELECT COUNT(*) FROM users";
                    rs = st.executeQuery(query);
                    rs.next();
                    int new_uid = rs.getInt(1) + 1;
                    query = "INSERT INTO users VALUES ('" + new_uid + "', '" + username + "', '"
                            + first_name + "','" + last_name + "','" + email + "','" + password + "')";
                    st.executeUpdate(query);
                    session.setAttribute("uid", new_uid+""); //Store current user's information
                    session.setAttribute("uname", username);
                    out.println("<result>0</result>");
                }
                st.close();
                conn.close();
            } else if (request.getParameter("prepare") != null) {
                String query = "SELECT First_name, Last_name, Email FROM users WHERE Uid='" + session.getAttribute("uid") + "'";
                ResultSet rs = st.executeQuery(query);
                if (rs.next()) {
                    out.println("<userinfo>");
                    out.println("<fname>" + rs.getString(1) + "</fname>");
                    out.println("<lname>" + rs.getString(2) + "</lname>");
                    out.println("<email>" + rs.getString(3) + "</email>");
                    out.println("</userinfo>");
                } else {
                    out.println("<empty>true<empty>");
                }
                st.close();
                conn.close();
            } else if (request.getParameter("update") != null) {
                if (request.getParameter("fname") != null) {
                    String query = "UPDATE users SET First_name='" + request.getParameter("fname")
                            + "' , Last_name='" + request.getParameter("lname") + "', Email='" + request.getParameter("email") + "' WHERE Uid='" + session.getAttribute("uid") + "'";
                    st.executeUpdate(query);
                    out.println("<result>0</result>");
                } else if (request.getParameter("pwd") != null) {
                    String query = "UPDATE users SET Password='" + request.getParameter("pwd") + "' WHERE Uid='" + session.getAttribute("uid") + "'";
                    st.executeUpdate(query);
                    out.println("<result>0</result>");
                }
                st.close();
                conn.close();
            }
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
