<?php
$conn = new mysqli("localhost", "root", "sindhuindu", "pizzastore");
if ($conn->connect_error) {
    die("Connection Failed: " . $conn->connect_error);
}
?>