<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,java.sql.*,com.becod.servlet.CartItem"%>

<%
List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

if(cart == null || cart.isEmpty()){
    response.sendRedirect("cart.jsp");
    return;
}

Double discountPercent=(Double)session.getAttribute("discountPercent");
if(discountPercent==null) discountPercent=0.0;

double total=0;
for(CartItem item:cart){
    total+=item.getPrice()*item.getQty();
}

double finalAmount=total-(total*discountPercent/100);

/* USERNAME FROM COOKIE */
String username=null;
Cookie[] cookies=request.getCookies();
if(cookies!=null){
    for(Cookie c:cookies){
        if(c.getName().equals("username")){
            username=c.getValue();
        }
    }
}

/* GET ADDRESS FROM DATABASE */
String address="";
int userId=0;
try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/pizzastore","root","sindhuindu");
    PreparedStatement ps=conn.prepareStatement("SELECT address,id FROM users WHERE name=?");
    ps.setString(1,username);
    ResultSet rs=ps.executeQuery();
    if(rs.next()){
        address=rs.getString("address");
        userId=rs.getInt("id");
        session.setAttribute("userId",userId);
    }
    rs.close(); ps.close(); conn.close();
}catch(Exception e){}

String message="";

/* LOGIC: GENERATE OTP OR HANDLE COD */
if(request.getParameter("payNow")!=null){
    String selectedMethod = request.getParameter("paymentMethod");
    session.setAttribute("selectedPayment", selectedMethod);

    if("cod".equals(selectedMethod)){
        message = "Cash on Delivery Selected. Please click 'Confirm Order'.";
        session.setAttribute("otp", "COD_MODE"); // Flag to show confirmation button
    } else {
        String otp=String.valueOf((int)(Math.random()*9000)+1000);
        session.setAttribute("otp",otp);
        message="OTP Generated: "+otp+" ";
    }
}

