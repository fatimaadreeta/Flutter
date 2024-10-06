<?php
if(isset($_POST['Login']))
{
  $servername = "localhost";
  $username = "root";
  $password = "";
  $dbname = "courts";
  $con = new mysqli($servername, $username, $password, $dbname);

  $username=$_POST['username'];
  $password=$_POST['password'];

  if($username!='' && $password!='')
  {
    $sql = "select * from admin WHERE username='$username' and password='$password'";
    $result = mysqli_query($con, $sql);

    if (mysqli_num_rows($result) > 0)
    {
      $_SESSION['username']=$username;
    }
    else{
      echo "Invalid username and password";
    }
  }
}
?>
