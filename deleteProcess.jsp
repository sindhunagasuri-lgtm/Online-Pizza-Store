<%@ page import="java.sql.*" %>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    String message = "";
    String color = "";

    Connection con = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/pizzastore",
            "root",
            "sindhuindu"
        );

        // STEP 1: Get user ID
        PreparedStatement getUser = con.prepareStatement(
            "SELECT id FROM users WHERE email=? AND password=?"
        );

        getUser.setString(1, email);
        getUser.setString(2, password);

        ResultSet rs = getUser.executeQuery();

        if(rs.next()){
            int userId = rs.getInt("id");

            // STEP 2: Delete from orders FIRST
            PreparedStatement deleteOrders = con.prepareStatement(
                "DELETE FROM orders WHERE user_id=?"
            );
            deleteOrders.setInt(1, userId);
            deleteOrders.executeUpdate();

            // STEP 3: Delete from users
            PreparedStatement deleteUser = con.prepareStatement(
                "DELETE FROM users WHERE id=?"
            );
            deleteUser.setInt(1, userId);

            int result = deleteUser.executeUpdate();

            if(result > 0){
                message = "Account Deleted Successfully!";
                color = "green";
            } else {
                message = "Deletion Failed!";
                color = "red";
            }

        } else {
            message = "Invalid Email or Password!";
            color = "red";
        }

        con.close();

    } catch(Exception e){
        message = "Error: " + e.getMessage();
        color = "red";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Delete Account Result</title>
    <style>
        body {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial;
            background: linear-gradient(to right, black, darkred);
        }
        .box {
            background: white;
            padding: 40px;
            border-radius: 10px;
            text-align: center;
        }
        a {
            padding: 10px 20px;
            background: red;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>

<body>
<div class="box">
    <h2 style="color:<%=color%>;"><%=message%></h2>
    <a href="index.html">Go to Home Page</a>
</div>
</body>
</html>