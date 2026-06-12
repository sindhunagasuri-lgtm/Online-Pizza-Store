package com.becod.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("email");

        // -------- SESSION ----------
        HttpSession session = request.getSession();
        session.setAttribute("email", username);

        // -------- COOKIE (VISIT COUNT) ----------
        int visitCount = 1;
        Cookie[] cookies = request.getCookies();

        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("visitCount_" + username)) {
                    visitCount = Integer.parseInt(c.getValue());
                    visitCount++;
                }
            }
        }

        Cookie visitCookie = new Cookie("visitCount_" + username, String.valueOf(visitCount));
        visitCookie.setMaxAge(60 * 60 * 24 * 30);
        response.addCookie(visitCookie);

        response.sendRedirect("MenuServlet");
    }
}