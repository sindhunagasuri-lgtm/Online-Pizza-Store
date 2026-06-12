<?php
session_start();
include "db.php";

if(!isset($_SESSION['admin'])){
    header("Location: admin_login.php");
    exit();
}

$result = $conn->query("SELECT * FROM feedback_public ORDER BY created_at DESC");
?>

<!DOCTYPE html>
<html>
<head>
<title>View Feedback</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{
background:linear-gradient(135deg,#1e1e2f,#2c2c54);
min-height:100vh;
display:flex;
justify-content:center;
align-items:center;
color:white;
}

.container{
width:90%;
max-width:1000px;
background:#2f2f4f;
padding:30px;
border-radius:15px;
box-shadow:0 0 25px rgba(0,0,0,0.5);
animation:fadeIn 0.8s ease-in-out;
}

h1{
text-align:center;
margin-bottom:20px;
}

table{
width:100%;
border-collapse:collapse;
background:#40407a;
border-radius:10px;
overflow:hidden;
}

th,td{
padding:12px;
text-align:center;
}

th{
background:#706fd3;
}

tr:nth-child(even){
background:#3b3b70;
}

tr:hover{
background:#575fcf;
transition:0.3s;
}

.back{
display:inline-block;
margin-top:20px;
padding:10px 20px;
background:#ff4757;
color:white;
text-decoration:none;
border-radius:8px;
font-weight:bold;
transition:0.3s;
}

.back:hover{
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

<div class="container">

<h1>Customer Feedback</h1>

<table>

<tr>
<th>Name</th>
<th>Email</th>
<th>Message</th>
<th>Rating</th>
<th>Date</th>
</tr>

<?php while($row = $result->fetch_assoc()) { ?>

<tr>
<td><?php echo $row['name']; ?></td>
<td><?php echo $row['email']; ?></td>
<td><?php echo $row['message']; ?></td>
<td><?php echo $row['rating']; ?>/5</td>
<td><?php echo $row['created_at']; ?></td>
</tr>

<?php } ?>

</table>

<a href="admin_dashboard.php" class="back">⬅ Back to Dashboard</a>

</div>

</body>
</html>