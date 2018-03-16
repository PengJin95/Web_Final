package Web_Final;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import javax.servlet.http.HttpSession;
/**
 *
 * @author wangshuang
 */
@WebServlet(name = "addNewComment", urlPatterns = {"/addNewComment"})
public class addNewComment extends HttpServlet {
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
            Statement st4 = conn.createStatement();
            Statement st5 = conn.createStatement();
            Statement st6=conn.createStatement();
            Statement st7=conn.createStatement();
         //   Statement st8=conn.createStatement();
             //uid=1,movieid=54
           String uid = (String) session.getAttribute("uid");
           String MovieID=request.getParameter("MovieId");
           Date time=new Date();
           java.text.SimpleDateFormat df= new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
           String comment=request.getParameter("commentN");//convert to int?
           String caseN= request.getParameter("case");
           System.out.println();
           int rating=Integer.valueOf(request.getParameter("ratingN"));
           System.out.println("rating_value:"+rating);

           String query1="SELECT comments.uid "+
                   "FROM comments "+
                   "WHERE comments.movieID=" +MovieID+
                   " AND comments.uid="+uid;
           ResultSet rs4=st4.executeQuery(query1);
           String query2="";
           if(rs4.next()){
               if (caseN.equals("1")){//string compare use .equals("") mark
                   //if comment exit,date, uid, movieid also exit,  only need to add rating
                   query2="UPDATE comments "+
                           "SET comments.rating='"+rating+"'"+
                           " WHERE comments.uid="+uid+
                           " AND comments.movieid="+MovieID;
            }
               else if(caseN.equals("2")){
                   //if rating exit, uid, movie also exit, comment,date need to be added
                   query2="UPDATE comments "+
                           "SET comments.date='"+df.format(time)+"',comments.comment='"+comment+"'"+
                           " WHERE comments.uid="+uid+
                           " AND comments.movieid="+MovieID;
               }
           /**    else if(caseN.equals("3")){
                String query4="SELECT comments.comment, comments.date,Users.username "+
                  "FROM comments "+
                  "INNER JOIN Users on comments.Uid=Users.uid "+
                  "WHERE comments.movieID=" +MovieID+
                  " AND comments.uid="+uid;
          ResultSet rs8=st8.executeQuery(query4);
                out.println("<commentSelf>");
            if(rs8.next()){
                out.println("<commentS>"+rs8.getString("comment")+"</commentS>");
                out.println("<usernameS>"+rs8.getString("username")+"</usernameS>");
                out.println("<dateS>"+rs8.getString("date")+"</dateS>");
             }
             rs8.close();  
             out.println("</commentSelf>");   
               }
           **/    
           }
           else{
   
                   query2="INSERT INTO comments(MovieID,UID,comment,date,rating) VALUES('" + MovieID + "','"+ uid +"','" + comment + "','" + df.format(time) + "','" + rating + "')";
              
           }
          st5.executeUpdate(query2);  
          if (caseN.equals("2")){
              String query3="SELECT comments.comment, comments.date,Users.username "+
                  "FROM comments "+
                  "INNER JOIN Users on comments.Uid=Users.uid "+
                  "WHERE comments.movieID=" +MovieID+
                  " AND comments.uid="+uid;
          ResultSet rs6=st6.executeQuery(query3);
                out.println("<commentSelf>");
            if(rs6.next()){
                out.println("<commentS>"+rs6.getString("comment")+"</commentS>");
                out.println("<usernameS>"+rs6.getString("username")+"</usernameS>");
                out.println("<dateS>"+rs6.getString("date")+"</dateS>");
             }
             rs6.close();  
             out.println("</commentSelf>");
          }
          
          if (caseN.equals("1")){
              String query3="SELECT comments.rating "+
                      "FROM comments "+
                      "WHERE comments.movieID=" +MovieID+
                      " AND comments.uid="+uid;
          ResultSet rs7=st7.executeQuery(query3);
                out.println("<ratingSelf>");
            if(rs7.next()){
                out.println("<rating>"+rs7.getInt("rating")+"</rating>");  
            }
             rs7.close();
             out.println("</ratingSelf>");
          }
          st4.close();
          st5.close();
          st6.close();
          st7.close();
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
