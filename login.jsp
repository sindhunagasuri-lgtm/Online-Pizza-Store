<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Check empty
    if (email == null || password == null ||
        email.trim().equals("") || password.trim().equals("")) {
        response.sendRedirect("login.html");
        return;
    }
    
     if(email.equals("admin@gmail.com") && password.equals("admin123")){
        response.sendRedirect("http://localhost/pizzastore/admin_dashboard.php");
        return;
    }


    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {

        // Load driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect database
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/pizzastore",
            "root",
            "sindhuindu"
        );

        // Query
        String query = "SELECT * FROM users WHERE email=? AND password=?";
        ps = con.prepareStatement(query);
        ps.setString(1, email);
        ps.setString(2, password);

        rs = ps.executeQuery();

        if (rs.next()) {

    String name = rs.getString("name");

    // 🔥 Increase visit count in database
    PreparedStatement updatePs = con.prepareStatement(
        "UPDATE users SET visit_count = visit_count + 1 WHERE name = ?"
    );
    updatePs.setString(1, name);
    updatePs.executeUpdate();
    updatePs.close();

    // Create session
    session.setAttribute("user", name);

    // Create cookie
    Cookie c = new Cookie("username", name);
    c.setMaxAge(60 * 60); // 1 hour
    c.setPath("/");
    response.addCookie(c);

    response.sendRedirect("menu.jsp");
    return;
}
        else {
            response.sendRedirect("login.html");
            return;
        }

    } catch (Exception e) {
        out.println("Database Error: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
