<?php
session_start();
include "db.php";

// Protect page
if(!isset($_SESSION['admin'])){
    header("Location: admin_login.php");
    exit();
}

// Get total users
$user_count = $conn->query("SELECT COUNT(*) AS total FROM users");
$user_total = $user_count->fetch_assoc()['total'];

// Get total pizzas
$pizza_count = $conn->query("SELECT COUNT(*) AS total FROM pizzas1");
$pizza_total = $pizza_count->fetch_assoc()['total'];

// Get total orders
$order_count = $conn->query("SELECT COUNT(*) AS total FROM orders");
$order_total = $order_count->fetch_assoc()['total'];
// Get total feedback
$feedback_count = $conn->query("SELECT COUNT(*) AS total FROM feedback_public");
$feedback_total = $feedback_count->fetch_assoc()['total'];
?>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: 'Segoe UI', sans-serif;
        }

        body{
            height:100vh;
            background: linear-gradient(135deg, #1e1e2f, #2c2c54);
            color:white;
            display:flex;
            justify-content:center;
            align-items:center;
        }

        .container{
            width:90%;
            max-width:900px;
            background:#2f2f4f;
            padding:40px;
            border-radius:20px;
            box-shadow:0 0 30px rgba(0,0,0,0.5);
            animation: fadeIn 1s ease-in-out;
        }

        h1{
            text-align:center;
            margin-bottom:20px;
            animation: slideDown 0.8s ease-in-out;
        }

        .cards{
            display:grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap:20px;
            margin:30px 0;
        }

        .card{
            background:#40407a;
            padding:20px;
            border-radius:15px;
            text-align:center;
            transition:0.3s ease;
            cursor:pointer;
        }

        .card:hover{
            transform: translateY(-8px) scale(1.05);
            background:#706fd3;
            box-shadow:0 10px 20px rgba(0,0,0,0.4);
        }

        .card h2{
            font-size:2rem;
            margin-bottom:10px;
        }

        .links{
            margin-top:20px;
            display:grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap:15px;
        }

        .links a{
            text-decoration:none;
            padding:12px;
            background:#ff4757;
            text-align:center;
            border-radius:10px;
            color:white;
            font-weight:bold;
            transition:0.3s;
        }

        .links a:hover{
            background:#ff6b81;
            transform:scale(1.05);
        }

        .logout{
            background:#2ed573 !important;
        }

        .logout:hover{
            background:#7bed9f !important;
        }

        @keyframes fadeIn{
            from{opacity:0;}
            to{opacity:1;}
        }

        @keyframes slideDown{
            from{transform:translateY(-30px); opacity:0;}
            to{transform:translateY(0); opacity:1;}
        }

    </style>
</head>
<body>

<div class="container">

    <h1>Welcome Admin 👨‍💼</h1>

    <div class="cards">
        <div class="card">
            <h2><?php echo $user_total; ?></h2>
            <p>Total Users</p>
        </div>

        <div class="card">
            <h2><?php echo $pizza_total; ?></h2>
            <p>Total Pizzas</p>
        </div>

        <div class="card">
            <h2><?php echo $order_total; ?></h2>
            <p>Total Orders</p>
        </div>
        
    </div>

    <div class="links">
        <a href="add_pizza.php">Add New Pizza</a>
        <a href="manage_pizzas.php">Manage Pizzas</a>
        <a href="view_users.php">View Users</a>
        <a href="view_orders.php">View Orders</a>
        <a href="logout.php" class="logout">Logout</a>
        <a href="view_feedback.php">View Feedback</a>
    </div>

</div>

</body>
</html>