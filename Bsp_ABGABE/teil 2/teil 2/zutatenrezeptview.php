<?php
require("includes/common.inc.php");
require("includes/config.inc.php");
require("includes/conn.inc.php");

$filter = "";
if (count($_POST) > 0) {
	if (isset($_POST["zutatenSelect"])) {
		if ($_POST["zutatenSelect"] > 0) {
			$filter = "WHERE rz.FIDZutat = {$_POST["zutatenSelect"]}";
		}
	}
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="css/common.css">
	<title>Zutaten und Rezepte</title>
</head>

<body>
	<nav>
		<ul>
			<li><a href="index.php">Startseite</a></li>
			<li><a href="rezeptview.php">Rezeptübersicht</a></li>
			<li><a href="userrezeptview.php">Rezeptübersicht per User</a></li>
			<li><a href="zutatenrezeptview.php">Zutaten und Rezepte</a></li>
		</ul>
	</nav>

	<main>
		<h1>Zutaten und Rezepte</h1>
		<form method="POST">
			<select name="zutatenSelect">
				<?php
				$sql = "
				SELECT
					*
				FROM tbl_zutaten
			";
				$ingredientsQuery = $conn->query($sql) or die("Fehler in der Query: {$sql}");
				$ingredientsResult = $ingredientsQuery->fetchAll();

				echo ("<option value='0' selected>Bitte wählen/Leer</option>");
				foreach ($ingredientsResult as $ingredient) {
					echo ("
					<option value='{$ingredient["IDZutat"]}'>{$ingredient["Bezeichnung"]}</option>
				");
				}
				?>
			</select>
			<input type="submit" name="filtern" value="filtern">
		</form>
		<?php
		$sql = "
			SELECT
				r.Titel,
				r.AnzahlPersonen,
				r.Beschreibung,
				CONCAT(u.Vorname, ' ', u.Nachname) as username
			FROM tbl_rezepte_zutaten as rz
			INNER JOIN tbl_rezepte as r ON rz.FIDRezept = r.IDRezept
			INNER JOIN tbl_user as u ON r.FIDUser = u.IDUser
			{$filter}
			GROUP BY r.IDRezept
			ORDER BY r.Titel ASC
		";
		$rezeptQuery = $conn->query($sql) or die("Fehler in der Query: {$sql}");
		$rezeptResult = $rezeptQuery->fetchAll();

		if (empty($rezeptResult)) {
			echo ("<p>Kein Rezept mit dieser Zutat vorhanden</p>");
		}

		echo ("<ul>");
		foreach ($rezeptResult as $rezept) {
			// $beschreibung = !empty($rezept["Beschreibung"]) ? $rezept["Beschreibung"] : "";
			$beschreibung =  $rezept["Beschreibung"] ?? "";
			echo ("
				<li>
				<p>{$rezept["Titel"]} (von {$rezept["username"]} für {$rezept["AnzahlPersonen"]} Personen)</p>
				<p>{$beschreibung}</p>
				</li>
			");
		}
		echo ("</ul>");
		?>
	</main>
</body>

</html>