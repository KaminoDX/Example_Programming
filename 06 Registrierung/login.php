<?php
require("includes/config.inc.php");
require("includes/common.inc.php");
require("includes/conn.inc.php");

ta($_POST);

$msg = "";

if(count($_POST)>0) {
	$sql = "
		SELECT
			IDUser
		FROM tbl_user
		WHERE(
			Emailadresse='" . $_POST["E"] . "'
		)
	";
	$userliste = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
	ta($userliste);
	if($userliste->num_rows) {
		$user = $userliste->fetch_object();
		$idUser = $user->IDUser;
		
		$sql = "
			SELECT
				Passwort
			FROM tbl_passwoerter
			WHERE(
				FIDUser=" . $idUser . "
			)
			ORDER BY Nutzungszeitpunkt DESC
			LIMIT 1
		";
		$passwoerter = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
		$passwort = $passwoerter->fetch_object();
		if($passwort->Passwort==$_POST["P0"]) {
			//Emailadresse und Passwort waren korrekt --> Login!
			session_start();
			$_SESSION["idUser"] = $idUser;
			$_SESSION["eingeloggt"] = true;
			header("Location: profil.php");
		}
		else {
			$msg = '<p class="error">Leider waren die eingegebenen Daten nicht korrekt. Bitte versuchen Sie es erneut.</p>';
		}
	}
	else {
		$msg = '<p class="error">Leider waren die eingegebenen Daten nicht korrekt. Bitte versuchen Sie es erneut.</p>';
	}
}
?>
<!doctype html>
<html lang="de">
	<head>
		<title>Login</title>
		<meta charset="utf-8">
		<style>
			input,
			label,
			select {
				display:block;
			}
		</style>
	</head>
	<body>
		<?php echo($msg); ?>
		<form method="post" enctype="multipart/form-data">
			<label>
				Emailadresse:
				<input type="email" name="E" required>
			</label>
			<label>
				Passwort:
				<input type="password" name="P0" required>
			</label>
			<input type="submit" value="login">
		</form>
	</body>
</html>