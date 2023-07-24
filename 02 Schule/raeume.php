<?php
require("includes/config.inc.php");
require("includes/common.inc.php");
require("includes/conn.inc.php");
?>
<!doctype html>
<html lang="de">
	<head>
		<title>Schule</title>
		<meta charset="utf-8">
		<link rel="stylesheet" href="css/common.css">
	</head>
	<body>
		<h1>Räume</h1>
		<nav>
			<ul>
				<li><a href="index.html">zurück zur Übersicht</a></li>
				<li><a href="klassen.php">Klassen</a></li>
				<li><a href="schueler.php">Schüler</a></li>
			</ul>
		</nav>
		<ul>
			<?php
			$sql = "
				SELECT
					tbl_raeume.Bezeichnung AS bezRaum,
					tbl_klassen.Bezeichnung AS bezKlasse
				FROM tbl_raeume
				LEFT JOIN tbl_klassen ON tbl_klassen.FIDRaum=tbl_raeume.IDRaum
				ORDER BY tbl_raeume.Bezeichnung ASC
			";
			$raeume = $conn->query($sql) OR die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			while($raum = $raeume->fetch_object()) {
				if(is_null($raum->bezKlasse)) {
					$klasse = "keine Klasse";
				}
				else {
					$klasse = "die Klasse " . $raum->bezKlasse;
				}
				
				echo('
					<li>Raum ' . $raum->bezRaum . ': in diesem Jahr ist in diesem Raum ' . $klasse . ' untergebracht</li>
				');
			}
			?>
		</ul>
	</body>
</html>