<?php
require("includes/config.inc.php");
require("includes/common.inc.php");
require("includes/conn.inc.php");

ta($_POST);
if(count($_POST)==0) {
	$_POST["VN"] = "";
	$_POST["NN"] = "";
}
?>
<!doctype html>
<html lang="de">
	<head>
		<title>Schule</title>
		<meta charset="utf-8">
		<link rel="stylesheet" href="css/common.css">
	</head>
	<body>
		<h1>Schüler</h1>
		<nav>
			<ul>
				<li><a href="index.html">zurück zur Übersicht</a></li>
				<li><a href="klassen.php">Klassen</a></li>
				<li><a href="raeume.php">Räume</a></li>
			</ul>
		</nav>
		<form method="post">
			<label>
				Nachname:
				<input type="text" name="NN" value="<?php echo($_POST["NN"]); ?>">
			</label>
			<label>
				Vorname:
				<input type="text" name="VN" value="<?php echo($_POST["VN"]); ?>">
			</label>
			<input type="submit" value="filtern">
		</form>
		<ul>
			<?php
			/*
			Fall 1: kein Filter
			$sql = "
				SELECT
					Vorname,
					Nachname
				FROM tbl_schueler
				ORDER BY Nachname ASC, Vorname ASC
			";
			
			Fall 2: Filter nach Nachname (zB. "Mair")
			$sql = "
				SELECT
					Vorname,
					Nachname
				FROM tbl_schueler
				WHERE(
					Nachname LIKE '%Mair%'
				)
				ORDER BY Nachname ASC, Vorname ASC
			";
			
			Fall 3: Filter nach Vorname (zB. "Thomas")
			$sql = "
				SELECT
					Vorname,
					Nachname
				FROM tbl_schueler
				WHERE(
					Vorname LIKE '%Thomas%'
				)
				ORDER BY Nachname ASC, Vorname ASC
			";
			
			Fall 4: Filter nach Nach- und Vorname (zB. "Mair Thomas")
			$sql = "
				SELECT
					Vorname,
					Nachname
				FROM tbl_schueler
				WHERE(
					Nachname LIKE '%Mair%' AND
					Vorname LIKE '%Thomas%'
				)
				ORDER BY Nachname ASC, Vorname ASC
			";
			*/
			
			$arr = [];
			if(count($_POST)>0) {
				if(strlen($_POST["NN"])>0) {
					$arr[] = "Nachname LIKE '%" . $_POST["NN"] . "%'";
				}
				if(strlen($_POST["VN"])>0) {
					$arr[] = "Vorname LIKE '%" . $_POST["VN"] . "%'";
				}
			}
			ta($arr);
			if(count($arr)>0) {
				//der User möchte nach irgendetwas filtern
				$where = "
					WHERE(
						" . implode(" AND ",$arr) . "
					)
				";
			}
			else {
				$where = "";
			}
				
			
			$sql = "
				SELECT
					Vorname,
					Nachname
				FROM tbl_schueler
				" . $where . "
				ORDER BY Nachname ASC, Vorname ASC
			";
			ta($sql);
			
			$schuelerliste = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			while($schueler = $schuelerliste->fetch_object()) {
				echo('
					<li>' . $schueler->Nachname . ' ' . $schueler->Vorname . '</li>
				');
			}
			?>
		</ul>
	</body>
</html>