<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "courts";

// Create connection
$con = new mysqli($servername, $username, $password, $dbname);

$username = $_POST["username"];
$password = $_POST["password"];
$address = $_POST["address"];
$email = $_POST["email"];
$phonenumber = $_POST["phonenumber"];

$sql = "SELECT * from customer WHERE Username='$username'";
$sql = "UPDATE customer SET Password='$password', Address='$address', Email='$email', PhoneNumber='$phonenumber' WHERE Username='$username'";

mysqli_query($con, $sql);
mysqli_close($con);
?>
