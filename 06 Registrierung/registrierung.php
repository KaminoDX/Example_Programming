<?php
require("includes/config.inc.php");
require("includes/common.inc.php");
require("includes/conn.inc.php");

ta($_POST);
ta($_FILES);

$msg = "";
$idUser = null;

function checkIfZero($in) {
	if(intval($in)==0) {
		return "NULL";
	}
	else {
		return $in;
	}
}

function checkIfEmpty($in) {
	if(strlen($in)==0) {
		return "NULL";
	}
	else {
		return "'" . $in . "'";
	}
}

if(count($_POST)>0) {
	// Schritt 1: nachsehen, ob die Emailadresse nicht bereits existiert
	$sql = "
		SELECT
			COUNT(*) AS cnt
		FROM tbl_user
		WHERE(
			Emailadresse='" . $_POST["E"] . "'
		)
	";
	ta($sql);
	$userliste = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
	$user = $userliste->fetch_object();
	ta($user);
	if($user->cnt==0) {
		//diese Emailadresse ist noch nicht registriert --> fortsetzen mit der Passwortüberprüfung
		if(strlen($_POST["P0"])>=8) {
			//die Länge des Passwortes ist ok --> fortsetzen mit der Überprüfung, ob die beiden Passwörter ident sind
			if($_POST["P0"]==$_POST["P1"]) {
				//die Passwörter stimmen überein --> User in die Usertabelle eintragen
				$sql = "
					INSERT INTO tbl_user
						(Emailadresse, Vorname, Nachname, GebDatum, FIDGebLand, FIDGeschlecht)
					VALUES (
						'" . $_POST["E"] . "',
						" . checkIfEmpty($_POST["VN"]) . ",
						" . checkIfEmpty($_POST["NN"]) . ",
						" . checkIfEmpty($_POST["GD"]) . ",
						" . checkIfZero($_POST["IDStaat"]) . ",
						" . checkIfZero($_POST["IDGeschlecht"]) . "
					)
				";
				ta($sql);
				$ok = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
				$idUser = $conn->insert_id; //zuletzt vergebene ID (hier: in der Tabelle tbl_user)
				
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
				$msg = '<p class="error">Die eingegebenen Passwörter stimmen nicht überein.</p>';
			}
		}
		else {
			$msg = '<p class="error">Das Passwort genügt unseren Kriterien nicht.</p>';
		}
	}
	else {
		$msg = '<p class="error">Diese Emailadresse ist bereits registriert.</p>';
	}
}

if(count($_FILES)>0 && !is_null($idUser)) {
	//es wurde ein Formular mit einer Uploadmöglichkeit abgeschickt UND es wurde erfolgreich ein User in der Tabelle tbl_user angelegt
	
	$f = $_FILES["PB"]; //Hilfsvariable
	if($f["error"]==0) {
		$pfadinfos = pathinfo($f["name"]);
		$name = $idUser . "." . $pfadinfos["extension"];
		if(!file_exists("profilbilder")) {
			$ok = mkdir("profilbilder",0755);
		}
		else {
			$ok = true;
		}
		
		if($ok) {
			$ok = move_uploaded_file($f["tmp_name"],"profilbilder/" . $name);
			if($ok) {
				$sql = "
					UPDATE tbl_user SET
						Profilbild='profilbilder/" . $name . "'
					WHERE(
						IDUser=" . $idUser . "
					)
				";
				ta($sql);
				$ok = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			}
			else {
				$msg = '<p class="error">Leider konnte Ihr Profilbild nicht gespeichert werden (2).</p>';
			}
		}
		else {
			$msg = '<p class="error">Leider konnte Ihr Profilbild nicht gespeichert werden (1).</p>';
		}
	}
}
?>
<!doctype html>
<html lang="de">
	<head>
		<title>Registrierung</title>
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
			<fieldset>
				<legend>Pflichtangaben</legend>
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
				<legend>freiwillige Angaben</legend>
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