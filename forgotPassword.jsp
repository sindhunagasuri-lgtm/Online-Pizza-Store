<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pizza Becod | Forgot Password</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    body {
        margin: 0;
        font-family: 'Poppins', sans-serif;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
        url('https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=2070&auto=format&fit=crop');
        background-size: cover;
        background-position: center;
    }

    .glass-box {
        width: 400px;
        padding: 40px;
        border-radius: 25px;
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(15px);
        border: 1px solid rgba(255,255,255,0.2);
        text-align: center;
        color: white;
    }

    .glass-box h2 {
        margin-bottom: 25px;
    }

    .input-group {
        position: relative;
        margin-bottom: 20px;
    }

    .input-group i {
        position: absolute;
        left: 15px;
        top: 12px;
        color: #ffbe33;
    }

    input {
        width: 100%;
        padding: 12px 40px;
        border-radius: 30px;
        border: 1px solid rgba(255,255,255,0.3);
        background: rgba(0,0,0,0.4);
        color: white;
        outline: none;
        box-sizing: border-box;
    }

    input::placeholder {
        color: #ccc;
    }

    .btn {
        width: 100%;
        padding: 12px;
        background: #ffbe33;
        border: none;
        border-radius: 30px;
        font-weight: bold;
        cursor: pointer;
        transition: 0.3s;
    }

    .btn:hover {
        transform: scale(1.05);
    }

    .back-link {
        display: block;
        margin-top: 15px;
        font-size: 13px;
        color: #ccc;
        text-decoration: none;
    }

    .back-link:hover {
        color: #ffbe33;
    }

</style>
</head>

<body>

<div class="glass-box">
    <i class="fa-solid fa-key" style="font-size:35px;color:#ffbe33;margin-bottom:15px;"></i>
    <h2>Forgot Password</h2>

    <form method="post">

        <div class="input-group">
            <i class="fa-solid fa-envelope"></i>
            <input type="email" name="email" placeholder="Registered Email" required>
        </div>

        <div class="input-group">
            <i class="fa-solid fa-lock"></i>
            <input type="password" name="newPassword" placeholder="New Password" required minlength="6">
        </div>

        <button class="btn" type="submit">UPDATE PASSWORD</button>
    </form>

    <a href="login.html" class="back-link">  Back to Login</a>
</div>

<%
    String email = request.getParameter("email");
    String newPassword = request.getParameter("newPassword");

    if(email != null && newPassword != null){

        Connection con = null;
        PreparedStatement ps = null;

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/pizzastore",
                "root",
                "sindhuindu"
            );

            ps = con.prepareStatement(
                "UPDATE users SET password=? WHERE email=?"
            );
            ps.setString(1, newPassword);
            ps.setString(2, email);

            int rows = ps.executeUpdate();

            if(rows > 0){
%>
                <script>
                    alert("Password Updated Successfully!");
                    window.location="login.html";
                </script>
<%
            } else {
%>
                <script>alert("Email not found!");</script>
<%
            }

        }catch(Exception e){
            out.println("Error: " + e.getMessage());
        }finally{
            if(ps != null) ps.close();
            if(con != null) con.close();
        }
    }
%>

</body>
</html>