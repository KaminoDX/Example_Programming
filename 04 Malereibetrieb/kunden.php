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
				<li><a href="kunden02.php">Kunden (Variante 2)</a></li>
				<li><a href="kunden03.php">Kunden (Variante 3)</a></li>
			</ul>
		</nav>
		
		<ul>
			<?php
			$sql = "
				SELECT
					*
				FROM tbl_kunden
				ORDER BY Nachname ASC, Vorname ASC
			";
			$kunden = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			while($kunde = $kunden->fetch_object()) {
				echo('
					<li>
						' . $kunde->Nachname . ' ' . $kunde->Vorname . '
						(' . $kunde->Adresse . ', ' . $kunde->PLZ . ' ' . $kunde->Ort . ' | ' . $kunde->Telno . ' &bull; ' . $kunde->Email . '):
						<ul>
				');
				
				// ---- Einsätze je Kunde: ----
				$sql = "
					SELECT
						Startzeitpunkt,
						Endzeitpunkt
					FROM tbl_einsatz
					WHERE(
						FIDKunde=" . $kunde->IDKunde . "
					)
				";
				$einsaetze = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
				$summe = 0; //Einsatz in Sekunden
				$min = 0;
				$max = 0;
				while($einsatz = $einsaetze->fetch_object()) {
					$summe = $summe + strtotime($einsatz->Endzeitpunkt) - strtotime($einsatz->Startzeitpunkt);
					
					if(strtotime($einsatz->Startzeitpunkt)<$min || $min==0) {
						$min = strtotime($einsatz->Startzeitpunkt);
					}
					if(strtotime($einsatz->Endzeitpunkt)>$max) {
						$max = strtotime($einsatz->Endzeitpunkt);
					}
				}
				echo('
					<li>verbrauchte Zeit (Halbstunden aufgerundet): ' . ceil($summe/60/30) . '</li>
					<li>Stundenanzahl: ' . ($summe/3600) . '</li>
					<li>Kosten: EUR ' . ceil($summe/60/30)*30 . '</li>
					<li>von ' . date("d.m.Y H:i",$min) . ' bis ' . date("d.m.Y H:i",$max) . '</li>
				');
				// ----------------------------
				
				echo('
						</ul>
					</li>
				');
			}
			?>
		</ul>
	</body>
</html>