/* VERIFY OTP / CONFIRM ORDER */
if(request.getParameter("verifyOTP")!=null || request.getParameter("confirmOrder")!=null){
    String entered = request.getParameter("otp");
    String generated = (String)session.getAttribute("otp");
    String methodUsed = (String)session.getAttribute("selectedPayment");

    boolean isAuthorized = false;
    if("COD_MODE".equals(generated)) {
        isAuthorized = true; // COD doesn't need OTP verification
    } else if(entered != null && entered.equals(generated)) {
        isAuthorized = true;
    }

    if(isAuthorized){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn2=DriverManager.getConnection("jdbc:mysql://localhost:3306/pizzastore","root","sindhuindu");
            
            // LOGIC: Set status based on payment method
            String orderStatus = "Preparing"; 
            if("cod".equals(methodUsed)){
                orderStatus = "Pending";
            }

            /* INSERT ORDER */
            PreparedStatement ps2=conn2.prepareStatement(
                "INSERT INTO orders(user_id,total_amount,status) VALUES(?,?,?)",
                Statement.RETURN_GENERATED_KEYS
            );
            ps2.setInt(1, (Integer)session.getAttribute("userId"));
            ps2.setDouble(2, finalAmount);
            ps2.setString(3, orderStatus);
            ps2.executeUpdate();

            ResultSet keys=ps2.getGeneratedKeys();
            int orderId = keys.next() ? keys.getInt(1) : 0;

            /* INSERT ORDER ITEMS */
            PreparedStatement itemPs=conn2.prepareStatement("INSERT INTO order_items(order_id,item_name,price,qty) VALUES(?,?,?,?)");
            for(CartItem item:cart){
                itemPs.setInt(1,orderId);
                itemPs.setString(2,item.getName());
                itemPs.setDouble(3,item.getPrice());
                itemPs.setInt(4,item.getQty());
                itemPs.executeUpdate();
            }
            
            cart.clear();
            session.removeAttribute("discountPercent");
            session.removeAttribute("otp");
            response.sendRedirect("bill.jsp?orderId="+orderId);
            return;
        }catch(Exception e){ message="Error placing order: " + e.getMessage(); }
    } else {
        message="❌ Invalid OTP";
    }
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout | Pizza Becod</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body{ margin:0; font-family:Poppins; background:#121212; color:white; }
        header{ background:#000; padding:20px; font-size:22px; font-weight:bold; color:#ff4d4d; text-align:center; }
        .container{ display:grid; grid-template-columns:2fr 1fr; gap:30px; padding:30px 8%; }
        .card{ background:#1e1e1e; padding:20px; border-radius:15px; }
        h2{ color:#ffbe33; }
        table{ width:100%; border-collapse:collapse; margin-top:15px; }
        th,td{ padding:10px; border-bottom:1px solid #444; }
        input,textarea,select{ width:100%; padding:10px; border-radius:8px; border:none; margin-top:10px; box-sizing: border-box; }
        button{ background:#ffbe33; color:black; border:none; padding:12px 25px; border-radius:25px; font-weight:bold; cursor:pointer; margin-top:15px; width: 100%; }
        .qr{ width:160px; margin-top:10px; }
        .hidden{ display:none; }
        .total{ font-size:20px; font-weight:bold; color:#ffbe33; }
    </style>
</head>
<body>

<header>PIZZA BECOD CHECKOUT</header>

<div class="container">
    <div class="card">
        <form method="post">
            <h2>Delivery Address</h2>
            <textarea rows="3" name="address"><%=address%></textarea>

            <h2>Payment Method</h2>
            <select id="paymentMethod" name="paymentMethod" required>
                <option value="">Select</option>
                <option value="card">Credit / Debit Card</option>
                <option value="card">Net Banking</option>
                <option value="upi">UPI</option>
                <option value="cod">Cash On Delivery</option>
            </select>

            <div id="cardBox" class="hidden">
                <h3>Card Details</h3>
                <input type="text" placeholder="Card Number">
                <input type="text" placeholder="Expiry MM/YY">
                <input type="text" placeholder="CVV">
            </div>

            <div id="upiBox" class="hidden">
                <h3>Scan UPI QR</h3>
                <img class="qr" src="https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=pizza-becod-payment">
            </div>

            <button type="submit" name="payNow">Proceed to Payment</button>
        </form>

        <%-- OTP OR CONFIRMATION SECTION --%>
        <% if(session.getAttribute("otp") != null) { %>
            <hr style="margin-top:20px; border:1px solid #333;">
            <form method="post">
                <% if("COD_MODE".equals(session.getAttribute("otp"))) { %>
                    <p>You have chosen Cash on Delivery. Your order will be marked as <b>Pending</b>.</p>
                    <button type="submit" name="confirmOrder" style="background:#4caf50; color:white;">Confirm Order</button>
                <% } else { %>
                    <h3>Enter OTP</h3>
                    <input type="text" name="otp" placeholder="Enter 4-digit OTP" required>
                    <button type="submit" name="verifyOTP">Verify & Place Order</button>
                <% } %>
            </form>
        <% } %>

        <p style="color:yellow; text-align:center;"><%=message%></p>
    </div>

    <div class="card">
        <h2>Your Order</h2>
        <table>
            <tr><th>Item</th><th>Qty</th><th>Price</th></tr>
            <% for(CartItem item:cart){ %>
            <tr>
                <td><%=item.getName()%></td>
                <td><%=item.getQty()%></td>
                <td>₹<%=item.getPrice()*item.getQty()%></td>
            </tr>
            <% } %>
        </table>
        <hr>
        <p>Total: ₹<%=total%></p>
        <% if(discountPercent>0){ %><p>Discount: <%=discountPercent%>%</p><% } %>
        <p class="total">Final: ₹<%=finalAmount%></p>
    </div>
</div>

<script>
    const method = document.getElementById("paymentMethod");
    const cardBox = document.getElementById("cardBox");
    const upiBox = document.getElementById("upiBox");

    method.addEventListener("change", function(){
        cardBox.style.display = (this.value == "card") ? "block" : "none";
        upiBox.style.display = (this.value == "upi") ? "block" : "none";
    });
</script>

</body>
</html>