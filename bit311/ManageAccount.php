<?php
    //open connection to mysql db
    $connection = mysqli_connect("localhost","root","","courts") or die("Error " . mysqli_error($connection));

    $username = $_SESSION['username'];

    $sql = "select * from customer where Username = '$username'";

    $result = mysqli_query($connection, $sql) or die("Error in Selecting " . mysqli_error($connection));

    //create an array
    $emparray = array();
    while($row =mysqli_fetch_assoc($result))
    {
        $emparray[] = $row;
    }
    echo json_encode($emparray);

    //close the db connection
    mysqli_close($connection);
?>
