<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pizza Becod | Delete Account</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    *{
        margin:0;
        padding:0;
        box-sizing:border-box;
    }

    body{
        font-family: 'Poppins', sans-serif;
        height:100vh;
        display:flex;
        justify-content:center;
        align-items:center;
        background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
        url('https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=2070&auto=format&fit=crop');
        background-size:cover;
        background-position:center;
    }

    .glass-box{
        width:400px;
        padding:40px;
        border-radius:25px;
        background:rgba(255,255,255,0.1);
        backdrop-filter:blur(15px);
        border:1px solid rgba(255,255,255,0.2);
        text-align:center;
        color:white;
        animation:fadeIn 0.8s ease-in-out;
    }

    @keyframes fadeIn{
        from{
            opacity:0;
            transform:translateY(20px);
        }
        to{
            opacity:1;
            transform:translateY(0);
        }
    }

    .glass-box h2{
        margin-bottom:25px;
        color:#ff4d4d;
    }

    .input-group{
        position:relative;
        margin-bottom:20px;
    }

    .input-group i{
        position:absolute;
        left:15px;
        top:12px;
        color:#ff4d4d;
    }

    input{
        width:100%;
        padding:12px 40px;
        border-radius:30px;
        border:1px solid rgba(255,255,255,0.3);
        background:rgba(0,0,0,0.4);
        color:white;
        outline:none;
        box-sizing:border-box;
        transition:0.3s;
    }

    input:focus{
        border-color:#ff4d4d;
        box-shadow:0 0 8px rgba(255,77,77,0.6);
    }

    input::placeholder{
        color:#ccc;
    }

    .btn-delete{
        width:100%;
        padding:12px;
        background:#ff4d4d;
        border:none;
        border-radius:30px;
        font-weight:bold;
        cursor:pointer;
        transition:0.3s;
        color:white;
    }

    .btn-delete:hover{
        background:#000;
        transform:scale(1.05);
    }

    .warning-text{
        font-size:13px;
        color:#ccc;
        margin-bottom:20px;
    }

    .back-link{
        display:block;
        margin-top:18px;
        font-size:13px;
        color:#ccc;
        text-decoration:none;
        transition:0.3s;
    }

    .back-link:hover{
        color:#ffbe33;
    }

</style>
</head>

<body>

<div class="glass-box">

    <i class="fa-solid fa-user-xmark" 
       style="font-size:35px;color:#ff4d4d;margin-bottom:15px;"></i>

    <h2>Delete Account</h2>

    <p class="warning-text">
        This action is permanent and cannot be undone.
    </p>

    <form action="deleteProcess.jsp" method="post">

        <div class="input-group">
            <i class="fa-solid fa-envelope"></i>
            <input type="email" name="email" placeholder="Registered Email" required>
        </div>

        <div class="input-group">
            <i class="fa-solid fa-lock"></i>
            <input type="password" name="password" placeholder="Password" required>
        </div>

        <button type="submit" class="btn-delete">
            CONFIRM DELETE
        </button>

    </form>

    <a href="login.html" class="back-link">← Back to Login</a>

</div>

</body>
</html>