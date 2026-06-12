<?php
session_start();
include "db.php";

$error = "";

if(isset($_POST['login'])){
    $username = $_POST['username'];
    $password = $_POST['password'];

    $sql = "SELECT * FROM admin WHERE username='$username' AND password='$password'";
    $result = $conn->query($sql);

    if($result->num_rows > 0){
        $_SESSION['admin'] = $username;
        header("Location: admin_dashboard.php");
        exit();
    } else {
        $error = "Invalid Login!";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
<title>Admin Login</title>

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

.login-box{
    background:#2f2f4f;
    padding:40px;
    width:350px;
    border-radius:15px;
    box-shadow:0 0 25px rgba(0,0,0,0.6);
    color:white;
    animation: fadeIn 0.7s ease-in-out;
}

h2{
    text-align:center;
    margin-bottom:25px;
}

input{
    width:100%;
    padding:10px;
    margin:10px 0;
    border:none;
    border-radius:8px;
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

.error{
    background:#ff4757;
    padding:8px;
    border-radius:6px;
    margin-bottom:10px;
    text-align:center;
}

@keyframes fadeIn{
    from{opacity:0;}
    to{opacity:1;}
}
</style>
</head>
<body>

<div class="login-box">

<h2>Admin Login 👨‍💼</h2>

<?php if($error != ""){ ?>
    <div class="error"><?php echo $error; ?></div>
<?php } ?>

<form method="post">

    <input type="text" name="username" placeholder="Enter Username" required>

    <input type="password" name="password" placeholder="Enter Password" required>

    <button type="submit" name="login">Login</button>
    <button type="button" onclick="goBack()" style="background:#57606f;">
    ⬅ Back to User Login
</button>

</form>

</div>
<script>
function goBack(){
    window.location.href = "http://localhost:8080/online%20pizza%20store/login.html";
}
</script>

</body>
</html>