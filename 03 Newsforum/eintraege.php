<?php
require("includes/config.inc.php");
require("includes/common.inc.php");
require("includes/conn.inc.php");

function zeigeForum($fid=null) {
	global $conn; //$conn ist eine Variable, die außerhalb der Funktion definiert wurde; damit sie auch hier verwendbar ist, muss man sie entweder "global machen" oder die Variable (das Objekt) auf eine andere Art und Weise übergeben
	
	if(is_null($fid)) {
		$fid_string = " IS NULL";
	}
	else {
		$fid_string = "=".$fid;
	}
	
	$sql = "
		SELECT
			tbl_eintraege.IDEintrag,
			tbl_eintraege.Eintrag,
			tbl_eintraege.Eintragezeitpunkt,
			tbl_user.Vorname,
			tbl_user.Nachname
		FROM tbl_eintraege
		LEFT JOIN tbl_user ON tbl_eintraege.FIDUser=tbl_user.IDUser
		WHERE(
			tbl_eintraege.FIDEintrag" . $fid_string . "
		)
		ORDER BY tbl_eintraege.Eintragezeitpunkt ASC
	";
	$eintraege = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
	echo('<ul>');
	while($eintrag = $eintraege->fetch_object()) {
		echo('
			<li>
				' . $eintrag->Vorname . ' ' . $eintrag->Nachname . ' schrieb am ' . date("d.m.Y",strtotime($eintrag->Eintragezeitpunkt)) . ' um '  . date("H:i",strtotime($eintrag->Eintragezeitpunkt)) . ' Uhr:<br>' . $eintrag->Eintrag
		);
		
		zeigeForum($eintrag->IDEintrag); //Rekursion
			
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
		<title>Newsforum</title>
		<meta charset="utf-8">
	</head>
	<body>
		<h1>Newsforum</h1>
		<nav>
			<ul>
				<li><a href="index.html">zurück</a></li>
				<li><a href="eintraege_user.php">Einträge der User</a></li>
				<li><a href="eintraege_wortsuche.php">Suche</a></li>
			</ul>
		</nav>
		<?php
		zeigeForum();
		?>
	</body>
</html>