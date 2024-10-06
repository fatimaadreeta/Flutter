<?php
// Assuming you have established a database connection
$connection = new mysqli('localhost', 'username', 'password', 'database');

$query = "
SELECT 
    purchase.purchaseid,
    customer.customerName,
    product.productName,
    product.price,
    purchase.status,
    purchase.quantity
FROM 
    purchase
JOIN 
    customer ON purchase.customerid = customer.customerid
JOIN 
    product ON purchase.productid = product.productid;
";

$result = $connection->query($query);

$data = [];

while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data);

$connection->close();
?>