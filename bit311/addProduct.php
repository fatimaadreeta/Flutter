<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "courts";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

$productName = $_POST["productName"];
$Description = $_POST["productDesc"];
$Price = $_POST["price"];

// prepare and bind
$sql = "INSERT INTO product(proName, proDesc, price) VALUES ('$productName', '$Description', '$Price')";

echo "New records created successfully";

mysqli_query($conn, $sql);
mysqli_close($conn);
?>