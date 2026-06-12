<?php
session_start();
include "db.php";

if(!isset($_SESSION['admin'])){
    header("Location: admin_login.php");
    exit();
}

$result = $conn->query("
    SELECT orders.order_id, users.name, users.email, 
           orders.total_amount, orders.status, orders.order_date
    FROM orders
    JOIN users ON orders.user_id = users.id
");
?>

<!DOCTYPE html>
<html>
<head>
    <title>View Orders</title>

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Segoe UI', sans-serif;
        }

        body{
            background: linear-gradient(135deg, #1e1e2f, #2c2c54);
            color:white;
            padding:40px;
            animation: fadeIn 0.8s ease-in-out;
        }

        h2{
            text-align:center;
            margin-bottom:30px;
        }

        table{
            width:100%;
            border-collapse:collapse;
            background:#2f2f4f;
            border-radius:15px;
            overflow:hidden;
            box-shadow:0 0 20px rgba(0,0,0,0.5);
        }

        th{
            background:#40407a;
            padding:15px;
            text-transform:uppercase;
            font-size:14px;
            letter-spacing:1px;
        }

        td{
            padding:12px;
            text-align:center;
        }

        tr:nth-child(even){
            background:#35356b;
        }

        tr:hover{
            background:#706fd3;
            transition:0.3s;
            transform:scale(1.01);
        }

        .status{
            padding:6px 12px;
            border-radius:20px;
            font-size:13px;
            font-weight:bold;
        }

        .pending{
            background:#ffa502;
            color:black;
        }

        .completed{
            background:#2ed573;
            color:black;
        }

        .cancelled{
            background:#ff4757;
            color:white;
        }

        .btn{
            display:inline-block;
            margin-top:25px;
            padding:10px 20px;
            background:#ff4757;
            color:white;
            text-decoration:none;
            border-radius:8px;
            transition:0.3s;
        }

        .btn:hover{
            background:#ff6b81;
            transform:scale(1.05);
        }

        @keyframes fadeIn{
            from{opacity:0;}
            to{opacity:1;}
        }

    </style>
</head>
<body>

<h2>All Orders 📦</h2>

<table>
<tr>
    <th>Order ID</th>
    <th>User Name</th>
    <th>Email</th>
    <th>Total Amount</th>
    <th>Status</th>
    <th>Date</th>
</tr>

<?php while($row = $result->fetch_assoc()) { 

    $statusClass = "";
    if($row['status'] == "Pending"){
        $statusClass = "pending";
    } elseif($row['status'] == "Completed"){
        $statusClass = "completed";
    } elseif($row['status'] == "Cancelled"){
        $statusClass = "cancelled";
    }
?>

<tr>
    <td><?php echo $row['order_id']; ?></td>
    <td><?php echo $row['name']; ?></td>
    <td><?php echo $row['email']; ?></td>
    <td>₹<?php echo $row['total_amount']; ?></td>
    <td>
        <span class="status <?php echo $statusClass; ?>">
            <?php echo $row['status']; ?>
        </span>
    </td>
    <td><?php echo $row['order_date']; ?></td>
</tr>

<?php } ?>

</table>

<center>
    <a href="admin_dashboard.php" class="btn">⬅ Back to Dashboard</a>
</center>

</body>
</html>