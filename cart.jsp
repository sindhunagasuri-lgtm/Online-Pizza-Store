<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, com.becod.servlet.CartItem" %>

<%
    // Get cart from session
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if(cart == null){
        cart = new ArrayList<CartItem>();
        session.setAttribute("cart", cart);
    }

    // Remove single item
    String removeItem = request.getParameter("removeItem");
    if(removeItem != null){
        Iterator<CartItem> it = cart.iterator();
        while(it.hasNext()){
            CartItem item = it.next();
            if(item.getName().equals(removeItem)){
                it.remove();
                break;
            }
        }
    }

    // Clear cart
    if(request.getParameter("clearCart") != null){
        cart.clear();
        session.removeAttribute("discountPercent");
    }

    // Increase / Decrease quantity
    String incItem = request.getParameter("incQty");
    String decItem = request.getParameter("decQty");

    if(incItem != null || decItem != null){
        for(CartItem item : cart){
            if(item.getName().equals(incItem)){
                item.setQty(item.getQty() + 1);
                break;
            }
            if(item.getName().equals(decItem)){
                if(item.getQty() > 1){
                    item.setQty(item.getQty() - 1);
                }
                break;
            }
        }
    }

    // -------- COUPON LOGIC --------
    Double discountPercent = (Double) session.getAttribute("discountPercent");
    if(discountPercent == null){
        discountPercent = 0.0;
    }

    String couponMsg = "";
    String couponCode = request.getParameter("couponCode");

    if(couponCode != null){
        couponCode = couponCode.trim().toUpperCase();

        if(couponCode.equals("BECOD10")){
            discountPercent = 10.0;
            couponMsg = "Coupon Applied! 10% Discount 🎉";
        }
        else if(couponCode.equals("PIZZA20")){
            discountPercent = 20.0;
            couponMsg = "Coupon Applied! 20% Discount 🎉";
        }
        else if(couponCode.equals("WELCOME30")){
            discountPercent = 30.0;
            couponMsg = "Coupon Applied! 30% Discount 🎉";
        }
        else{
            discountPercent = 0.0;
            couponMsg = "Invalid Coupon Code ❌";
        }

        session.setAttribute("discountPercent", discountPercent);
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Cart | Pizza Becod</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
:root{
    --primary:#ffbe33;
    --secondary:#ff4d4d;
    --dark:#121212;
    --card:#1e1e1e;
}
*{box-sizing:border-box}
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
.btn{
    background:var(--primary);
    color:#000;
    padding:5px 12px;
    border-radius:30px;
    text-decoration:none;
    font-weight:bold;
    border:none;
    cursor:pointer;
    margin:2px;
    font-size:0.85rem;
}
.container{
    padding:30px 8%;
}
.cart-card{
    background:var(--card);
    border-radius:15px;
    padding:12px 15px;
    margin-bottom:10px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}
.cart-left{
    display:flex;
    align-items:center;
    gap:10px;
}
.qty{
    font-weight:bold;
    color:var(--primary);
}
.total-box{
    margin-top:15px;
    padding:15px;
    background:#000;
    border-radius:15px;
    display:flex;
    justify-content:space-between;
    font-weight:bold;
}
.empty{
    text-align:center;
    margin-top:60px;
    color:#666;
    font-size:1.1rem;
}
.recommendation{
    width:250px;
    border-radius:10px;
    padding:4px 6px;
    background:#121212;
    color:#fff;
    border:1px solid #444;
    font-size:0.85rem;
}
.customize{
    display:flex;
    gap:8px;
    font-size:0.8rem;
    margin-left:10px;
}

.customize label{
    background:#121212;
    padding:3px 6px;
    border-radius:10px;
    cursor:pointer;
}

.customize input{
    margin-right:3px;
}

</style>
</head>

<body>

<header>
    <div class="logo">PIZZA<span style="color:white">BECOD</span></div>
    <a href="menu.jsp" class="btn">⬅ Back to Menu</a>
</header>

<div class="container">
    <h2 style="color:var(--primary);">🛒 Your Cart</h2>

<%
    double total = 0;

    if(cart.isEmpty()){
%>
        <div class="empty">
            Your cart is hungry 🍕 <br><br>
            Go add some delicious pizzas!
        </div>
<%
    } else {

        for(CartItem item : cart){
            double itemTotal = item.getPrice() * item.getQty();
            total += itemTotal;
%>

    <div class="cart-card">
        <div class="cart-left">
            <strong><%= item.getName() %></strong>

            <form method="post">
                <button type="submit" name="decQty" value="<%= item.getName() %>" class="btn">−</button>
            </form>

            <span class="qty"><%= item.getQty() %></span>

            <form method="post">
                <button type="submit" name="incQty" value="<%= item.getName() %>" class="btn">+</button>
            </form>
           <% 
// Show customization only for pizzas
if(item.getName().toLowerCase().contains("pizza")){ 
%>

<div class="customize">

<label>
<input type="checkbox" name="extra_cheese_<%= item.getName() %>">
Extra Cheese
</label>

<label>
<input type="checkbox" name="extra_olives_<%= item.getName() %>">
Olives
</label>

<label>
<input type="checkbox" name="thin_crust_<%= item.getName() %>">
Thin Crust
</label>

<label>
<input type="checkbox" name="extra_spicy_<%= item.getName() %>">
Make it Spicy
</label>

</div>

<% } %>


        </div>
        

        <div>
            ₹<%= itemTotal %>

            <form method="post" style="display:inline;">
                <button type="submit" name="removeItem" value="<%= item.getName() %>" class="btn">Remove</button>
            </form>
        </div>
    </div>

<%
        }

        double finalAmount = total;
        if(discountPercent > 0){
            finalAmount = total - (total * discountPercent / 100);
        }
%>

    <!-- Subtotal (Never Changes) -->
    <div class="total-box">
        <span>Total Amount</span>
        <span>₹<%= total %></span>
    </div>

    <!-- Coupon Section -->
    <form method="post" style="margin-top:15px; display:flex; gap:10px;">
        <input type="text" name="couponCode"
               placeholder="Enter Coupon Code"
               style="padding:6px; border-radius:20px; border:none; outline:none;">
        <button type="submit" class="btn">Apply</button>
    </form>

<% if(!couponMsg.equals("")){ %>
    <p style="margin-top:8px; color:<%= discountPercent > 0 ? "lightgreen" : "red" %>;">
        <%= couponMsg %>
    </p>
<% } %>

    <!-- Final Payable Amount (Reduced Only Here) -->
<% if(discountPercent > 0){ %>
    <div class="total-box">
        <span>Final Payable Amount</span>
        <span style="color:var(--primary);">
            ₹<%= finalAmount %>
        </span>
    </div>
<% } %>

    <form method="post" style="margin-top:15px;">
        <button type="submit" name="clearCart" class="btn">Clear Cart</button>
    </form>

    <form method="post" action="payment.jsp" style="margin-top:20px; text-align:right;">
    <!-- You can pass the final amount as hidden input (optional) -->
    <input type="hidden" name="finalAmount" value="<%= finalAmount %>">
    <button type="submit" class="btn">Proceed to Payment</button>
</form>

<%
    }
%>

</div>
</body>
</html>
