<?php
require("includes/config.inc.php");
require("includes/common.inc.php");
require("includes/conn.inc.php");

ta($_POST);
?>
<!doctype html>
<html lang="de">
	<head>
		<title>Rechnungslegung</title>
		<meta charset="utf-8">
		<link rel="css/common.css">
	</head>
	<body>
		<h1>Rechnungslegung</h1>
		<nav>
			<ul>
				<li><a href="index.html">Startseite</a></li>
			</ul>
		</nav>
		<form method="post">
			<label>
				NN:
				<input type="text" name="NN">
			</label>
			<label>
				Re-No:
				<input type="text" name="ReNo">
			</label>
			<input type="submit" value="filtern">
		</form>
		<?php
		$where = "";
		if(count($_POST)>0) {
			$arr = [];
			if(strlen($_POST["NN"])>0) {
				$arr[] = "K.NN='" . $_POST["NN"] . "'";
			}
			if(strlen($_POST["ReNo"])>0) {
				$arr[] = "R.ReNo='" . $_POST["ReNo"] . "'";
			}
			
			if(count($arr)>0) {
				$where = "
					WHERE(
						" . implode(" AND ",$arr) . "
					)
				";
			}
		}
		
		$sql = "
			SELECT
				R.IDRechnung,
				R.ReNo,
				R.Datum,
				K.Nachname AS NN,
				K.Vorname,
				K.Adresse,
				K.PLZ,
				K.Ort,
				K.Emailadresse,
				tbl_staaten.Staat,
				tbl_zahlungsarten.Zahlungsart,
				tbl_zahlungsarten.AufpreisExkl,
				tbl_versand_paket.Kosten,
				tbl_paketgroessen.Bezeichnung,
				tbl_versandarten.Versandart,
				tbl_ustsaetze.UStSatz
				
			FROM tbl_rechnungen AS R
			INNER JOIN tbl_kunden AS K ON K.IDKunde=R.FIDKunde
			INNER JOIN tbl_staaten ON tbl_staaten.IDStaat=K.FIDStaat
			INNER JOIN tbl_zahlungsarten ON tbl_zahlungsarten.IDZahlungsart=R.FIDZahlungsart
			INNER JOIN tbl_versand_paket ON tbl_versand_paket.IDVersandPaket=R.FIDVersandPaket
			INNER JOIN tbl_paketgroessen ON tbl_paketgroessen.IDPaketgroesse=tbl_versand_paket.FIDPaket
			INNER JOIN tbl_versandarten ON tbl_versandarten.IDVersandart=tbl_versand_paket.FIDVersandart
			INNER JOIN tbl_ustsaetze ON tbl_ustsaetze.IDUStSatz=tbl_versand_paket.FIDUStSatz
			" . $where . "
		";
		ta($sql);
		$rechnungen = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
		while($re = $rechnungen->fetch_object()) {
			echo('
				<article>
					<address>
						' . $re->Vorname . ' ' . $re->NN . '<br>
						' . $re->Adresse . '<br>
						' . $re->PLZ . ' ' . $re->Ort . '<br>
						' . $re->Staat . '<br>
						per Email: ' . $re->Emailadresse . '
					</address>
					<div>
						Rechnung Nr. ' . $re->ReNo . '<br>
						Rechnungsdatum: ' . $re->Datum . '
					</div>
				</article>
				<table>
					<tbody>
			');
			
			// ---- Positionen je Rechnung: ----
			$sql = "
				SELECT
					tbl_positionen.Anzahl,
					tbl_produkte.Produkt,
					tbl_produkte.Beschreibung,
					tbl_produkte.PreisExkl,
					tbl_produkte.Produktbild,
					tbl_ustsaetze.UStSatz
				FROM tbl_positionen
				INNER JOIN tbl_produkte ON tbl_produkte.IDProdukt=tbl_positionen.FIDProdukt
				INNER JOIN tbl_ustsaetze ON tbl_ustsaetze.IDUStSatz=tbl_produkte.FIDUStSatz
				WHERE(
					tbl_positionen.FIDRechnung=" . $re->IDRechnung . "
				)
			";
			$positionen = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			$sum_preise = 0;
			$sum_ust = 0;
			while($p = $positionen->fetch_object()) {
				$preisInkl = $p->PreisExkl*(1+$p->UStSatz/100);
				$ust = $p->PreisExkl*$p->UStSatz/100;
				$sum_preise += $p->Anzahl*$preisInkl;
				$sum_ust += $p->Anzahl*$ust;
				
				if(is_null($p->Produktbild)) {
					$bild = "";
				}
				else {
					$bild = '<img src="' . $p->Produktbild . '" alt="' . $p->Produkt . '">';
				}
				
				echo('
					<tr>
						<td>' . $p->Anzahl . '</td>
						<td>' . $bild . '</td>
						<td>' . $p->Produkt . '<div>' . $p->Beschreibung . '</div></td>
						<td>
							<ul>
								<li>Ihr Preis: ' . $preisInkl . '</li>
								<li>Inkl. ' . $ust . '</li>
								<li>Einzelpreis...</li>
							</ul>
						</td>
					</tr>
				');
			}
			// ---------------------------------
			
			$vs = $re->Kosten*(1+$re->UStSatz/100);
			$vs_ust = $re->Kosten*$re->UStSatz/100;
			$zk = $sum_preise*$re->AufpreisExkl/100;
			$zk_ust = $sum_ust*$re->AufpreisExkl/100;
			echo('
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4">
								<ul>
									<li>Positionen: ' . $sum_preise . ' inkl. USt. ' . $sum_ust . '</li>
									<li>Versand: ' . $vs . ' inkl. USt. ' . $vs_ust . '</li>
									<li>Zahlungskosten: ' . $zk . ' inkl. USt. ' . $zk_ust . '</li>
									<li>Gesamt: ' . ($sum_preise+$vs+$zk) . ' inkl. USt. ' . ($sum_ust+$vs_ust+$zk_ust) . '</li>
								</ul>
								Alle Preise sind in EUR angegeben.
							</td>
						</tr>
					</tfoot>
				</table>
				<p>Ihre Adressdaten:</p>
				<address>
					Rechnungsadresse:<br>
					' . $re->Adresse . ',
					' . $re->PLZ . ' ' . $re->Ort . '<br>
					' . $re->Staat . '<br>
					Lieferadresse:<br>
					' . $re->Adresse . ',
					' . $re->PLZ . ' ' . $re->Ort . '<br>
					' . $re->Staat . '<br>
				</address>
				<ul>
					<li>Zahlungsvariante: ' . $re->Zahlungsart . '</li>
					<li>Versandart: ' . $re->Versandart . '</li>
				</ul>
			');
		}
		?>
	</body>
</html>