<?php
require("includes/config.inc.php");
require("includes/common.inc.php");
require("includes/conn.inc.php");

$idKat = 0; //kennzeichnet, dass keine idKat übergeben wurde
if(count($_GET)>0 && isset($_GET["idKat"])) {
	$idKat = intval($_GET["idKat"]);
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
				<li><a href="kategorien.php">Kategorien</a></li>
				<li><a href="individualpcs.php">Individual-PCs</a></li>
			</ul>
		</nav>
		<?php
		if($idKat>0) {
			echo('<ul>');
			$sql = "
				SELECT
					tbl_produkte.*,
					tbl_lieferbarkeiten.Lieferbarkeit
				FROM tbl_produkte
				INNER JOIN tbl_lieferbarkeiten ON tbl_lieferbarkeiten.IDLieferbarkeit=tbl_produkte.FIDLieferbarkeit
				WHERE(
					FIDKategorie=" . $idKat . "
				)
					
			";
			$produkte = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			while($produkt = $produkte->fetch_object()) {
				if(is_null($produkt->Produktfoto)) {
					$bild = "";
				}
				else {
					$bild = '<img src="' . $produkt->Produktfoto . '" alt="' . $produkt->Produkt . '">';
				}
				echo('
					<li>
						' . $produkt->Produkt . ' (' . $produkt->Artikelnummer . ')
						<div>' . $produkt->Beschreibung . '</div>
						EUR '.  $produkt->Preis . ' (' . $produkt->Lieferbarkeit . ')
						' . $bild . '
					</li>
				');
			}
			echo('</ul>');
		}
		?>
	</body>
</html>