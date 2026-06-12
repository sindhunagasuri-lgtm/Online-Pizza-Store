package com.becod.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class FeedbackServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String context = request.getContextPath();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Pizza Store Feedback</title>");

        out.println("<style>");
        out.println("body{font-family:Arial, sans-serif;background:linear-gradient(135deg,#ff512f,#dd2476);height:100vh;margin:0;display:flex;justify-content:center;align-items:center;}");

        out.println(".container{background:white;padding:35px;width:380px;border-radius:10px;box-shadow:0 8px 25px rgba(0,0,0,0.3);text-align:center;}");

        out.println("h2{color:#ff512f;margin-bottom:20px;}");

        out.println("input,textarea,select{width:95%;padding:10px;margin:8px 0;border-radius:6px;border:1px solid #ccc;font-size:14px;}");

        out.println("textarea{resize:none;height:80px;}");

        out.println(".btn{background:#ff512f;color:white;padding:10px 20px;border:none;border-radius:5px;font-size:15px;cursor:pointer;width:100%;margin-top:10px;}");

        out.println(".btn:hover{background:#e8431c;}");

        out.println(".back{display:inline-block;margin-top:15px;text-decoration:none;background:#444;color:white;padding:8px 15px;border-radius:5px;}");

        out.println(".back:hover{background:black;}");

        out.println("</style>");

        out.println("</head>");
        out.println("<body>");

        out.println("<div class='container'>");

        out.println("<h2>Pizza Store Feedback</h2>");

        out.println("<form method='post' action='"+context+"/feedback'>");

        out.println("<input type='text' name='name' placeholder='Enter your name' required>");

        out.println("<input type='email' name='email' placeholder='Enter your email' required>");

        out.println("<textarea name='message' placeholder='Write your feedback'></textarea>");

        out.println("<select name='rating'>");
        out.println("<option value='5'>5 - Excellent</option>");
        out.println("<option value='4'>4 - Very Good</option>");
        out.println("<option value='3'>3 - Good</option>");
        out.println("<option value='2'>2 - Average</option>");
        out.println("<option value='1'>1 - Poor</option>");
        out.println("</select>");

        out.println("<button class='btn' type='submit'>Submit Feedback</button>");

        out.println("</form>");

        out.println("<a class='back' href='"+context+"/index.html'>Back to Home</a>");

        out.println("</div>");

        out.println("</body>");
        out.println("</html>");
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");
        int rating = Integer.parseInt(request.getParameter("rating"));

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String context = request.getContextPath();

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/pizzastore",
                    "root",
                    "sindhuindu"
            );

            String sql = "INSERT INTO feedback_public(name,email,message,rating) VALUES(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, message);
            ps.setInt(4, rating);

            ps.executeUpdate();

            out.println("<html>");
            out.println("<head>");

            out.println("<style>");
            out.println("body{font-family:Arial;background:linear-gradient(135deg,#ff512f,#dd2476);height:100vh;display:flex;justify-content:center;align-items:center;margin:0;color:white;text-align:center;}");

            out.println(".box{background:white;color:black;padding:40px;border-radius:10px;box-shadow:0 8px 20px rgba(0,0,0,0.3);}");


            out.println(".btn{display:inline-block;margin:10px;padding:10px 20px;background:#ff512f;color:white;text-decoration:none;border-radius:5px;}");

            out.println(".btn:hover{background:#e8431c;}");

            out.println("</style>");

            out.println("</head>");
            out.println("<body>");

            out.println("<div class='box'>");

            out.println("<h2>Feedback Submitted Successfully!</h2>");

            out.println("<a class='btn' href='"+context+"/feedback'>Submit Another</a>");

            out.println("<a class='btn' href='"+context+"/index.html'>Back to Home</a>");

            out.println("</div>");

            out.println("</body>");
            out.println("</html>");

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}