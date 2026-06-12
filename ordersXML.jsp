<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.sql.*, javax.servlet.http.Cookie" %><%
    // 1. Force the browser to download the file as an Excel-compatible CSV
    response.setHeader("Content-Disposition", "attachment; filename=\"MyOrders_PizzaBecod.csv\"");

    String username = null;
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(Cookie c : cookies){
            if("username".equals(c.getName())){
                username = c.getValue();
                break;
            }
        }
    }

    if(username == null) {
        out.print("Unauthorized Access");
        return;
    }

    // 2. CSV Table Headers
    // This is the first row of your table
    out.print("Order ID,Date,Item Name,Qty,Item Price,Total Paid,Status\n");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pizzastore", "root", "sindhuindu");

        String sql = "SELECT o.order_id, o.order_date, o.total_amount, o.status, " +
                     "oi.item_name, oi.price, oi.qty " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.id " +
                     "LEFT JOIN order_items oi ON o.order_id = oi.order_id " +
                     "WHERE u.name = ? " +
                     "ORDER BY o.order_id DESC";

        ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        rs = ps.executeQuery();

        while(rs.next()){
            // 3. Writing Table Rows
            // We use commas to separate columns and \n to start a new row
            out.print(rs.getInt("order_id") + ",");
            out.print(rs.getString("order_date") + ",");
            out.print("\"" + rs.getString("item_name") + "\","); // Quotes handle names with spaces/commas
            out.print(rs.getInt("qty") + ",");
            out.print(rs.getDouble("price") + ",");
            out.print(rs.getDouble("total_amount") + ",");
            out.print(rs.getString("status") + "\n");
        }

    } catch(Exception e) {
        out.print("Error generating table: " + e.getMessage());
    } finally {
        if(rs != null) rs.close();
        if(ps != null) ps.close();
        if(conn != null) conn.close();
    }
%>