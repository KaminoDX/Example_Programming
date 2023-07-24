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
				<li><a href="eintraege_user.php">Einträge der User</a></li>
			</ul>
		</nav>
		<form method="post">
			<label>
				Suchbegriff:
				<input type="search" name="S">
			</label>
			<input type="submit" value="suchen">
		</form>
		<ul>
			<?php
			$sql = "
				SELECT
					tbl_eintraege.Eintrag,
					tbl_eintraege.Eintragezeitpunkt,
					tbl_user.Vorname,
					tbl_user.Nachname
				FROM tbl_eintraege
				LEFT JOIN tbl_user ON tbl_eintraege.FIDUser=tbl_user.IDUser
			";
			
			if(count($_POST)>0 && strlen($_POST["S"])>0) {
				$sql .= "
					WHERE(
						Eintrag LIKE '%" . $_POST["S"] . "%'
					)
				";
			}
			
			$sql .= "
				ORDER BY Eintragezeitpunkt ASC
			";
			$eintraege = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			while($eintrag = $eintraege->fetch_object()) {
				$e = $eintrag->Eintrag;
				if(count($_POST)>0 && strlen($_POST["S"])>0) {
					/* Variante 1:
					$tmp = explode($_POST["S"],$eintrag->Eintrag);
					$e = implode("<mark>" . $_POST["S"] . "</mark>",$tmp);
					*/
					
					// Variante 2 (einfacher: suchen & ersetzen): Nachteil: Groß- und Kleinschreibung wird beachtet
					$e = str_replace($_POST["S"],'<mark>' . $_POST["S"] . '</mark>',$e);
				}
				
				echo('
					<li>' . date("d.m.Y, H:i",strtotime($eintrag->Eintragezeitpunkt)) . ' Uhr: ' . $e . '</li>
				');
			}
			?>
		</ul>
	</body>
</html>