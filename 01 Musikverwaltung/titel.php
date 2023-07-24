<?php
require("includes/common.inc.php");
require("includes/conn.inc.php");

ta($_POST);
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
				<li><a href="alben.php">zu den Alben</a></li>
				<li><a href="interpreten.php">zu den Interpreten</a></li>
			</ul>
		</nav>
		
		<search>
			<form method="post">
				<label>
					Bitte geben Sie den gesuchten Songtitel ein:
					<input type="search" name="Songtitel">
				</label>
				<input type="submit" value="filtern">
			</form>
		</search>
		
		<ul>
			<?php
			/* keine Suche:
				SELECT
					tbl_songs.Songtitel,
					tbl_alben.Albumtitel,
					tbl_alben.Erscheinungsjahr,
					tbl_interpreten.Interpret
				FROM tbl_songs
				INNER JOIN tbl_alben ON tbl_alben.IDAlbum=tbl_songs.FIDAlbum
				INNER JOIN tbl_interpreten ON tbl_interpreten.IDInterpret=tbl_alben.FIDInterpret
				ORDER BY tbl_songs.Songtitel ASC, tbl_alben.Albumtitel ASC, tbl_interpreten.Interpret ASC
			*/
			
			/* mit Suche:
				SELECT
					tbl_songs.Songtitel,
					tbl_alben.Albumtitel,
					tbl_alben.Erscheinungsjahr,
					tbl_interpreten.Interpret
				FROM tbl_songs
				INNER JOIN tbl_alben ON tbl_alben.IDAlbum=tbl_songs.FIDAlbum
				INNER JOIN tbl_interpreten ON tbl_interpreten.IDInterpret=tbl_alben.FIDInterpret
				WHERE(
					tbl_songs.Songtitel LIKE 'S%'
				)
				ORDER BY tbl_songs.Songtitel ASC, tbl_alben.Albumtitel ASC, tbl_interpreten.Interpret ASC
			*/
			
			$sql = "
				SELECT
					tbl_songs.Songtitel,
					tbl_alben.Albumtitel,
					tbl_alben.Erscheinungsjahr,
					tbl_interpreten.Interpret
				FROM tbl_songs
				INNER JOIN tbl_alben ON tbl_alben.IDAlbum=tbl_songs.FIDAlbum
				INNER JOIN tbl_interpreten ON tbl_interpreten.IDInterpret=tbl_alben.FIDInterpret
			";
			
			if(count($_POST)>0 && strlen($_POST["Songtitel"])>0) {
				$sql = $sql . "
					WHERE(
						tbl_songs.Songtitel LIKE '" . $_POST["Songtitel"] . "%'
					)
				";
			}

			$sql = $sql . "
				ORDER BY tbl_songs.Songtitel ASC, tbl_alben.Albumtitel ASC, tbl_interpreten.Interpret ASC
			";
			
			$songs = $conn->query($sql) or die("Fehler in der Query: " . $conn->error . "<br>" . $sql);
			while($song = $songs->fetch_object()) {
				echo('
					<li>' . $song->Songtitel . ' aus dem Album ' . $song->Albumtitel . ' (' . $song->Erscheinungsjahr . ') von ' . $song->Interpret . '</li>
				');
			}
			?>
		</ul>
	</body>
</html>