<?php
// Database connection parameters
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

// Get productId from the GET request
$productId = $_GET['Id'];

// SQL query to select product details based on productId
$sql = "SELECT * FROM product WHERE Id = $productId";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Output data of each row
    $row = $result->fetch_assoc();
    echo json_encode($row);
} else {
    echo json_encode(["error" => "Product not found"]);
}

$conn->close();
?>