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
		<h1>Mitarbeiter</h1>
		<nav>
			<ul>
				<li><a href="index.html">zur Startseite</a></li>
				<li><a href="kunden.php">Kunden (Variante 1)</a></li>
				<li><a href="kunden02.php">Kunden (Variante 2)</a></li>
				<li><a href="kunden03.php">Kunden (Variante 3)</a></li>
			</ul>
		</nav>
		<form method="post">
			<fieldset>
				<legend>Mitarbeiter</legend>
				<label>
					Nachname:
					<input type="text" name="NNMa" value="<?php echo($_POST["NNMa"]); ?>">
				</label>
				<label>
					Vorname:
					<input type="text" name="VNMa" value="<?php echo($_POST["VNMa"]); ?>">
				</label>
			</fieldset>
			<fieldset>
				<legend>Kunde</legend>
				<label>
					Nachname:
					<input type="text" name="NNKd" value="<?php echo($_POST["NNKd"]); ?>">
				</label>
				<label>
					Vorname:
					<input type="text" name="VNKd" value="<?php echo($_POST["VNKd"]); ?>">
				</label>
			</fieldset>
			<input type="submit" value="filtern">
		</form>
		<ul>
			<?php
			$w = "";
			if(count($_POST)>0) {
				$arr = [];
				if(strlen($_POST["NNMa"])>0) {
					$arr[] = "Nachname='" . $_POST["NNMa"] . "'";
				}
				if(strlen($_POST["VNMa"])>0) {
					$arr[] = "Vorname='" . $_POST["VNMa"] . "'";
				}
				if(count($arr)>0) {
					$w = "
						WHERE(
							" . implode(" AND ",$arr) . "
						)
					";
				}
			}
				
			$sql = "
				SELECT
					*
				FROM tbl_mitarbeiter
				" . $w . "
				ORDER BY Nachname ASC, Vorname ASC
			";
			
			//ta($sql);
			$maliste = $conn->query($sql);
			if($maliste===false) {
				if(TESTMODUS) {
					die("Fehler in der Query: ".$conn->error."<br>".$sql);
				}
				else {
					header("Location: errors/db_query.php?error=".$conn->error);
				}
			}
			
			while($ma = $maliste->fetch_object()) {
				echo('
					<li>
						' . $ma->Nachname . ' ' . $ma->Vorname . ':
						<ul>
				');
				
				// ---- Einsätze je Mitarbeiter: ----
				$arr = ["FIDMitarbeiter=" . $ma->IDMitarbeiter];
				
				if(count($_POST)>0) {
					if(strlen($_POST["NNKd"])>0) {
						$arr[] = "Nachname='" . $_POST["NNKd"] . "'";
					}
					if(strlen($_POST["VNKd"])>0) {
						$arr[] = "Vorname='" . $_POST["VNKd"] . "'";
					}
				}
				
				$sql = "
					SELECT
						tbl_einsatz.*,
						tbl_kunden.Nachname,
						tbl_kunden.Vorname
					FROM tbl_einsatz
					LEFT JOIN tbl_kunden ON tbl_einsatz.FIDKunde=tbl_kunden.IDKunde
					WHERE(
						" . implode(" AND ",$arr) . "
					)
					ORDER BY tbl_einsatz.Startzeitpunkt ASC
				";
				ta($sql);
				$einsaetze = $conn->query($sql);
				if($einsaetze===false) {
					if(TESTMODUS) {
						die("Fehler in der Query: ".$conn->error."<br>".$sql);
					}
					else {
						header("Location: errors/db_query.php?error=".$conn->error);
					}
				}
				
				while($einsatz = $einsaetze->fetch_object()) {
					echo('
						<li>' . $einsatz->Nachname . ' ' . $einsatz->Vorname . ': ' . $einsatz->Startzeitpunkt . ' bis ' . $einsatz->Endzeitpunkt . '</li>
					');
				}
				// ----------------------------------
				
				echo('
						</ul>
					</li>
				');
			}
			?>
		</ul>
	</body>
</html>