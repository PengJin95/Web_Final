package Web_Final;

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
@WebServlet(name = "loadCurrentUserComment", urlPatterns = {"/loadCurrentUserComment"})
public class loadCurrentUserComment extends HttpServlet {
    private Connection conn;
    String connectionURL = "jdbc:mysql://localhost:3306/test";
    String USERNAME = "root";
    String PASSWORD = "";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml;charset=UTF-8");
        HttpSession session = request.getSession();
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(connectionURL, USERNAME, PASSWORD);
           String uid = (String) session.getAttribute("uid");
           String MovieID=request.getParameter("MovieId");
           Statement st8=conn.createStatement();
           Statement st9=conn.createStatement();
             //uid=1,movieid=54
          
           String query4="SELECT comments.uid "+
                   "FROM comments "+
                   "WHERE comments.movieID=" +MovieID+
                   " AND comments.uid="+uid;
           ResultSet rs8=st8.executeQuery(query4);
           String query5="";
           if(rs8.next()){
                query5="SELECT comments.comment, comments.date,Users.username "+
                  "FROM comments "+
                  "INNER JOIN Users on comments.Uid=Users.uid "+
                  "WHERE comments.movieID=" +MovieID+
                  " AND comments.uid="+uid;
          ResultSet rs9=st9.executeQuery(query5);
                out.println("<commentSelf>");
            if(rs9.next()){
                out.println("<commentS>"+rs9.getString("comment")+"</commentS>");
                out.println("<usernameS>"+rs9.getString("username")+"</usernameS>");
                out.println("<dateS>"+rs9.getString("date")+"</dateS>");
             }
             rs8.close();  
             rs9.close();
             out.println("</commentSelf>");   
               }
          
          st8.close();
          st9.close();
          
        
       //   st8.close();
           /*String query="SELECT comments.comment "+
                   "FROM comments "+
                   "WHERE comments.movieID=" +
                request.getParameter("MovieId")+
                " AND comments.Uid="+request.getParameter("uid");
            ResultSet rs4=st4.executeQuery(query);
          
            String query2="";
            if(rs4.next()){
                query2="UPDATE comments "+
                  // "SET comments.Rating="+rating+",comments.Date='"+df.format(time)+"',comments.Comment='"+comment+"'"+
                   "SET comments.Date='"+df.format(time)+"',comments.Comment='"+comment+"'"+
                   " WHERE comments.uid="+uid+ 
                   " AND comments.movieid="+MovieID;
            }
            else{
             //query2 = "INSERT INTO comments(MovieID,UID,rating,date,comment) VALUES ('" + MovieID + "', '"
             //+  uid + "','" + rating + "',INSERT INTO comments(MovieID,UID,rating) VALUES('" + MovieID + "','"+ uid +"','" + rating + "'),'" + comment + "')";
               query2 = "INSERT INTO comments(MovieID,UID,date,comment) VALUES ('" + MovieID + "', '"
                            +  uid + "','" + df.format(time) + "','" + comment + "')";
            }
             st4.executeUpdate(query2); 
            query =  "SELECT comments.Comment,comments.date,Users.username " +
                "FROM comments " +
                "INNER JOIN Users on comments.Uid=Users.uid "+
                "WHERE comments.movieID=" +
                request.getParameter("MovieId")+
                " AND comments.Uid="+request.getParameter("uid");
            ResultSet rs5=st5.executeQuery(query);//1
 */           
          
        }
     catch (SQLException e1){
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
