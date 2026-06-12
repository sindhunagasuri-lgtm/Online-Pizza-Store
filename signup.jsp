<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String password = request.getParameter("password");

    String message = "";
    String color = "";
    String redirectPage = "";
    String buttonText = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/pizzastore",
            "root",
            "sindhuindu"
        );

        // Check if email already exists
        PreparedStatement check = con.prepareStatement(
            "SELECT * FROM users WHERE email=?"
        );
        check.setString(1, email);
        ResultSet rs = check.executeQuery();

        if(rs.next()){
            message = "Email already registered!";
            color = "red";
            redirectPage = "account.html";
            buttonText = "Go Back";
        } else {

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users(name,email,phone,address,password) VALUES(?,?,?,?,?)"
            );

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setString(5, password);

            ps.executeUpdate();

            message = "Registration Successful!";
            color = "green";
            redirectPage = "login.html";
            buttonText = "Login Now";
        }

        con.close();

    } catch(Exception e){
        message = "Error: " + e.getMessage();
        color = "red";
        redirectPage = "account.html";
        buttonText = "Go Back";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Registration Result | Pizza Store</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(to right, #000000, #2b0000);
        }

        .result-container {
            width: 420px;
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(255, 0, 0, 0.3);
            text-align: center;
        }

        h2 {
            margin-bottom: 30px;
        }

        .btn-action {
            display: inline-block;
            padding: 12px 25px;
            background-color: #c40000;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-size: 15px;
            transition: 0.3s;
        }

        .btn-action:hover {
            background-color: black;
        }
    </style>
</head>

<body>

    <div class="result-container">

        <h2 style="color:<%=color%>;">
            <%= message %>
        </h2>

        <a href="<%=redirectPage%>" class="btn-action">
            <%= buttonText %>
        </a>

    </div>

</body>
</html>