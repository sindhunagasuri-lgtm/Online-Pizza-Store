<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>

<%
    String orderIdStr = request.getParameter("orderId");
    if(orderIdStr == null) { response.sendRedirect("menu.jsp"); return; }
    
    int orderId = Integer.parseInt(orderIdStr);
    Connection conn = null;
    PreparedStatement psOrder = null;
    PreparedStatement psItems = null;
    ResultSet rsOrder = null;
    ResultSet rsItems = null;

    double totalAmount = 0;
    String orderDate = "";
    String status = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pizzastore","root","sindhuindu");

        // 1. Fetch Main Order Details
        psOrder = conn.prepareStatement("SELECT * FROM orders WHERE order_id=?");
        psOrder.setInt(1, orderId);
        rsOrder = psOrder.executeQuery();

        if(rsOrder.next()){
            totalAmount = rsOrder.getDouble("total_amount");
            status = rsOrder.getString("status");
            orderDate = rsOrder.getString("order_date");
        }

        // 2. Fetch Specific Items for this Order
        psItems = conn.prepareStatement("SELECT * FROM order_items WHERE order_id=?");
        psItems.setInt(1, orderId);
        rsItems = psItems.executeQuery();

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Digital Receipt | Pizza Becod</title>
    <meta http-equiv="refresh" content="20;URL=menu.jsp">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #ffbe33;
            --success: #4caf50;
            --pending: #ff9800;
            --bg: #0f0f0f;
            --glass: rgba(255, 255, 255, 0.05);
        }

        body {
            margin: 0;
            font-family: 'Outfit', sans-serif;
            background: radial-gradient(circle at top right, #1a1a1a, #000);
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .receipt-container {
            background: var(--glass);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 28px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.6);
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
        }

        .header { text-align: center; margin-bottom: 25px; }
        .header h2 { color: var(--primary); margin: 5px 0; font-size: 1.8rem; }
        
        /* Item Table Styling */
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 0.9rem;
        }

        .items-table th {
            text-align: left;
            color: #777;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        .items-table td {
            padding: 12px 0;
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }

        .item-name { font-weight: 600; color: #fff; }
        .item-qty { color: var(--primary); font-size: 0.8rem; margin-left: 5px; }

        .summary {
            background: rgba(0,0,0,0.2);
            padding: 20px;
            border-radius: 15px;
            margin-top: 10px;
        }

        .row { display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 0.9rem; }
        .total-row {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px dashed #444;
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--primary);
        }

        .status-pill {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: bold;
            text-transform: uppercase;
            background: <%= status.equalsIgnoreCase("Pending") ? "var(--pending)" : "var(--success)" %>;
            color: #000;
        }

        .footer-actions {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            font-family: inherit;
            transition: 0.3s;
            text-align: center;
            text-decoration: none;
        }

        .btn-print { background: #333; color: white; }
        .btn-home { background: var(--primary); color: black; }
        .btn:hover { opacity: 0.8; transform: translateY(-2px); }

        .timer {
            text-align: center;
            font-size: 0.75rem;
            color: #555;
            margin-top: 20px;
        }

        @media print {
            .footer-actions, .timer, body { background: white !important; }
            .receipt-container { border: 1px solid #000; box-shadow: none; color: black; }
            .item-name, .total-row { color: black !important; }
        }
    </style>
</head>
<body>

<div class="receipt-container">
    <div class="header">
        <div style="font-size: 2rem;">🍕</div>
        <h2>Pizza Becod</h2>
        <p style="font-size: 0.8rem; color: #666;">Order #<%= orderId %> | <%= orderDate %></p>
        <div class="status-pill"><%= status %></div>
    </div>

    <table class="items-table">
        <thead>
            <tr>
                <th>Item</th>
                <th style="text-align: right;">Total</th>
            </tr>
        </thead>
        <tbody>
            <% 
                while(rsItems.next()) { 
                    double pPrice = rsItems.getDouble("price");
                    int pQty = rsItems.getInt("qty");
            %>
            <tr>
                <td>
                    <span class="item-name"><%= rsItems.getString("item_name") %></span><br>
                    <span class="item-qty">x<%= pQty %> @ ₹<%= pPrice %></span>
                </td>
                <td style="text-align: right; font-weight: 600;">
                    ₹<%= pPrice * pQty %>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <div class="summary">
        <div class="row">
            <span>Subtotal</span>
            <span>₹<%= totalAmount %></span>
        </div>
        <div class="row">
            <span>Delivery Fee</span>
            <span style="color: var(--success);">FREE</span>
        </div>
        <div class="total-row">
            <span>Total Amount</span>
            <span>₹<%= totalAmount %></span>
        </div>
    </div>

    <div class="footer-actions">
        <a href="javascript:window.print()" class="btn btn-print">Print Bill</a>
        <a href="menu.jsp" class="btn btn-home">Order More</a>
    </div>

    <div class="timer">
        Redirecting to menu in <span id="sec">20</span>s
    </div>
</div>

<script>
    let timeLeft = 20;
    setInterval(() => {
        if(timeLeft > 0) {
            timeLeft--;
            document.getElementById('sec').innerText = timeLeft;
        }
    }, 1000);
</script>

</body>
</html>

<%
    } catch(Exception e) { 
        out.println("Error: " + e.getMessage()); 
    } finally {
        if(rsItems != null) rsItems.close();
        if(psItems != null) psItems.close();
        if(rsOrder != null) rsOrder.close();
        if(psOrder != null) psOrder.close();
        if(conn != null) conn.close();
    }
%>