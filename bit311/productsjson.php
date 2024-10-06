<?php
    //open connection to mysql db
    $connection = mysqli_connect("localhost","root","","courts") or die("Error " . mysqli_error($connection));

    //fetch table rows from mysql db
    $sql = "select * from product";
    $result = mysqli_query($connection, $sql) or die("Error in Selecting " . mysqli_error($connection));

    //create an array
    $prodarray = array();
    while($row = mysqli_fetch_assoc($result))
    {
        $prodarray[] = $row;
    }
    echo json_encode($prodarray);

    //close the db connection
    mysqli_close($connection);
?>