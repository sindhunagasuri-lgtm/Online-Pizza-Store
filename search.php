<?php
// Load pizza data from JSON if exists
$jsonFile = 'pizzas.json';
if(file_exists($jsonFile)){
    $pizzas = json_decode(file_get_contents($jsonFile), true);
} else {
$pizzas = [

    [
        "name" => "The Truffle Shuffle",
        "category" => "Veg",
        "description" => "Black truffle oil, wild mushrooms, and fresh mozzarella.",
        "price" => 240,
        "image" => "images/shuffle.jpg"
    ],

    [
        "name" => "Pepperoni Max",
        "category" => "Non-Veg",
        "description" => "Double layers of spicy pepperoni with an extra blend of aged mozzarella and parmesan.",
        "price" => 200,
        "image" => "images/pepperoni max.jpg"
    ],

    [
        "name" => "Hot Honey Pepperoni",
        "category" => "Non-Veg",
        "description" => "Spicy pepperoni drizzled with our signature hot chili honey.",
        "price" => 210,
        "image" => "images/hot honey.jpg"
    ],

    [
        "name" => "Pepperoni Feast",
        "category" => "Veg",
        "description" => "A celebration of meat! Loaded with pepperoni, Italian herbs, and a smoky tomato base.",
        "price" => 150,
        "image" => "images/feast.jpg"
    ],

    [
        "name" => "Veggie Supreme",
        "category" => "Veg",
        "description" => "Fresh bell peppers, red onions, mushrooms, and olives. A garden-fresh delight in every bite.",
        "price" => 150,
        "image" => "images/photo-1593560708920-61dd98c46a4e.jpg"
    ],

    [
        "name" => "Chicken Tandoori",
        "category" => "Veg",
        "description" => "Fusion at its best. Spicy Tandoori chicken chunks with green chillies and coriander tops.",
        "price" => 250,
        "image" => "images/images.jpg"
    ],

    [
        "name" => "Corn Cheese Pizza",
        "category" => "Veg",
        "description" => "Sweet golden corn topped with extra gooey mozzarella cheese on a crispy crust.",
        "price" => 190,
        "image" => "images/images (1).jpg"
    ],

    [
        "name" => "Paneer Cheese Corn",
        "category" => "Veg",
        "description" => "Fresh cubes of marinated paneer paired with crunchy corn and a blend of melted cheeses.",
        "price" => 250,
        "image" => "images/download.jpg"
    ],

    [
        "name" => "Hawaiian Pizza",
        "category" => "Veg",
        "description" => "A tropical classic featuring juicy pineapple chunks and savory toppings for that perfect sweet-salty balance.",
        "price" => 300,
        "image" => "images/hawallian.jpg"
    ],

    [
        "name" => "Spicy Mexicanooo",
        "category" => "Non-Veg",
        "description" => "Turn up the heat with jalapeños, spicy beef/beans, and crunchy onions with a tangy twist.",
        "price" => 210,
        "image" => "images/mexicana.jpg"
    ],

    [
        "name" => "Italian Margherita",
        "category" => "Veg",
        "description" => "The classic Naples style. Fresh basil leaves, San Marzano tomato sauce, and buffalo mozzarella.",
        "price" => 250,
        "image" => "images/margherita.jpg"
    ],

    [
        "name" => "Rainbow Vegggi",
        "category" => "Veg",
        "description" => "A pizza which adds color to your life and feels like out of the world.",
        "price" => 350,
        "image" => "images/rainbow.jpg"
    ],

    [
        "name" => "Garlic Bread",
        "category" => "Veg",
        "description" => "A bread which has every bite filled with pure garlic taste and rich ghee flavor.",
        "price" => 100,
        "image" => "images/garllic bread.jpg"
    ],

    [
        "name" => "Triple Tango Pizza",
        "category" => "Veg",
        "description" => "A cheese burst into your mouth with tasty tomato flavor.",
        "price" => 150,
        "image" => "images/triple tango pizza.jpg"
    ],

    [
        "name" => "Family Party Box",
        "category" => "Combo",
        "description" => "The ultimate weekend feast! Two large pizzas of your choice, garlic bread, and a 1.5L Coke.",
        "price" => 450,
        "image" => "images/shuffle.jpg"
    ],

    [
        "name" => "Date Night Deal",
        "category" => "Combo",
        "description" => "Perfect for two. One medium specialty pizza, a side of garlic bread, and two soft drinks.",
        "price" => 290,
        "image" => "images/photo-1594007654729-407eedc4be65.jpg"
    ],

    [
        "name" => "Brow-wow-nie",
        "category" => "Desserts",
        "description" => "",
        "price" => 80,
        "image" => "images/brownie.jpg"
    ],

    [
        "name" => "Choco Volcano",
        "category" => "Desserts",
        "description" => "",
        "price" => 110,
        "image" => "images/lava.jpg"
    ],

    [
        "name" => "Choco Mud Pie",
        "category" => "Desserts",
        "description" => "",
        "price" => 100,
        "image" => "images/mud.jpg"
    ],

    [
        "name" => "Mousse Choco Cake",
        "category" => "Desserts",
        "description" => "",
        "price" => 120,
        "image" => "images/mousse.jpg"
    ],

    [
        "name" => "Brownie with Icecream",
        "category" => "Desserts",
        "description" => "",
        "price" => 180,
        "image" => "images/icecream.jpg"
    ],

    [
        "name" => "Caramel Cheese Cake",
        "category" => "Desserts",
        "description" => "",
        "price" => 160,
        "image" => "images/caramel.jpg"
    ],

    [
        "name" => "Pepsi (475ml)",
        "category" => "Beverages",
        "description" => "",
        "price" => 70,
        "image" => "images/pepsi.jpg"
    ],

    [
        "name" => "Coke",
        "category" => "Beverages",
        "description" => "",
        "price" => 60,
        "image" => "images/coke.jpg"
    ],

    [
        "name" => "Thums Up",
        "category" => "Beverages",
        "description" => "",
        "price" => 60,
        "image" => "images/thums.jpg"
    ],

    [
        "name" => "Diet Coke",
        "category" => "Beverages",
        "description" => "",
        "price" => 100,
        "image" => "images/dite.jpg"
    ],

    [
        "name" => "Masala Lime",
        "category" => "Beverages",
        "description" => "",
        "price" => 50,
        "image" => "images/masala.jpg"
    ]

];  
}
$searchResults = [];

