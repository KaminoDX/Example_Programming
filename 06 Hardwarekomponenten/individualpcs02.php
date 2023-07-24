<?php
require("includes/common.inc.php");
require("includes/config.inc.php");
require("includes/conn.inc.php");
?>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Individual-PCs</title>
<link rel="stylesheet" href="css/common.css">
</head>

<body>
    <h1>Individual-PCs</h1>
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
    <?php
    $arr_W = ["tbl_produkte.FIDKategorie=2"];
    
    if(count($_POST)>0) {
		$arr = ["tbl_konfigurator.FIDPC=tbl_produkte.IDProdukt"];
		if(strlen($_POST["K"])>0) {
			$arr[] = "Produkt LIKE '%" . $_POST["K"] . "%'";
		}
		if(strlen($_POST["ANr"])>0) {
			$arr[] = "Artikelnummer LIKE '%" . $_POST["ANr"] . "%'";
		}
	   $arr_W[] = "
			(
				SELECT COUNT(tbl_pr.IDProdukt) AS cnt FROM tbl_konfigurator
				INNER JOIN tbl_produkte AS tbl_pr ON tbl_konfigurator.FIDKomponente=tbl_pr.IDProdukt
				WHERE(
					" . implode(" AND ",$arr) . "
				)
			)>0
		";
	}
    
    $sql = "
        SELECT
            tbl_produkte.*,
            tbl_lieferbarkeiten.Lieferbarkeit
        FROM tbl_produkte
        INNER JOIN tbl_lieferbarkeiten ON tbl_lieferbarkeiten.IDLieferbarkeit=tbl_produkte.FIDLieferbarkeit
        WHERE(
            " . implode(" AND ",$arr_W) . "
        )
    ";
	ta($sql);
    $pcs = $GLOBALS["conn"]->query($sql) or die("Fehler in der Query: " . $GLOBALS["conn"]->error . "<br>" . $sql);
        echo('<ul>');
        while($pc = $pcs->fetch_object()) {
            echo('
                <li>
                    ' . $pc->Produkt . ':
                    <ul>
            ');
            $sql = "
                SELECT
                    tbl_produkte.*,
                    tbl_lieferbarkeiten.Lieferbarkeit
                FROM tbl_konfigurator
                INNER JOIN tbl_produkte ON tbl_produkte.IDProdukt=tbl_konfigurator.FIDKomponente
                INNER JOIN tbl_lieferbarkeiten ON tbl_lieferbarkeiten.IDLieferbarkeit=tbl_produkte.FIDLieferbarkeit
                WHERE(
                    FIDPC=" . $pc->IDProdukt . "
                )
                ORDER BY tbl_produkte.Produkt ASC
            ";
            $komponenten = $GLOBALS["conn"]->query($sql) or die("Fehler in der Query: " . $GLOBALS["conn"]->error . "<br>" . $sql);
            $ges = 0;
            while($produkt = $komponenten->fetch_object()) {
                if(!is_null($produkt->Produktfoto)) {
                    $img = '<img src="' . $produkt->Produktfoto . '" alt="' . $produkt->Produkt . '">';
                }
                else {
                    $img = '<div>kein Foto verfügbar</div>';
                }
                echo('
                    <li>
                        ' . $img . '
                        <strong>' . $produkt->Artikelnummer . ' - ' . $produkt->Produkt . '</strong>
                        <div>' . $produkt->Beschreibung . '</div>
                        <div>EUR ' . $produkt->Preis . '</div>
                        <div>' . $produkt->Lieferbarkeit . '</div>
                    </li>
                ');
                
                $ges+= $produkt->Preis;
            }
            
            echo('        
                    </ul>
                    Gesamtpreis: ' . $ges . '
                </li>
            ');
        }
        echo('</ul>');
    ?>
</body>
</html>