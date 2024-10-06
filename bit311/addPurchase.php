<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "courts";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

$username = $_POST["username"];
$productid = $_POST["productid"];
$quantity = $_POST["quantity"];
$status = $_POST["status"];

// prepare and bind
$sql = "INSERT INTO purchase(Username, ProductId, quantity, status ) VALUES ('$username', '$productid', '$quantity', '$status')";

echo "New records created successfully";

mysqli_query($conn, $sql);
mysqli_close($conn);
?>