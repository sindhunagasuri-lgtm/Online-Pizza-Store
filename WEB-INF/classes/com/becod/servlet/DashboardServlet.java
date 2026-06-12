package com.becod.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /* ================= COOKIE SECTION ================= */

        String cookieUser = null;
        Cookie[] cookies = request.getCookies();

        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("username".equals(c.getName())) {
                    cookieUser = c.getValue();
                    break;
                }
            }
        }

        if (cookieUser == null) {
            response.sendRedirect("login.html");
            return;
        }

        /* ================= SESSION SECTION ================= */

        HttpSession session = request.getSession();

        String username = (String) session.getAttribute("welcomeUser");
        if (username == null) {
            username = cookieUser;
            session.setAttribute("welcomeUser", username);
        }

        Integer visitCount = (Integer) session.getAttribute("visitCount");
        if (visitCount == null) {
            visitCount = 1;
        } else {
            visitCount = visitCount + 1;
        }
        session.setAttribute("visitCount", visitCount);

        String lastLogin = (String) session.getAttribute("lastLoginTime");

        Date currentDate = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
        String currentTime = formatter.format(currentDate);

        session.setAttribute("lastLoginTime", currentTime);

        Calendar cal = Calendar.getInstance();
        int hour = cal.get(Calendar.HOUR_OF_DAY);

        String message = "";
        String slogan = "";

        if (hour < 12) {
            message = "Good Morning";
            slogan = "Start your day with positivity!";
        } else if (hour < 17) {
            message = "Good Afternoon";
            slogan = "Keep pushing forward!";
        } else if (hour < 21) {
            message = "Good Evening";
            slogan = "Relax and refresh yourself!";
        } else {
            message = "Good Night";
            slogan = "Rest well and recharge!";
        }

        /* ================= SEND TO JSP ================= */

        request.setAttribute("message", message);
        request.setAttribute("slogan", slogan);
        request.setAttribute("visitCount", visitCount);
        request.setAttribute("lastLogin", lastLogin);
        request.setAttribute("currentTime", currentTime);
        request.setAttribute("cookieUser", cookieUser);

        RequestDispatcher rd = request.getRequestDispatcher("dashboard.jsp");
        rd.forward(request, response);
    }
}