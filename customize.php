<?php
// Pizza base prices
$pizzaSizes = [
    "Small" => 100,
    "Medium" => 150,
    "Large" => 200
];

// Toppings with price
$toppings = [
    "Cheese" => 30,
    "Mushroom" => 20,
    "Onion" => 15,
    "Capsicum" => 15,
    "Paneer" => 40,
    "Tomato" => 10
];

$finalBill = 0;
$selectedSize = "";
$selectedToppings = [];
$message = "";

if(isset($_POST['order'])){
    $selectedSize = $_POST['size'];
    $selectedToppings = isset($_POST['toppings']) ? $_POST['toppings'] : [];

    $finalBill = $pizzaSizes[$selectedSize];
    foreach($selectedToppings as $topping){
        $finalBill += $toppings[$topping];
    }

    $message = "You ordered a <b>$selectedSize</b> pizza with ";
    if(!empty($selectedToppings)){
        $message .= implode(", ", $selectedToppings);
    } else {
        $message .= "no extra toppings";
    }
    $message .= ".<br><b>Total Bill: ₹$finalBill</b>";
}
?>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pizza Customization</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<style>
:root {
    --primary:#ffbe33;
    --secondary:#ff4d4d;
    --dark:#121212;
    --card-bg:#1e1e1e;
}
body{
    font-family:'Poppins',sans-serif;
    background: var(--dark);
    color:#fff;
    margin:0;
    padding:0;
}
h2{
    text-align:center;
    color: var(--primary);
    margin:50px 0 30px;
}
form{
    max-width:600px;
    margin:0 auto 50px;
    background: var(--card-bg);
    padding:30px;
    border-radius:20px;
}
label{
    font-weight:600;
    margin-top:15px;
    display:block;
}
input[type="radio"], input[type="checkbox"]{
    margin-right:10px;
    transform:scale(1.2);
    cursor:pointer;
}
input[type="submit"], input[type="reset"], .btn-add{
    background: var(--primary);
    color:#000;
    border:none;
    padding:12px 25px;
    border-radius:25px;
    cursor:pointer;
    font-weight:bold;
    margin-top:20px;
    margin-right:10px;
    transition:0.3s;
}
input[type="submit"]:hover, input[type="reset"]:hover, .btn-add:hover{
    transform: scale(1.05);
}
.bill-message{
    max-width:600px;
    margin:20px auto;
    background:#222;
    padding:20px;
    border-radius:15px;
    text-align:center;
    font-size:1.1rem;
}
</style>
</head>
<body>

<h2>Customize Your Pizza</h2>

<form method="post" action="">
    <label>Select Size:</label>
    <?php
    foreach($pizzaSizes as $size=>$price){
        $checked = ($selectedSize==$size) ? "checked" : "";
        echo "<input type='radio' name='size' value='$size' $checked> $size (₹$price)<br>";
    }
    ?>

    <label>Select Toppings:</label>
    <?php
    foreach($toppings as $top=>$price){
        $checked = in_array($top,$selectedToppings) ? "checked" : "";
        echo "<input type='checkbox' name='toppings[]' value='$top' $checked> $top (₹$price)<br>";
    }
    ?>

    <input type="submit" name="order" value="Place Order">
    <input type="reset" value="Reset">
</form>

<?php
if($message!=""){
    echo "<div class='bill-message'>$message</div>";
    // Add to Cart button
    echo "<form method='post' action='cart.php' style='text-align:center;margin-top:20px;'>
            <input type='hidden' name='size' value='$selectedSize'>
            <input type='hidden' name='toppings' value='".implode(", ",$selectedToppings)."'>
            <input type='hidden' name='price' value='$finalBill'>
            <button class='btn-add' type='submit'>Add to Cart</button>
          </form>";
}
?>

</body>
</html>