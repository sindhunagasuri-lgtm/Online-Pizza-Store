<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    // Time-based offer
    String offer = "";
    java.util.Calendar cal = java.util.Calendar.getInstance();
    int hour = cal.get(java.util.Calendar.HOUR_OF_DAY);

    if(hour >= 6 && hour < 12){
        offer = "Good Morning!  🍳🍕";
    } else if(hour >= 12 && hour < 17){
        offer = "Afternoon Special 🌞🍕";
    } else if(hour >= 17 && hour < 21){
        offer = "Evening Treat 🌇🍕";
    } else {
        offer = "Late Night Cravings 🌙🍕";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Pizza Store Offers</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(120deg, #fbc2eb, #a6c1ee);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .offer-box {
            background: black;
            color: #fff;
            padding: 40px 60px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            text-align: center;
            max-width: 600px;
            animation: pop 1s ease-out;
        }

        .offer-box h2 {
            font-size: 28px;
            margin-bottom: 20px;
        }

        .offer-box p {
            font-size: 20px;
            margin-bottom: 30px;
        }

        .coupon-list {
            margin-top: 20px;
            text-align: left;
        }

        .coupon-item {
            background: #1e1e1e;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .coupon-code {
            font-weight: bold;
            color: #ffbe33;
            font-size: 16px;
        }

        .offer-box a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            background-color: #ffbe33;
            color: #000;
            font-weight: bold;
            padding: 12px 30px;
            border-radius: 25px;
            transition: 0.3s;
        }

        .offer-box a:hover {
            transform: scale(1.1);
            background-color: #ff4d4d;
            color: #fff;
        }

        @keyframes pop {
            0% { transform: scale(0.5); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }
    </style>
</head>
<body>

<div class="offer-box">

    <h2>🔥 Today's Special Offer 🔥</h2>
    <p><%= offer %></p>

    <h3>🎁 Available Coupon Codes</h3>

    <div class="coupon-list">
        <div class="coupon-item">
            <span class="coupon-code">BECOD10</span>
            <span>Get 10% OFF on total bill</span>
        </div>

        <div class="coupon-item">
            <span class="coupon-code">PIZZA20</span>
            <span>Get 20% OFF on total bill</span>
        </div>

        <div class="coupon-item">
            <span class="coupon-code">WELCOME30</span>
            <span>Get 30% OFF on your total bill admin offers you</span>
        </div>
    </div>

    <a href="menu.jsp">Order Now 🍕</a>

</div>

</body>
</html>
