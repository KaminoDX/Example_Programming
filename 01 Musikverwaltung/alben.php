<?php
require("includes/common.inc.php");
require("includes/conn.inc.php");

?>
<!doctype html>
<html lang="de"
	<head>
		<title>Musikverwaltung</title>
		<meta charset="utf-8">
		<link rel="stylesheet" href="css/common.css">
	</head>
	<body>
		<h1>Musikverwaltung</h1>
		<nav>
			<ul>
				<li><a href="index.html">zurück zur Übersicht</a></li>
				<li><a href="interpreten.php">zu den Interpreten</a></li>
				<li><a href="titel.php">zu den Songs</a></li>
			</ul>
		</nav>
		
		<ul>
			<?php
			$sql = "
				SELECT
					tbl_alben.IDAlbum,
					tbl_alben.Albumtitel,
					tbl_alben.Erscheinungsjahr,
					tbl_interpreten.Interpret
				FROM tbl_alben
				INNER JOIN tbl_interpreten ON tbl_interpreten.IDInterpret=tbl_alben.FIDInterpret
				ORDER BY tbl_alben.Erscheinungsjahr DESC
			";
			$alben = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			//ta($alben); //"debuggen": Inhalt des Objektes $alben am Bildschirm ausgeben
			while($album = $alben->fetch_object()) {
				//ta($album);
				echo('
					<li>"' . $album->Albumtitel . '" von ' . $album->Interpret . ' (' . $album->Erscheinungsjahr . '):
						<ul>
				');
				
				// ---- Songs je Album: ----
				$sql = "
					SELECT
						Songtitel
					FROM tbl_songs
					WHERE(
						FIDAlbum=" . $album->IDAlbum . "
					)
					ORDER BY Reihenfolge ASC
				";
				//ta($sql);
				$songs = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
				while($song = $songs->fetch_object()) {
					echo('
						<li>' . $song->Songtitel . '</li>
					');
				}
				// -------------------------
				
				echo('
						</ul>
					</li>
				');
			}
			?>
		</ul>
	</body>
</html>