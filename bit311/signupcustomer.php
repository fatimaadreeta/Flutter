<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "courts";

// Create connection
$con = new mysqli($servername, $username, $password, $dbname);

$username = $_POST["username"];
$password = $_POST["password"];

// prepare and bind
$sql = "INSERT INTO customer (Username, Password) VALUES ('$username','$password')";

echo "New records created successfully";

mysqli_query($con, $sql);
mysqli_close($con);
?>
