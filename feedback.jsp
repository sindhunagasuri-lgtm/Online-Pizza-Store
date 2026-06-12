<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("UTF-8");
String msg = "";

if(request.getMethod().equalsIgnoreCase("POST")) {

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");
    String ratingStr = request.getParameter("rating");

    try {
        int rating = Integer.parseInt(ratingStr);

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/pizzastore",
            "root",
            "sindhuindu"
        );

        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO feedback_public(name,email,message,rating) VALUES(?,?,?,?)"
        );

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, message);
        ps.setInt(4, rating);

        ps.executeUpdate();
        msg = "Feedback submitted successfully!";
        conn.close();

    } catch(Exception e) {
        msg = "Error: " + e.getMessage();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Feedback</title>

<style>
body{
    background: linear-gradient(135deg,#121212,#1e1e1e);
    font-family: 'Poppins', sans-serif;
    color:white;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
    margin:0;
}

.container{
    background:#222;
    width:420px;
    padding:40px;
    border-radius:20px;
    box-shadow:0 0 30px rgba(255,190,51,0.3);
    animation: fadeIn 1s ease;
}

@keyframes fadeIn{
    from{opacity:0; transform:translateY(20px);}
    to{opacity:1; transform:translateY(0);}
}

h2{
    text-align:center;
    margin-bottom:25px;
    color:#ffbe33;
}

input, textarea{
    width:100%;
    padding:12px;
    margin-bottom:15px;
    border-radius:8px;
    border:none;
    outline:none;
}

textarea{
    resize:none;
}

button{
    width:100%;
    padding:12px;
    background:#ffbe33;
    border:none;
    border-radius:8px;
    font-weight:bold;
    cursor:pointer;
    transition:0.3s;
}

button:hover{
    background:#fff;
    color:#000;
    transform:scale(1.05);
}

/* ⭐ Star Rating */
.stars{
    display:flex;
    justify-content:center;
    margin-bottom:20px;
}

.stars input{
    display:none;
}

.stars label{
    font-size:28px;
    color:#444;
    cursor:pointer;
    transition:0.3s;
}

.stars input:checked ~ label,
.stars label:hover,
.stars label:hover ~ label{
    color:#ffbe33;
}

.msg{
    margin-top:15px;
    text-align:center;
    font-weight:bold;
    color:lightgreen;
}
.back-btn{
    display:inline-block;
    padding:10px 20px;
    background:#444;
    color:white;
    text-decoration:none;
    border-radius:8px;
    transition:0.3s;
}

.back-btn:hover{
    background:#ffbe33;
    color:black;
    transform:scale(1.05);
}
</style>
</head>

<body>

<div class="container">
    <h2>Customer Feedback</h2>

    <form method="post">

        <input type="text" name="name" placeholder="Your Name" required>
        <input type="email" name="email" placeholder="Your Email" required>
        <textarea name="message" rows="3" placeholder="Your Message" required></textarea>

        <!-- ⭐ Interactive Star Rating -->
        <div class="stars">
            <input type="radio" name="rating" value="5" id="star5" required>
            <label for="star5">★</label>

            <input type="radio" name="rating" value="4" id="star4">
            <label for="star4">★</label>

            <input type="radio" name="rating" value="3" id="star3">
            <label for="star3">★</label>

            <input type="radio" name="rating" value="2" id="star2">
            <label for="star2">★</label>

            <input type="radio" name="rating" value="1" id="star1">
            <label for="star1">★</label>
        </div>

        <button type="submit">Submit Feedback</button>
       <div style="text-align:center; margin-top:15px;">
    <a href="index.html" class="back-btn">⬅ Back to Home</a>
</div>

    </form>

    <div class="msg">
        <%= msg %>
    </div>
    
</div>

</body>
</html>