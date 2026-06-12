<?php
session_start();
include "db.php";

// Protect page
if(!isset($_SESSION['admin'])){
    header("Location: admin_login.php");
    exit();
}

if(!isset($_GET['id'])){
    header("Location: manage_pizzas.php");
    exit();
}

$id = intval($_GET['id']);

// Fetch pizza safely
$stmt = $conn->prepare("SELECT * FROM pizzas1 WHERE id=?");
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();
$row = $result->fetch_assoc();

if(!$row){
    echo "Pizza not found!";
    exit();
}

if(isset($_POST['update'])){

    $name = $_POST['name'];
    $category = $_POST['category'];
    $description = $_POST['description'];
    $price = $_POST['price'];

    // If new image uploaded
    if(!empty($_FILES['image']['name'])){

        $image = $_FILES['image']['name'];
        $target = "images/" . basename($image);

        move_uploaded_file($_FILES['image']['tmp_name'], $target);

        // Delete old image if exists
        $oldImage = "images/".$row['image'];
        if(file_exists($oldImage)){
            unlink($oldImage);
        }

        $stmt2 = $conn->prepare("UPDATE pizzas1 SET 
            name=?, category=?, description=?, price=?, image=?
            WHERE id=?");

        $stmt2->bind_param("sssisi", 
            $name, $category, $description, $price, $image, $id);
    } 
    else {

        $stmt2 = $conn->prepare("UPDATE pizzas1 SET 
            name=?, category=?, description=?, price=?
            WHERE id=?");

        $stmt2->bind_param("sssii", 
            $name, $category, $description, $price, $id);
    }

    $stmt2->execute();

    echo "<script>
            alert('Pizza Updated Successfully!');
            window.location='manage_pizzas.php';
          </script>";
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Pizza</title>

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
            display:flex;
            justify-content:center;
            align-items:center;
            height:100vh;
        }

        .container{
            background:#2f2f4f;
            padding:30px;
            border-radius:15px;
            width:400px;
            box-shadow:0 0 20px rgba(0,0,0,0.5);
            animation: fadeIn 0.7s ease-in-out;
        }

        h2{
            text-align:center;
            margin-bottom:20px;
        }

        input, select, textarea{
            width:100%;
            padding:8px;
            margin:8px 0;
            border:none;
            border-radius:6px;
        }

        textarea{
            resize:none;
            height:80px;
        }

        img{
            display:block;
            margin:10px auto;
            border-radius:10px;
        }

        button{
            width:100%;
            padding:10px;
            margin-top:10px;
            border:none;
            border-radius:8px;
            background:#ff4757;
            color:white;
            font-weight:bold;
            cursor:pointer;
            transition:0.3s;
        }

        button:hover{
            background:#ff6b81;
            transform:scale(1.05);
        }

        .back{
            display:block;
            text-align:center;
            margin-top:15px;
            text-decoration:none;
            color:#7bed9f;
        }

        @keyframes fadeIn{
            from{opacity:0;}
            to{opacity:1;}
        }
    </style>
</head>
<body>

<div class="container">

<h2>Edit Pizza 🍕</h2>

<form method="post" enctype="multipart/form-data">

Name:
<input type="text" name="name" value="<?php echo $row['name']; ?>" required>

Category:
<select name="category" required>
    <option value="Veg" <?php if($row['category']=="Veg") echo "selected"; ?>>Veg</option>
    <option value="Non-Veg" <?php if($row['category']=="Non-Veg") echo "selected"; ?>>Non-Veg</option>
    <option value="Combo" <?php if($row['category']=="Combo") echo "selected"; ?>>Combo</option>
    <option value="Dessert" <?php if($row['category']=="Dessert") echo "selected"; ?>>Dessert</option>
    <option value="Beverage" <?php if($row['category']=="Beverage") echo "selected"; ?>>Beverage</option>
    <option value="Offers" <?php if($row['category']=="Offers") echo "selected"; ?>>Offers</option>
</select>

Description:
<textarea name="description" required><?php echo $row['description']; ?></textarea>

Price:
<input type="number" name="price" value="<?php echo $row['price']; ?>" required>

Current Image:
<img src="images/<?php echo $row['image']; ?>" width="100">

Change Image:
<input type="file" name="image">

<button type="submit" name="update">Update Pizza</button>

</form>

<a href="manage_pizzas.php" class="back">⬅ Back</a>

</div>

</body>
</html>