<?php
require("includes/config.inc.php");
require("includes/common.inc.php");
require("includes/conn.inc.php");

ta($_POST);
?>
<!doctype html>
<html lang="de">
	<head>
		<title>Newsforum</title>
		<meta charset="utf-8">
	</head>
	<body>
		<h1>Newsforum</h1>
		<nav>
			<ul>
				<li><a href="index.html">zurück</a></li>
				<li><a href="eintraege.php">Einträge</a></li>
				<li><a href="eintraege_wortsuche.php">Suche</a></li>
			</ul>
		</nav>
		<form method="post">
			<label>
				Emailadresse:
				<input type="email" name="E">
			</label>
			<input type="submit" value="filtern">
		</form>
		<ul>
			<?php
			$sql = "
				SELECT
					*
				FROM tbl_user
			";
			
			if(count($_POST)>0 && strlen($_POST["E"])>0) {
				$sql .= "
					WHERE(
						Emailadresse='" . $_POST["E"] . "'
					)
				";
			}
			
			$sql .= "
				ORDER BY Nachname ASC, Vorname ASC
			";
			$userliste = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			while($user = $userliste->fetch_object()) {
				echo('
					<li>' . $user->Nachname . ' ' . $user->Vorname . ':
						<ul>
				');
				
				// ---- Einträge je User: ----
				$sql = "
					SELECT
						*
					FROM tbl_eintraege
					WHERE(
						FIDUser=" . $user->IDUser . "
					)
					ORDER BY Eintragezeitpunkt DESC
				";
				$eintraege = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
				while($eintrag = $eintraege->fetch_object()) {
					echo('
						<li>' . date("d.m.Y, H:i",strtotime($eintrag->Eintragezeitpunkt)) . ' Uhr: ' . $eintrag->Eintrag . '</li>
					');
				}
				// ---------------------------
				
				echo('		
						</ul>
					</li>
				');
			}
			?>
		</ul>
	</body>
</html>