<?php 
require("includes/common.inc.php");
require("includes/config.inc.php");
require("includes/conn.inc.php");


if(isset($_POST['username']) && isset($_POST['password'])){
    $Vorname=$_POST['VN'];
    $Nachname=$_POST['NN'];
    $Emailadresse=$_POST['email'];
    $Passwort=$_POST['password'];
    $Staat=$_POST['staat'];
    $Geschlecht=$_POST['']


    
$temp = mysqli_query($db,
"INSERT INTO 
registration (username,email,password) 
VALUES ('$username','$email','$password')");

if(!$temp){
    echo "error";
}else{
    echo "Your registration is done.";
}
}
?>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration</title>
</head>
<body>
<h2>Registration</h2>    

<body>
<div class="container">
      <form class="form-signin" method="POST" name="registration">


	      <span class="input-group-addon" id="basic-addon1">Vorname</span>
	      <input type="text" name="VN" id="VN" class="form-control" placeholder="First Name" required>
        <br>
      
	        <span class="input-group-addon" id="basic-addon1">Nachname</span>
	        <input type="text" name="NN" id="NN" class="form-control" placeholder="Last Name" required>
	    <br>
        
        <label for="Staat" class="sr-only">Staat</label>
        <input type="text" name="country" id="country" class="form-control" placeholder="Staat" required>
        <br>
        <label for="Password" class="sr-only">Passwort</label>
        <input type="password" name="password" id="password" class="form-control" placeholder="Password" required>
        <br>
        <label for="Email" class="sr-only">Email</label>
        <input type="email" name="email" id="email" class="form-control" placeholder="Email address" required autofocus>
        <br>
        <input name="submit" type="submit" value="Register" />
        <a class="btn btn-lg btn-primary btn-block" href="login.php">Login</a>
      </form>
</div>
</body>
</html>