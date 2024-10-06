<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "courts";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$productId = $_POST["productId"];

// prepare and bind
$stmt = $conn->prepare("delete from product where Id = ?");
$stmt->bind_param("i",$productId);

$stmt->execute();

//echo "New records created successfully";

$stmt->close();
$conn->close();

echo "delete success";
?>