<%@ page import="java.util.*, java.text.*" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.Cookie" %>

<%
    /* ================= COOKIE SECTION ================= */

    String cookieUser = null;
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(Cookie c : cookies){
            if("username".equals(c.getName())){
                cookieUser = c.getValue();
                break;
            }
        }
    }

    if(cookieUser == null){
        response.sendRedirect("login.html");
        return;
    }

    /* ================= SESSION SECTION ================= */

    String username = (String) session.getAttribute("welcomeUser");
    if(username == null){
        username = cookieUser;
        session.setAttribute("welcomeUser", username);
    }

    Integer visitCount = (Integer) session.getAttribute("visitCount");
    if(visitCount == null){
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

    if(hour < 12){
        message = "Good Morning";
        slogan = "Start your day with positivity!";
    }
    else if(hour < 17){
        message = "Good Afternoon";
        slogan = "Keep pushing forward!";
    }
    else if(hour < 21){
        message = "Good Evening";
        slogan = "Relax and refresh yourself!";
    }
    else{
        message = "Good Night";
        slogan = "Rest well and recharge!";
    }
%>


<!DOCTYPE html>
<html>
<head>
<title>User Dashboard</title>

<style>
body{
    font-family: Arial;
    background: linear-gradient(135deg,#000,#434343);
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.container{
    width:650px;
    background:#d19512;
    border-radius:15px;
    box-shadow:0 0 20px rgba(0,0,0,0.6);
    overflow:hidden;
    transition:0.4s;
}

.container:hover{
    transform: translateY(-8px);
}

.tabs{
    display:flex;
    background:#000;
}

.tabs button{
    flex:1;
    padding:15px;
    border:none;
    background:none;
    color:white;
    font-weight:bold;
    cursor:pointer;
    transition:0.3s;
}

.tabs button:hover,
.tabs button.active{
    background:#d19512;
    color:black;
}

.tab-content{
    display:none;
    padding:30px;
    animation: fadeIn 0.5s ease-in-out;
}

.tab-content.active{
    display:block;
}

@keyframes fadeIn{
    from{opacity:0; transform:translateY(10px);}
    to{opacity:1; transform:translateY(0);}
}

h2{
    color:#8b0000;
}

.info-box{
    background:white;
    padding:15px;
    border-radius:10px;
    margin-top:10px;
}

.back-btn{
    padding:10px 25px;
    border:none;
    border-radius:30px;
    background: linear-gradient(45deg,#000,#8b0000);
    color:white;
    font-weight:bold;
    cursor:pointer;
    transition:0.3s;
}

.back-btn:hover{
    transform:scale(1.05);
}
</style>

<script>
function openTab(tabName, btn){
    let contents=document.getElementsByClassName("tab-content");
    for(let c of contents){
        c.classList.remove("active");
    }

    let tabs=document.querySelectorAll(".tabs button");
    tabs.forEach(t=>t.classList.remove("active"));

    document.getElementById(tabName).classList.add("active");
    btn.classList.add("active");
}

window.onload=function(){
    document.getElementById("defaultOpen").click();
}
</script>

</head>

<body>

<div class="container">

<div class="tabs">
    <button id="defaultOpen" onclick="openTab('welcome',this)">Welcome</button>
    <button onclick="openTab('visit',this)">Visits</button>
    <button onclick="openTab('login',this)">Login Info</button>
</div>

<div id="welcome" class="tab-content">
    <h2><%= message %>👋</h2>
    <div class="info-box">
        <p><%= slogan %></p>
        <p><i>"Every slice of effort brings success closer!" 🍕</i></p>
    </div>
</div>

<div id="visit" class="tab-content">
    <h2>Visit Information</h2>
    <div class="info-box">
        <p><b>Total Visits:</b> <%= visitCount %></p>
    </div>
</div>

<div id="login" class="tab-content">
    <h2>Login Details</h2>
    <div class="info-box">
        <p><b>Previous Login:</b>
        <%= (lastLogin == null) ? "This is your first login." : lastLogin %></p>

        <p><b>Current Login:</b> <%= currentTime %></p>
        <p><b>Session ID:</b> <%= session.getId() %></p>
        <p><b>User:</b> <%= cookieUser %></p>
    </div>
</div>

<div style="text-align:center; padding:20px;">
    <button class="back-btn" onclick="location.href='menu.jsp'">
        Back to Menu
    </button>
</div>

</div>

</body>
</html>