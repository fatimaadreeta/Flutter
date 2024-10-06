<?php
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "courts";
    
    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);

    $productId = $_POST["productId"];
    $productName = $_POST["productName"];
    $Description = $_POST["productDesc"];
    $Price = $_POST["price"];
    $imageName = $_POST["imageName"];

// prepare and bind
$stmt = "update product set proName = '$productName', proDesc = '$Description', price = '$Price', imageName = '$imageName' where Id = '$productId'";

$exe = mysqli_query($conn, $stmt);
$arr = [];
if($exe){
    $arr["success"] = "true";
}
else{
    $arr["success"] = "false";
}
print(json_encode($arr));
?>