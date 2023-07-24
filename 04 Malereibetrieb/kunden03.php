<?php
require("includes/config.inc.php");
require("includes/common.inc.php");
require("includes/conn.inc.php");

$keys = ["NNMa","VNMa","NNKd","VNKd"];
for($i=0; $i<count($keys); $i++) {
	if(!isset($_POST[$keys[$i]])) { $_POST[$keys[$i]] = ""; }
}
?>
<!doctype html>
<html lang="de">
	<head>
		<title>Malereibetrieb</title>
		<meta charset="utf-8">
	</head>
	<body>
		<h1>Kunden</h1>
		<nav>
			<ul>
				<li><a href="index.html">zur Startseite</a></li>
				<li><a href="mitarbeiter.php">Mitarbeiter</a></li>
				<li><a href="kunden.php">Kunden (Variante 1)</a></li>
				<li><a href="kunden02.php">Kunden (Variante 2)</a></li>
			</ul>
		</nav>
		
		<ul>
			<?php
			$sql = "
				SELECT
					*,
					(
						SELECT 	SUM(TIMESTAMPDIFF(SECOND,Startzeitpunkt,Endzeitpunkt))
						FROM tbl_einsatz
						WHERE(
							FIDKunde=IDKunde
						)
					) AS sum,
					(
						SELECT 	MIN(Startzeitpunkt)
						FROM tbl_einsatz
						WHERE(
							FIDKunde=IDKunde
						)
					) AS minD,
					(
						SELECT 	MAX(Endzeitpunkt)
						FROM tbl_einsatz
						WHERE(
							FIDKunde=IDKunde
						)
					) AS maxD
				FROM tbl_kunden
				ORDER BY Nachname ASC, Vorname ASC
			";
			$kunden = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			while($kunde = $kunden->fetch_object()) {
				$summe = $kunde->sum;
				$min = strtotime($kunde->minD);
				$max = strtotime($kunde->maxD);
				
				echo('
					<li>
						' . $kunde->Nachname . ' ' . $kunde->Vorname . '
						(' . $kunde->Adresse . ', ' . $kunde->PLZ . ' ' . $kunde->Ort . ' | ' . $kunde->Telno . ' &bull; ' . $kunde->Email . '):
						<ul>
							<li>verbrauchte Zeit (Halbstunden aufgerundet): ' . ceil($summe/60/30) . '</li>
							<li>Stundenanzahl: ' . ($summe/3600) . '</li>
							<li>Kosten: EUR ' . ceil($summe/60/30)*30 . '</li>
							<li>von ' . date("d.m.Y H:i",$min) . ' bis ' . date("d.m.Y H:i",$max) . '</li>
						</ul>
					</li>
				');
			}
			?>
		</ul>
	</body>
</html>