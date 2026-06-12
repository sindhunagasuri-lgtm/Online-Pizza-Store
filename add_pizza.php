<?php
session_start();
include "db.php";

// Protect page
if(!isset($_SESSION['admin'])){
    header("Location: admin_login.php");
    exit();
}

$message = "";

if(isset($_POST['add'])){

    $name = $_POST['name'];
    $category = $_POST['category'];
    $description = $_POST['description'];
    $price = $_POST['price'];

    // Image Upload
    if(!empty($_FILES['image']['name'])){

        $image = time() . "_" . $_FILES['image']['name'];
        $target = "images/" . basename($image);
        $imageType = strtolower(pathinfo($target, PATHINFO_EXTENSION));

        // Allow only image files
        $allowed = ["jpg","jpeg","png","webp"];

        if(in_array($imageType, $allowed)){

            move_uploaded_file($_FILES['image']['tmp_name'], $target);

            // Insert safely
            $stmt = $conn->prepare("INSERT INTO pizzas1 (name, category, description, price, image)
                                    VALUES (?,?,?,?,?)");

            $stmt->bind_param("sssis", $name, $category, $description, $price, $image);
            $stmt->execute();

            $message = "Pizza Added Successfully!";
        }
        else{
            $message = "Only JPG, JPEG, PNG, WEBP allowed!";
        }
    }
    else{
        $message = "Please upload an image!";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Add Pizza</title>

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Segoe UI', sans-serif;
        }

        body{
            height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            background: linear-gradient(135deg,#1e1e2f,#2c2c54);
        }

        .container{
            background:#2f2f4f;
            padding:35px;
            width:400px;
            border-radius:15px;
            box-shadow:0 0 25px rgba(0,0,0,0.6);
            color:white;
            animation: fadeIn 0.8s ease-in-out;
        }

        h2{
            text-align:center;
            margin-bottom:20px;
        }

        input, select, textarea{
            width:100%;
            padding:10px;
            margin:8px 0;
            border:none;
            border-radius:8px;
        }

        textarea{
            resize:none;
            height:80px;
        }

        button{
            width:100%;
            padding:10px;
            margin-top:15px;
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

        .message{
            text-align:center;
            margin-bottom:10px;
            padding:8px;
            border-radius:6px;
            background:#2ed573;
            color:black;
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

<h2>Add New Item 🍕</h2>

<?php if($message != ""){ ?>
    <div class="message"><?php echo $message; ?></div>
<?php } ?>

<form method="post" enctype="multipart/form-data">

    <input type="text" name="name" placeholder="Pizza Name" required>

    <select name="category" required>
        <option value="Veg">Veg</option>
        <option value="Non-Veg">Non-Veg</option>
        <option value="Combo">Combo</option>
        <option value="Dessert">Dessert</option>
        <option value="Beverage">Beverage</option>
        <option value="Offers">Offers</option>
    </select>

    <textarea name="description" placeholder="Description" required></textarea>

    <input type="number" name="price" placeholder="Price" required>

    <input type="file" name="image" required>

    <button type="submit" name="add">Add Item</button>

</form>

<a href="admin_dashboard.php" class="back">⬅ Back to Dashboard</a>

</div>

</body>
</html>