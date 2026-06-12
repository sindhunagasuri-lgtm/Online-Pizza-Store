<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.html");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pizza Becod | Menu</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
:root {
    --primary:#ffbe33;
    --secondary:#ff4d4d;
    --dark:#121212;
    --card-bg:#1e1e1e;
}
*{margin:0;padding:0;box-sizing:border-box}
body{
    font-family:Poppins,sans-serif;
    background:var(--dark);
    color:#fff;
}

/* HEADER */
header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:10px 8%;
    background:#000;
}
.logo{
    font-size:26px;
    font-weight:bold;
    color:var(--secondary);
}
.nav{
    display:flex;
    align-items:center;
    gap:20px;
}
.welcome{
    color:var(--primary);
    font-weight:600;
}

/* MENU */
.section-title{
    text-align:center;
    margin:60px 0 30px;
    color:var(--primary);
    font-size:2.5rem;
}
.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:25px;
    padding:0 8%;
}
.card{
    background:var(--card-bg);
    border-radius:20px;
    overflow:hidden;
    text-align:center;
    padding-bottom:20px;
    transition:0.3s;
}
.card:hover{
    transform:scale(1.05);
}
.card img{
    width:100%;
    height:200px;
    object-fit:cover;
}
.btn-add{
    background:var(--primary);
    border:none;
    padding:10px 25px;
    border-radius:25px;
    font-weight:bold;
    cursor:pointer;
}
.btn-logout{
    background:var(--primary);
    border:none;
    padding:8px 20px;
    border-radius:20px;
    cursor:pointer;
}
</style>
<style>
:root {
    --primary:#ffbe33;
    --secondary:#ff4d4d;
    --dark:#121212;
    --card-bg:#1e1e1e;
}
*{margin:0;padding:0;box-sizing:border-box}
body{
    font-family:Poppins,sans-serif;
    background:var(--dark);
    color:#fff;
}

/* HEADER */
header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:10px 8%;
    background:#000;
    position:sticky;
    top:0;
}
.logo{
    font-size:26px;
    font-weight:bold;
    color:var(--secondary);
    text-decoration:none;
}
.nav{
    display:flex;
    align-items:center;
    gap:20px;
}
.welcome{
    color:var(--primary);
    font-weight:600;
}
.logout{
    background:var(--secondary);
    color:#fff;
    border:none;
    padding:8px 20px;
    border-radius:20px;
    cursor:pointer;
}

/* CART */
 .cart-trigger { position: relative; color: var(--primary); font-size: 24px; cursor: pointer; margin-right: 20px; }
        #cart-count { 
            position: absolute; top: -10px; right: -12px; background: var(--secondary); 
            color: white; font-size: 12px; padding: 2px 7px; border-radius: 50%; font-weight: bold;
        }

        /* Slide-out Cart Sidebar */
        .cart-sidebar {
            position: fixed; top: 0; right: -400px; width: 380px; height: 100%;
            background: #111; box-shadow: -10px 0 30px rgba(0,0,0,0.8);
            z-index: 2000; padding: 30px; display: flex; flex-direction: column;
            border-left: 1px solid #333;
        }
        .cart-sidebar.active { right: 0; }
        .cart-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 1px solid #333; padding-bottom: 15px; }
        .cart-items { flex: 1; overflow-y: auto; }
        
        .cart-item { 
            display: flex; align-items: center; margin-bottom: 20px; background: #222; 
            padding: 12px; border-radius: 15px; border: 1px solid #333;
        }
        .cart-item-info { flex: 1; margin-left: 15px; }
        .qty-control { display: flex; align-items: center; gap: 10px; margin-top: 5px; }
        .qty-btn { background: var(--primary); border: none; width: 25px; height: 25px; border-radius: 5px; cursor: pointer; font-weight: bold; }


/* MENU */
.section-title{
    text-align:center;
    margin:60px 0 30px;
    color:var(--primary);
    font-size:2.5rem;
}
.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:25px;
    padding:0 8%;
}
.card{
    background:var(--card-bg);
    border-radius:20px;
    overflow:hidden;
    text-align:center;
    padding-bottom:20px;
}
.card img{
    width:100%;
    height:200px;
    object-fit:cover;
}
.btn-add{
    background:var(--primary);
    border:none;
    padding:10px 25px;
    border-radius:25px;
    font-weight:bold;
    cursor:pointer;
}
/* Logout Button Style */
.btn-logout { 
    background: var(--primary);   /* your theme color */
    border: none; 
    padding: 10px 25px; 
    border-radius: 30px; 
    font-weight: bold; 
    cursor: pointer; 
    color: #000; 
    display: inline-block; 
    text-decoration: none;
    transition: all 0.4s ease;
}

