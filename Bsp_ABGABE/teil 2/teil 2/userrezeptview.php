<?php
require("includes/common.inc.php");
require("includes/config.inc.php");
require("includes/conn.inc.php");

$vornameFilter = "";
$nachnameFilter = "";

if (count($_POST) > 0) {
	$vornameFilter = $_POST["vorname"] ?? "";
	$nachnameFilter = $_POST["nachname"] ?? "";
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="css/common.css">
	<title>User Rezeptübersicht</title>
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
		<h1>User Rezepte Übersicht</h1>
		<form method="POST">
			<input type="text" name="vorname" placeholder="Vorname" value="<?php echo $vornameFilter ?>">
			<input type="text" name="nachname" placeholder="Nachname" value="<?php echo $nachnameFilter ?>">
			<input type="submit">
		</form>
		<ul>
			<?php
			$sql = "
				SELECT
					r.Titel,
					r.Beschreibung,
					CONCAT(u.Vorname, ' ', u.Nachname) as username,
					u.Emailadresse as mail
				FROM tbl_rezepte as r
				INNER JOIN tbl_user as u ON r.FIDUser = u.IDUser
				WHERE u.Vorname LIKE '%{$vornameFilter}%'
				AND u.Nachname LIKE '%{$nachnameFilter}%'
				ORDER BY u.Nachname, u.Vorname
			";
			$rezeptQuery = $conn->query($sql) or die("Fehler in der Query: {$sql}");
			$rezeptResult = $rezeptQuery->fetchAll();

			foreach ($rezeptResult as $rezept) {
				$beschreibung =  $rezept["Beschreibung"] ?? "Keine Beschreibung";
				echo ("
					<li>
						<p>{$rezept["username"]} ({$rezept["mail"]}):</p>
						<p>{$rezept["Titel"]}: {$beschreibung}</p>
					</li>
				");
			}
			?>
		</ul>
	</main>
</body>

</html>