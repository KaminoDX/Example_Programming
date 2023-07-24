<?php
require("includes/config.inc.php");
require("includes/common.inc.php");
require("includes/conn.inc.php");

function leseKategorien($fid=null) {
	global $conn; //ermöglicht den Zugriff auf das conn-Objekt, das sich ja nicht innerhalb dieser Funktion befindet
	
	if(is_null($fid)) {
		$w = "FIDKategorie IS NULL";
	}
	else {
		$w = "FIDKategorie=" . $fid;
	}
	
	$sql = "
		SELECT
			*
		FROM tbl_kategorien
		WHERE(
			" . $w . "
		)
	";
	$kats = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
	echo('<ul>');
	while($kat = $kats->fetch_object()) {
		echo('
			<li>
				<a href="kategorie_produkte.php?idKat=' . $kat->IDKategorie . '">' . $kat->Kategorie . '</a>'
		);
		
		// ---- Rekursion: ----
		leseKategorien($kat->IDKategorie);
		// --------------------
		
		echo('	
			</li>
		');
	}
	echo('</ul>');
}
?>
<!doctype html>
<html lang="de">
	<head>
		<title>Hardwarekomponenten</title>
		<meta charset="utf-8">
		<link rel="stylesheet" href="css/common.css">
	</head>
	<body>
		<h1>Hardwarekomponenten</h1>
		<nav>
			<ul>
				<li><a href="index.html">zur Startseite</a></li>
				<li><a href="individualpcs.php">Individual-PCs</a></li>
			</ul>
		</nav>
		<?php
		leseKategorien();
		?>
	</body>
</html>