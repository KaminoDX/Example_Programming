<?php
require("includes/config.inc.php");
require("includes/common.inc.php");
require("includes/conn.inc.php");

ta($_POST);
ta($_FILES);

$msg = "";
$idUser = null;

function checkInput_numeric($in) {
	if(!is_int($in) || intval($in)==0) {
		return "NULL";
	}
	else {
		return $in;
	}
}

function checkInput_string($in) {
	if(strlen($in)==0) {
		return "NULL";
	}
	else {
		return "'" . $in . "'";
	}
}

if(count($_POST)>0) {
	// Schritt 1: überprüfen, ob die Emailadresse, die der User eingegeben hat, nicht bereits im System registriert ist
	$sql = "
		SELECT
			COUNT(*) AS cnt
		FROM tbl_user
		WHERE(
			Emailadresse='" . $_POST["E"] . "'
		)
	";
	$userliste = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
	$user = $userliste->fetch_object();
	if($user->cnt==0) {
		//Emailadresse noch nicht vergeben --> Passwortdaten prüfen
		if(strlen($_POST["P0"])>=8) {
			//Passwortlänge für P0 stimmt --> Passwortübereinstimmung prüfen
			if($_POST["P0"]==$_POST["P1"]) {
				//Passwörter stimmen überein --> User eintragen
				$sql = "
					INSERT INTO tbl_user
						(Emailadresse, Vorname, Nachname, GebDatum, FIDGebLand, FIDGeschlecht)
					VALUES (
						'" . $_POST["E"] . "',
						" . checkInput_string($_POST["VN"]) . ",
						" . checkInput_string($_POST["NN"]) . ",
						" . checkInput_string($_POST["GD"]) . ",
						" . checkInput_numeric($_POST["IDStaat"]) . ",
						" . checkInput_numeric($_POST["IDGeschlecht"]) . "
					)
				";
				ta($sql);
				$ok = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
				
				$idUser = $conn->insert_id; //ergibt die soeben dem neuen User zugewiesene ID
				
				$sql = "
					INSERT INTO tbl_passwoerter
						(FIDUser, Passwort)
					VALUES (
						" . $idUser . ",
						'" . $_POST["P0"] . "'
					)
				";
				ta($sql);
				$ok = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			}
			else {
				$msg = '<p class="error">Die Passwörter stimmen nicht überein.</p>';
			}
		}
		else {
			$msg = '<p class="error">Die Passwortlänge ist nicht korrekt (mind. 8 Zeichen sind gefordert).</p>';
		}
	}
	else {
		$msg = '<p class="error">Diese Emailadresse ist bereits registriert.</p>';
	}
}

if(count($_FILES)>0 && !is_null($idUser)) {
	$f = $_FILES["PB"]; //Hilfsvariable
	if($f["error"]==0) {
		if(!file_exists("profilbilder")) {
			$ok = mkdir("profilbilder",0755);
		}
		else {
			$ok = true;
		}
		
		if($ok) {
			$pathinfo = pathinfo($f["name"]);
			$bildname = $idUser . "." . $pathinfo["extension"];
			$ok = move_uploaded_file($f["tmp_name"],"profilbilder/" . $bildname);
			if($ok) {
				$sql = "
					UPDATE tbl_user SET
						Profilbild='profilbilder/" . $bildname . "'
					WHERE(
						IDUser=" . $idUser . "
					)
				";
				$ok = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			}
		}
	}
	else {
		$msg.= '<p class="error">Leider konnte das Profilbild nicht gespeichert werden.</p>';
	}
}
?>
<!doctype html>
<html lang="de">
	<head>
		<title>Registrierung</title>
		<meta charset="utf-8">
		<style>
		label,
		input,
		select {
			display:block;
		}
		</style>
	</head>
	<body>
		<nav>
			<ul>
				<li><a href="registrierung.php">Registrierung</a></li>
				<li><a href="login.php">Login</a></li>
				<li><a href="login_admin.php">Login (Admin)</a></li>
			</ul>
		</nav>
		<?php echo($msg); ?>
		<form method="post" enctype="multipart/form-data">
			<fieldset>
				<legend>verpflichtende Daten</legend>
				<label>
					Emailadresse:
					<input type="email" name="E" required>
				</label>
				<label>
					Passwort:
					<input type="password" name="P0" required>
					<input type="password" name="P1" required placeholder="Passwort wiederholen">
				</label>
			</fieldset>
			<fieldset>
				<legend>freiwillige Daten</legend>
				<label>
					Vorname:
					<input type="text" name="VN">
				</label>
				<label>
					Nachname:
					<input type="text" name="NN">
				</label>
				<label>
					Geburtsdatum:
					<input type="date" name="GD">
				</label>
				<label>
					Geburtsland:
					<select name="IDStaat">
						<option value="0">Bitte wählen:</option>
						<?php
						$sql = "
							SELECT
								*
							FROM tbl_staaten
							ORDER BY Staat ASC
						";
						$staaten = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
						while($staat = $staaten->fetch_object()) {
							echo('
								<option value="' . $staat->IDStaat . '">' . $staat->Staat . '</option>
							');
						}
						?>
					</select>
				</label>
				<label>
					Geschlecht:
					<select name="IDGeschlecht">
						<option value="0">Bitte wählen:</option>
						<?php
						$sql = "
							SELECT
								*
							FROM tbl_geschlechter
							ORDER BY Geschlecht ASC
						";
						$geschlechter = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
						while($geschlecht = $geschlechter->fetch_object()) {
							echo('
								<option value="' . $geschlecht->IDGeschlecht . '">' . $geschlecht->Geschlecht . '</option>
							');
						}
						?>
					</select>
				</label>
				<label>
					Profilbild:
					<input type="file" name="PB">
				</label>
			</fieldset>
			<input type="submit" value="registrieren">
		</form>
	</body>
</html>