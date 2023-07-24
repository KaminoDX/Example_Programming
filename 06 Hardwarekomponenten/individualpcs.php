<?php
require("includes/config.inc.php");
require("includes/common.inc.php");
require("includes/conn.inc.php");

ta($_POST);
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
			</ul>
		</nav>
		<form method="post">
			<label>
				Komponente:
				<input type="text" name="K">
			</label>
			<label>
				Artikelnummer:
				<input type="text" name="ANr">
			</label>
			<input type="submit" value="filtern">
		</form>
		<ul>
		<?php			
			$sql = "
				SELECT
					*
				FROM tbl_produkte
				WHERE(
					FIDKategorie=2
				)
			";
			$pcs = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			while($pc = $pcs->fetch_object()) {
				$anzKomponenten = 1;
				
				if(count($_POST)>0) {
					$arr = ["tbl_konfigurator.FIDPC=" . $pc->IDProdukt];
					if(strlen($_POST["K"])>0) {
						$arr[] = "Produkt LIKE '%" . $_POST["K"] . "%'";
					}
					if(strlen($_POST["ANr"])>0) {
						$arr[] = "Artikelnummer LIKE '%" . $_POST["ANr"] . "%'";
					}
					
					if(count($arr)>1) {
						$sql = "
							SELECT
								COUNT(*) AS cnt
							FROM tbl_konfigurator
							INNER JOIN tbl_produkte ON tbl_produkte.IDProdukt=tbl_konfigurator.FIDKomponente
							WHERE(
								" . implode(" AND ",$arr) . "
							)
						";
						$komps = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
						$komp = $komps->fetch_object();
						$anzKomponenten = $komp->cnt;
						ta($komp);
					}
				}
				
				
				if($anzKomponenten>0) {
					if(is_null($pc->Produktfoto)) {
						$bild = "";
					}
					else {
						$bild = '<img src="' . $pc->Produktfoto . '" alt="' . $pc->Produkt . '">';
					}
					echo('
						<li>
							' . $pc->Produkt . ' (' . $pc->Artikelnummer . '; ' . $pc->IDProdukt . ')
							<div>' . $pc->Beschreibung . '</div>
							<ul>
					');
					
					// ---- alle Komponenten des ausgewählten PCs: ----
					$sql = "
						SELECT
							tbl_konfigurator.Anzahl,
							tbl_produkte.*,
							tbl_lieferbarkeiten.Lieferbarkeit
						FROM tbl_konfigurator
						INNER JOIN tbl_produkte ON tbl_produkte.IDProdukt=tbl_konfigurator.FIDKomponente
						INNER JOIN tbl_lieferbarkeiten ON tbl_lieferbarkeiten.IDLieferbarkeit=tbl_produkte.FIDLieferbarkeit
						WHERE(
							tbl_konfigurator.FIDPC=" . $pc->IDProdukt . "
						)
					";
					//ta($sql);
					$komponenten = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
					$sum = 0;
					while($k = $komponenten->fetch_object()) {
						$sum = $sum + $k->Anzahl*$k->Preis;
						if(is_null($k->Produktfoto)) {
							$bildk = "";
						}
						else {
							$bildk = '<img src="' . $k->Produktfoto . '" alt="' . $k->Produkt . '">';
						}
						echo('
							<li>
								' . $k->Produkt . ' (' . $k->Artikelnummer . ')
								<div>' . $k->Beschreibung . '</div>
								EUR '.  $k->Preis . ' (' . $k->Lieferbarkeit . ')
								' . $bildk . '
							</li>
						');
					}
					// ------------------------------------------------
					
					echo('
							</ul>
							EUR '.  $sum . '
							' . $bild . '
						</li>
					');
				}
			}
		?>
		</ul>
	</body>
</html>