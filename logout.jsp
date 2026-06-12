<%
    session.invalidate();
    response.sendRedirect("login.html");
%>
<%@ page import="javax.servlet.http.Cookie" %>

<%
Cookie cookie = new Cookie("userEmail", "");

/* Set expiry to 0 to delete */
cookie.setMaxAge(0);

response.addCookie(cookie);

out.println("Cookie Deleted Successfully");
%>