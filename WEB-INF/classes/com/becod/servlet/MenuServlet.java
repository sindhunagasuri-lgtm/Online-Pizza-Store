package com.becod.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class MenuServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.html");
            return;
        }

        String username = (String) session.getAttribute("username");

        // -------- COOKIE VISITS ----------
        int visitCount = 1;
        Cookie[] cookies = request.getCookies();

        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("visitCount_" + username)) {
                    visitCount = Integer.parseInt(c.getValue());
                }
            }
        }

        // -------- LAST LOGOUT TIME ----------
        ServletContext context = getServletContext();
        String lastLogoutTime = (String) context.getAttribute(username + "_logout");

        // Set attributes
        request.setAttribute("username", username);
        request.setAttribute("visitCount", visitCount);
        request.setAttribute("lastLogoutTime", lastLogoutTime);

        RequestDispatcher rd = request.getRequestDispatcher("menu.html");
        rd.forward(request, response);
    }
}