if(isset($_GET['query']) && trim($_GET['query']) != ''){
    $query = strtolower(trim($_GET['query']));
    foreach($pizzas as $pizza){
        if(
            strpos(strtolower($pizza['name']), $query) !== false || 
            strpos(strtolower($pizza['description']), $query) !== false
        ){
            $searchResults[] = $pizza;
        }
    }
}?>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Pizza Becod | Search</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
:root {
    --primary:#ffbe33;
    --secondary:#ff4d4d;
    --dark:#121212;
    --card-bg:#1e1e1e;
}

*{margin:0;padding:0;box-sizing:border-box}
body{
    font-family:Poppins,sans-serif;
    background:var(--dark);
    color:#fff;
}

/* HEADER */
header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:10px 8%;
    background:#000;
    position:sticky;
    top:0;
}
.logo{
    font-size:28px;
    font-weight:bold;
    color:var(--secondary);
}
.search-form{
    text-align:center;
    margin:30px 0;
}
.search-form input[type="text"]{
    padding:10px;
    width:300px;
    border-radius:25px;
    border:none;
    outline:none;
}
.search-form button{
    padding:10px 20px;
    border-radius:25px;
    border:none;
    background:var(--primary);
    color:#000;
    font-weight:bold;
    cursor:pointer;
}
.search-form button:hover{
    background:var(--secondary);
    color:#fff;
}

/* GRID & CARDS */
.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:25px;
    padding:0 8%;
}
.card{
    background:var(--card-bg);
    border-radius:20px;
    overflow:hidden;
    text-align:center;
    padding-bottom:20px;
    transition:0.3s;
}
.card:hover{
    transform:scale(1.05);
}
.card img{
    width:100%;
    height:200px;
    object-fit:cover;
    border-bottom:1px solid #333;
}
.card h3{
    margin:15px 0 10px 0;
    color:var(--primary);
}
.card p{
    color:#aaa;
    font-size:0.9rem;
    margin:0 10px 10px 10px;
}
.card .price{
    color:var(--primary);
    font-weight:bold;
    margin-bottom:10px;
}

/* BUTTONS */
.btn-add{
    background:var(--primary);
    border:none;
    padding:10px 25px;
    border-radius:25px;
    font-weight:bold;
    cursor:pointer;
    transition:0.3s;
}
.btn-add:hover{
    background:var(--secondary);
    color:#fff;
    transform:scale(1.05);
}
.back-btn{
    display:block;
    text-align:center;
    margin:30px auto;
    text-decoration:none;
    color:var(--primary);
    font-weight:bold;
    transition:0.3s;
}
.back-btn:hover{
    color:var(--secondary);
}
</style>
</head>
<body>

<header>
    <div class="logo">🍕 Pizza Becod</div>
</header>

<div class="search-form">
    <form method="get" action="">
        <input type="text" name="query" placeholder="Search pizza name or description..." value="<?php echo isset($_GET['query']) ? htmlspecialchars($_GET['query']) : ''; ?>">
        <button type="submit">Search</button>
    </form>
</div>

<h2 class="section-title" style="text-align:center; color:var(--primary); margin-bottom:20px;">Search Results</h2>
<div class="grid">
<?php if(!empty($searchResults)): ?>
    <?php foreach($searchResults as $pizza): ?>
        <div class="card">
            <img src="<?php echo isset($pizza['image']) ? $pizza['image'] : 'images/default.png'; ?>" alt="<?php echo $pizza['name']; ?>">
            <h3><?php echo $pizza['name']; ?></h3>
            <p><?php echo $pizza['description']; ?></p>
            <p class="price">₹ <?php echo $pizza['price']; ?></p>
           <form action="http://localhost:8080/online%20pizza%20store/addToCart" method="post">
                <input type="hidden" name="name" value="<?php echo $pizza['name']; ?>">
                <input type="hidden" name="price" value="<?php echo $pizza['price']; ?>">
                <button type="submit" class="btn-add">Add to Cart 🛒</button>
            </form>
        </div>
    <?php endforeach; ?>
<?php else: ?>
    <p style="grid-column:1/-1; text-align:center; font-weight:bold;">No pizzas found for "<?php echo isset($_GET['query']) ? htmlspecialchars($_GET['query']) : ''; ?>"</p>
<?php endif; ?>
</div>

<a href="http://localhost:8080/online%20pizza%20store/menu.jsp" class="back-btn">⬅ Back to Menu</a>

</body>
</html>