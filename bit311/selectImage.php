<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "courts";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

$productid = $_POST["productid"];

// prepare and bind
$sql = "select imageName from product where Id ='$productid'";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Output data of the first row (assuming there's only one row)
    $row = $result->fetch_assoc();
    echo $row['imageName'];
} else {
    echo "0 results";
}
$conn->close();
?>