/* Hover Animation */
.btn-logout:hover { 
    background: #000; 
    color: var(--primary); 
    transform: translateY(-3px) scale(1.05); 
    box-shadow: 0 5px 15px var(--primary);
}

/* Click Effect */
.btn-logout:active {
    transform: scale(0.95);
}
.btn-logout {
    position: relative;
    overflow: hidden;
}

.btn-logout::before {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: rgba(255,255,255,0.3);
    transition: 0.5s;
}

.btn-logout:hover::before {
    left: 100%;
}
.search-btn{
    display:inline-block;
    padding:8px 18px;   /* reduced size */
    background:linear-gradient(45deg,#ffbe33,#ff4d4d);
    color:#000;
    font-size:14px;     /* smaller text */
    font-weight:600;
    border-radius:20px; /* slightly smaller radius */
    text-decoration:none;
    transition:0.3s ease;
    box-shadow:0 4px 10px rgba(255,77,77,0.4);
}

.search-btn:hover{
    transform:translateY(-2px);
}
.cart-trigger{
    display:inline-block;
    font-size:22px;
    color:#ffbe33;
}

.cart-trigger:hover i{
    animation:cartSlide 0.6s ease-in-out infinite alternate;
}

@keyframes cartSlide{
    from{
        transform: translateX(0);
    }
    to{
        transform: translateX(8px); /* move forward */
    }
}
@keyframes cartSlide{
    0%   { transform: translateX(0); }
    50%  { transform: translateX(10px); }
    100% { transform: translateX(0); }
}
.user-trigger{
    font-size:32px;   /* increased size */
    display:flex;
    align-items:center;
    gap:5px;
    text-decoration:none;
    transition:0.3s ease;
    padding:6px 10px;
    border-radius:20px;
}

/* Hover effect */
.user-trigger:hover{
    background:rgba(255,190,51,0.15);
    transform:translateY(-2px);
}

/* Chef bounce animation */
.user-trigger:hover{
    animation:chefBounce 0.6s ease;
}

@keyframes chefBounce{
    0%   { transform:translateY(0); }
    30%  { transform:translateY(-6px); }
    50%  { transform:translateY(2px); }
    70%  { transform:translateY(-3px); }
    100% { transform:translateY(0); }
}
.gift-trigger{
    font-size:32px;        /* adjust size if needed */
    display:flex;
    align-items:center;
    text-decoration:none;  /* remove underline */
    transition:0.3s ease;
    padding:6px 10px;
    border-radius:20px;
}

/* Hover background + lift */
.gift-trigger:hover{
    background:rgba(255,190,51,0.15);
    transform:translateY(-2px);
    animation:giftBounce 0.6s ease;
}

/* Bounce animation */
@keyframes giftBounce{
    0%   { transform:translateY(0); }
    30%  { transform:translateY(-6px); }
    50%  { transform:translateY(2px); }
    70%  { transform:translateY(-3px); }
    100% { transform:translateY(0); }
}
.welcome{
    font-size:18px;
    font-weight:600;
    color:#ffbe33;
    letter-spacing:0.5px;
    transition:0.3s ease;
    padding:6px 12px;
    border-radius:20px;
}

/* Hover effect */
.welcome:hover{
    background:rgba(255,190,51,0.15);
    transform:translateY(-2px);
    text-shadow:0 0 8px #ffbe33;
}
.welcome{
    animation:welcomeGlow 2s ease-in-out infinite alternate;
}

@keyframes welcomeGlow{
    from{
        text-shadow:0 0 5px #ffbe33;
    }
    to{
        text-shadow:0 0 15px #ff4d4d;
    }
}
.logo{
    font-size:28px;
    font-weight:bold;
    display:inline-block;
}

.logo span{
    display:inline-block;
    animation:waveJump 1s ease-in-out infinite;
}

/* Delay each letter */
.logo span:nth-child(1){ animation-delay:0s; }
.logo span:nth-child(2){ animation-delay:0.1s; }
.logo span:nth-child(3){ animation-delay:0.2s; }
.logo span:nth-child(4){ animation-delay:0.3s; }
.logo span:nth-child(5){ animation-delay:0.4s; }
.logo span:nth-child(6){ animation-delay:0.5s; }
.logo span:nth-child(7){ animation-delay:0.6s; }
.logo span:nth-child(8){ animation-delay:0.7s; }
.logo span:nth-child(9){ animation-delay:0.8s; }
.logo span:nth-child(10){ animation-delay:0.9s; }
.logo span:nth-child(11){ animation-delay:1s; }

@keyframes waveJump{
    0%   { transform: translateY(0); }
    50%  { transform: translateY(-10px); }
    100% { transform: translateY(0); }
}
/* ===== CHATBOT ADVANCED ===== */

#chatButton{
    position:fixed;
    bottom:25px;
    right:25px;
    background:linear-gradient(45deg,#6a11cb,#2575fc);
    color:#fff;
    font-size:26px;
    padding:18px;
    border-radius:50%;
    cursor:pointer;
    z-index:3000;
    animation:floatBtn 2s ease-in-out infinite;
}

@keyframes floatBtn{
    0%{transform:translateY(0);}
    50%{transform:translateY(-8px);}
    100%{transform:translateY(0);}
}

#chatContainer{
    position:fixed;
    bottom:90px;
    right:25px;
    width:320px;
    background:#111;
    border-radius:20px;
    display:none;
    flex-direction:column;
    overflow:hidden;
    z-index:3000;
    box-shadow:0 0 20px rgba(0,0,0,0.6);
    animation:fadeIn 0.3s ease;
}

