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
	</head>
	<body>
		<h1>Klassen</h1>
		<nav>
			<ul>
				<li><a href="index.html">zurück zur Übersicht</a></li>
				<li><a href="schueler.php">Schüler</a></li>
				<li><a href="raeume.php">Räume</a></li>
			</ul>
		</nav>
		<ul>
			<?php
			$sql = "
				SELECT
					tbl_klassen.IDKlasse,
					tbl_klassen.Bezeichnung,
					tbl_raeume.Bezeichnung AS bezRaum,
					tbl_lehrer.Vorname,
					tbl_lehrer.Nachname
				FROM tbl_klassen
				LEFT JOIN tbl_raeume ON tbl_raeume.IDRaum=tbl_klassen.FIDRaum
				LEFT JOIN tbl_lehrer ON tbl_lehrer.IDLehrer=tbl_klassen.FIDKV
				ORDER BY tbl_klassen.Bezeichnung ASC
			";
			$klassen = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			while($klasse = $klassen->fetch_object()) {
				//ta($klasse);
				echo('
					<li>' . $klasse->Bezeichnung . ' ist im Raum ' . $klasse->bezRaum . ' untergebracht; der Name des KVs ist ' . $klasse->Vorname . ' ' . $klasse->Nachname . '
						<ul>
				');
				
				// ---- alle Schüler der jeweiligen Klasse: ----
				$sql = "
					SELECT
						Vorname,
						Nachname,
						GebDatum
					FROM tbl_schueler
					WHERE(
						FIDKlasse=" . $klasse->IDKlasse . "
					)
					ORDER BY Nachname ASC, Vorname ASC
				";
				$schuelerliste = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
				while($schueler = $schuelerliste->fetch_object()) {
					//ta($schueler);
					echo('
						<li>' . $schueler->Vorname . ' ' . $schueler->Nachname . ', geb. ' . $schueler->GebDatum . '</li>
					');
				}
				// ---------------------------------------------
				
				echo('
						</ul>
					</li>
				');
			}
			?>
		</ul>
	</body>
</html>