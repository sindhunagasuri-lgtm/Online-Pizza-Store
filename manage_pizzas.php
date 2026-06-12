<?php
session_start();
include "db.php";

// Protect page
if(!isset($_SESSION['admin'])){
    header("Location: admin_login.php");
    exit();
}

// DELETE LOGIC
if(isset($_GET['delete'])){
    $id = intval($_GET['delete']); // safer

    // Get image name safely
    $stmt = $conn->prepare("SELECT image FROM pizzas1 WHERE id=?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $resultImg = $stmt->get_result();
    $row = $resultImg->fetch_assoc();

    if($row){
        $imagePath = "images/".$row['image'];

        if(file_exists($imagePath)){
            unlink($imagePath);
        }

        // Delete record
        $stmt2 = $conn->prepare("DELETE FROM pizzas1 WHERE id=?");
        $stmt2->bind_param("i", $id);
        $stmt2->execute();

        echo "<script>alert('Pizza Deleted Successfully!'); window.location='manage_pizzas.php';</script>";
    }
}

// FETCH ALL PIZZAS
$result = $conn->query("SELECT * FROM pizzas1");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Pizzas</title>

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

        img{
            border-radius:10px;
        }

        .btn{
            padding:6px 12px;
            text-decoration:none;
            border-radius:6px;
            font-size:13px;
            transition:0.3s;
        }

        .edit{
            background:#2ed573;
            color:black;
        }

        .edit:hover{
            background:#7bed9f;
            transform:scale(1.1);
        }

        .delete{
            background:#ff4757;
            color:white;
        }

        .delete:hover{
            background:#ff6b81;
            transform:scale(1.1);
        }

        .back{
            display:inline-block;
            margin-top:25px;
            padding:10px 20px;
            background:#ff4757;
            color:white;
            text-decoration:none;
            border-radius:8px;
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

<h2>Manage Pizzas 🍕</h2>

<table>
<tr>
    <th>Name</th>
    <th>Category</th>
    <th>Price (₹)</th>
    <th>Image</th>
    <th>Action</th>
</tr>

<?php while($row = $result->fetch_assoc()) { ?>

<tr>
    <td><?php echo $row['name']; ?></td>
    <td><?php echo $row['category']; ?></td>
    <td><?php echo $row['price']; ?></td>
    <td>
        <img src="images/<?php echo $row['image']; ?>" width="80">
    </td>
    <td>
        <a class="btn edit" href="edit_pizza.php?id=<?php echo $row['id']; ?>">Edit</a>
        <a class="btn delete"
           href="manage_pizzas.php?delete=<?php echo $row['id']; ?>"
           onclick="return confirm('Are you sure you want to delete this pizza?');">
           Delete
        </a>
    </td>
</tr>

<?php } ?>

</table>

<center>
    <a href="admin_dashboard.php" class="back">⬅ Back to Dashboard</a>
</center>

</body>
</html>