@keyframes fadeIn{
    from{opacity:0;transform:translateY(20px);}
    to{opacity:1;transform:translateY(0);}
}

#chatHeader{
    background:linear-gradient(45deg,#6a11cb,#2575fc);
    padding:12px;
    font-weight:bold;
    color:#fff;
    text-align:center;
}

#chatMessages{
    height:270px;
    overflow-y:auto;
    padding:12px;
    font-size:14px;
}

#chatInputArea{
    display:flex;
    background:#222;
}

#chatInputArea input{
    flex:1;
    padding:10px;
    border:none;
    background:#222;
    color:#fff;
}

#chatInputArea button{
    background:#2575fc;
    border:none;
    padding:10px 14px;
    color:#fff;
    cursor:pointer;
}

.bot{
    background:#2575fc;
    padding:8px 12px;
    border-radius:15px;
    margin:6px 0;
    display:inline-block;
    animation:popIn 0.3s ease;
}

.user{
    text-align:right;
    margin:6px 0;
}

.user span{
    background:#6a11cb;
    padding:8px 12px;
    border-radius:15px;
    display:inline-block;
}

@keyframes popIn{
    from{transform:scale(0.8);opacity:0;}
    to{transform:scale(1);opacity:1;}
}
</style>
</head>

<body>

<header>
    <a class="logo">
    <span>P</span>
    <span>I</span>
    <span>Z</span>
    <span>Z</span>
    <span>A</span>
    <span class="space"> </span>
    <span style="color:#fff">B</span>
    <span style="color:#fff">E</span>
    <span style="color:#fff">C</span>
    <span style="color:#fff">O</span>
    <span style="color:#fff">D</span>
</a>

    <div class="nav">
        <span class="welcome">Welcome, <%= user %></span>
          <a href="user.jsp" 
   class="user-trigger" 
   id="welcomeUser">
   👨🏻‍🍳
</a>
         <a href="http://localhost/pizzaphp/offers.php" class="gift-trigger">
    🎁
</a>
<a href="myorders.jsp" class="search-btn">
    🧾 
</a>

  <div style="text-align:center; margin:40px 0;">
    <a href="http://localhost/pizzaphp/search.php" class="search-btn">
        🔍 Search & Filter
    </a>
</div>
        
    <a href="cart.jsp"><i class="fa-solid fa-cart-shopping" style="color:#ffbe33;font-size:22px;"></i></a>

    
        <button class="btn-logout" onclick="logout()">LOGOUT</button>
    </div>
</header>
<%@ page import="java.sql.*" %>

<%
Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/pizzastore",
        "root",
        "sindhuindu"
    );
