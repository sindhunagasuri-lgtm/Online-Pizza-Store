<?php
include "db.php";
$result = $conn->query("SELECT * FROM pizzas1");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Pizza Menu</title>

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Segoe UI', sans-serif;
        }

        body{
            background: linear-gradient(135deg,#1e1e2f,#2c2c54);
            color:white;
            padding:40px;
        }

        h1{
            text-align:center;
            margin-bottom:40px;
        }

        .grid{
            display:grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap:25px;
        }

        .card{
            background:#2f2f4f;
            border-radius:15px;
            overflow:hidden;
            box-shadow:0 10px 20px rgba(0,0,0,0.4);
            transition:0.3s ease;
        }

        .card:hover{
            transform:translateY(-10px);
            box-shadow:0 15px 25px rgba(0,0,0,0.6);
        }

        .card img{
            width:100%;
            height:180px;
            object-fit:cover;
        }

        .card-body{
            padding:15px;
        }

        .category{
            display:inline-block;
            padding:4px 10px;
            font-size:12px;
            border-radius:20px;
            background:#ff4757;
            margin-bottom:8px;
        }

        .price{
            color:#2ed573;
            font-weight:bold;
            margin-top:8px;
            font-size:18px;
        }

        p{
            font-size:14px;
            color:#ccc;
        }
    </style>
</head>
<body>

<h1>Our Delicious Menu 🍕</h1>

<div class="grid">

<?php while($row = $result->fetch_assoc()){ ?>

    <div class="card">
        <img src="images/<?php echo $row['image']; ?>">

        <div class="card-body">
            <span class="category"><?php echo $row['category']; ?></span>
            <h3><?php echo $row['name']; ?></h3>
            <p><?php echo $row['description']; ?></p>
            <div class="price">₹ <?php echo $row['price']; ?></div>
        </div>
    </div>

<?php } ?>

</div>

</body>
</html>