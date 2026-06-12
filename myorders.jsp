<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.Cookie" %>
<%@ page import="javax.xml.parsers.*, org.w3c.dom.*, java.net.*" %>

<%
String username = null;

// ✅ Get username from cookie
Cookie[] cookies = request.getCookies();
if(cookies != null){
    for(Cookie c : cookies){
        if("username".equals(c.getName())){
            username = c.getValue();
            break;
        }
    }
}

// If not logged in
if(username == null){
    response.sendRedirect("login.html");
    return;
}

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/pizzastore",
        "root",
        "sindhuindu"
    );
    
    // ✅ Auto Update Order Status Based on Time
    PreparedStatement autoPs = conn.prepareStatement(
        "UPDATE orders SET status = " +
        "CASE " +
        "WHEN TIMESTAMPDIFF(MINUTE, order_date, NOW()) >= 1 AND status='Pending' THEN 'Preparing' " +
        "WHEN TIMESTAMPDIFF(MINUTE, order_date, NOW()) >= 2 AND status='Preparing' THEN 'Out for Delivery' " +
        "WHEN TIMESTAMPDIFF(MINUTE, order_date, NOW()) >= 3 AND status='Out for Delivery' THEN 'Delivered' " +
        "ELSE status END"
    );
    autoPs.executeUpdate();
    autoPs.close();


    // ✅ Handle Cancel Order
    String cancelId = request.getParameter("cancelId");
    if(cancelId != null){
        ps = conn.prepareStatement(
           "UPDATE orders SET status='Cancelled' WHERE order_id=? AND (status='Pending' OR status='Preparing')"
        );
        ps.setInt(1, Integer.parseInt(cancelId));
        ps.executeUpdate();
        ps.close();
    }

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Orders | Pizza Becod</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
:root{
    --primary:#ffbe33;
    --secondary:#ff4d4d;
    --dark:#121212;
    --card:#1e1e1e;
}
body{
    margin:0;
    font-family:Poppins,sans-serif;
    background:var(--dark);
    color:#fff;
}
header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:20px 8%;
    background:#000;
}
.logo{
    font-size:26px;
    font-weight:bold;
    color:var(--secondary);
}
.container{
    padding:30px 8%;
}
table{
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
}
th, td{
    padding:12px;
    text-align:center;
}
th{
    background:var(--primary);
    color:#000;
}
tr{
    background:var(--card);
}
tr:nth-child(even){
    background:#222;
}
.cancel-btn{
    background:var(--secondary);
    border:none;
    padding:6px 12px;
    color:white;
    border-radius:6px;
    cursor:pointer;
}
.cancel-btn:hover{
    opacity:0.8;
}
.status-cancelled{
    color:red;
    font-weight:bold;
}
.status-pending{
    color:#ffbe33;
    font-weight:bold;
}
</style>
</head>

<body>

<header>
    <div class="logo">PIZZA<span style="color:white">BECOD</span></div>
    <a href="menu.jsp" style="color:var(--primary);text-decoration:none;">⬅ Back to Menu</a>
    <a href="ordersXML.jsp" style="color:var(--primary);text-decoration:none;">My orders</a>
</header>

<div class="container">
    <h2 style="color:var(--primary);">🧾 My Orders</h2>

<%
    // ✅ Get user ID
    ps = conn.prepareStatement("SELECT id FROM users WHERE name=?");
    ps.setString(1, username);
    rs = ps.executeQuery();

    int userId = 0;
    if(rs.next()){
        userId = rs.getInt("id");
    }
    rs.close();
    ps.close();

    // ✅ Get Orders
    ps = conn.prepareStatement(
        "SELECT * FROM orders WHERE user_id=? ORDER BY order_date DESC"
    );
    ps.setInt(1, userId);
    rs = ps.executeQuery();
%>

<table>
<tr>
    <th>Order ID</th>
    <th>Total Amount</th>
    <th>Status</th>
    <th>Date</th>
    <th>Action</th>
</tr>

<%
boolean hasOrders = false;

while(rs.next()){
    hasOrders = true;
    int orderId = rs.getInt("order_id");
    String status = rs.getString("status");
%>

<tr>
    <td>#<%= orderId %></td>
    <td>₹<%= rs.getDouble("total_amount") %></td>
    <td class="<%= status.equals("Cancelled") ? "status-cancelled" : "status-pending" %>">
        <%= status %>
    </td>
    <td><%= rs.getString("order_date") %></td>
    <td>
        <% if("Pending".equals(status)){ %>
            <form method="post" style="display:inline;">
                <input type="hidden" name="cancelId" value="<%= orderId %>">
                <button type="submit" class="cancel-btn">Cancel</button>
            </form>
        <% } else { %>
            -
        <% } %>
    </td>
</tr>

<%
}

if(!hasOrders){
%>
<tr>
    <td colspan="5">No orders yet 🍕</td>
</tr>
<%
}
%>

</table>

</div>
</body>
</html>

<%
}catch(Exception e){
    out.println("Error: " + e.getMessage());
}
finally{
    if(rs!=null) rs.close();
    if(ps!=null) ps.close();
    if(conn!=null) conn.close();
}
%>