<?php
session_start();
include "db.php";

// Protect page (only admin can access)
if(!isset($_SESSION['admin'])){
    header("Location: admin_login.php");
    exit();
}

$result = $conn->query("SELECT * FROM users");
?>

<!DOCTYPE html>
<html>
<head>
    <title>View Users</title>

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: 'Segoe UI', sans-serif;
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
            transform:scale(1.01);
            transition:0.3s;
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

<h2>All Registered Users 👥</h2>

<table>
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Phone</th>
    <th>Address</th>
</tr>

<?php while($row = $result->fetch_assoc()) { ?>

<tr>
    <td><?php echo $row['id']; ?></td>
    <td><?php echo $row['name']; ?></td>
    <td><?php echo $row['email']; ?></td>
    <td><?php echo $row['phone']; ?></td>
    <td><?php echo $row['address']; ?></td>
</tr>

<?php } ?>

</table>

<center>
    <a href="admin_dashboard.php" class="btn">⬅ Back to Dashboard</a>
</center>

</body>
</html>