%>

<h2 class="section-title">Pizza Menu</h2>
<div class="grid">
<%
ps=con.prepareStatement(
    "SELECT * FROM pizzas1 "
);
rs=ps.executeQuery();

while(rs.next()){
%>

    <!-- CARD START -->
    <div class="card">
    <img src="<%=request.getContextPath()%>/images/<%=rs.getString("image")%>">

    <h3 style="margin-top:15px">
        <%=rs.getString("name")%>
    </h3>

    <p style="color:#aaa;font-size:0.9rem;margin:10px">
        <%=rs.getString("description")%>
    </p>

    <p style="color:var(--primary);font-weight:bold;">
        ₹ <%=rs.getInt("price")%>
    </p>

        <form action="/online%20pizza%20store/addToCart" method="post">
        <input type="hidden" name="name" 
               value="<%=rs.getString("name")%>">

        <input type="hidden" name="price" 
               value="<%=rs.getInt("price")%>">

        <button class="btn-add" type="submit">
            Add to Cart
        </button>
    </form>

    </div>
    <!-- CARD END -->

<%
    }

}catch(Exception e){
    out.println("Error: "+e.getMessage());
}
finally{
    if(rs!=null) rs.close();
    if(ps!=null) ps.close();
    if(con!=null) con.close();
}
%>

</div>
<!-- CHAT BUTTON -->
<div id="chatButton" onclick="toggleChat()">💬</div>

<!-- CHAT WINDOW -->
<div id="chatContainer">
    <div id="chatHeader">
        PizzaBot 🍕
        <span onclick="toggleChat()" style="float:right;cursor:pointer;">✖</span>
    </div>

    <div id="chatMessages"></div>

    <div id="chatInputArea">
        <input type="text" id="userInput" placeholder="Type a message...">
        <button onclick="sendMessage()">Send</button>
    </div>
</div>



<script>
/* LOGOUT */
function logout(){
    document.cookie="username=;max-age=0;path=/";
    window.location.href="index.html";
}
</script>
<script>
function toggleChat(){
    let chat = document.getElementById("chatContainer");
    chat.style.display = chat.style.display === "flex" ? "none" : "flex";

    if(chat.style.display === "flex"){
        addBotMessage("Hi <%= user %> 👋 I’m PizzaBot. Ask me anything about your account or orders!");
    }
}

function sendMessage(){
    let input = document.getElementById("userInput");
    let message = input.value.trim();
    if(message === "") return;

    addUserMessage(message);

    setTimeout(function(){
        let reply = getBotReply(message);
        addBotMessage(reply);
    },800);

    input.value="";
}

function addUserMessage(message){
    let chatBox=document.getElementById("chatMessages");
    chatBox.innerHTML += "<div class='user'><span>"+message+"</span></div>";
    chatBox.scrollTop=chatBox.scrollHeight;
}

function addBotMessage(message){
    let chatBox=document.getElementById("chatMessages");
    chatBox.innerHTML += "<div class='bot'>"+message+"</div>";
    chatBox.scrollTop=chatBox.scrollHeight;
}

function getBotReply(message){
    message=message.toLowerCase();

    if(message.includes("hi") || message.includes("hello")){
        return "Hello <%= user %> 🍕 How can I help you today?";
    }
    else if(message.includes("who am i") || message.includes("my name")){
        return "You are logged in as <b><%= user %></b> 👨🏻‍🍳";
    }
    else if(message.includes("profile") || message.includes("user")){
        return "Click the 👨🏻‍🍳 icon at top to view your profile.";
    }
    else if(message.includes("my order") || message.includes("orders")){
        return "Click the 🧾 My Orders button in header to check your order history.";
    }
    else if(message.includes("cart")){
        return "Click 🛒 icon to view items in your cart.";
    }
    else if(message.includes("offer")){
        return "Click 🎁 icon to view latest exciting offers!";
    }
    else if(message.includes("logout")){
        return "Click the LOGOUT button at top right to safely logout.";
    }
    else if(message.includes("delivery")){
        return "Delivery takes around 30-40 minutes 🚚";
    }
    else if(message.includes("feedback")){
        return "In main page before login to our becod you will find the Feedback form";
    }
    else{
        return "I can help you with profile, orders, cart, offers or logout 😊";
    }
}
</script>

</body>
</html>