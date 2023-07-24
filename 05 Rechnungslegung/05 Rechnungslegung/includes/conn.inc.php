<?php
// ---- Schritt 1: Verbindung herstellen: ----
$conn = new MySQLi(DB["host"],DB["user"],DB["pwd"],DB["name"]); //versucht, eine Verbindung zu einem Datenbankserver herzustellen und eine Datenbank auf diesem Server auszuwählen. Dazu werden Host-Adresse (localhost), Username (root) und Passwort (leer) benötigt. Danach brauchen wir noch den Namen der Datenbank.
if($conn->connect_errno>0) {
	if(TESTMODUS) {
		die("Fehler im Verbindungsaufbau: " . $conn->connect_error);
	}
	else {
		//Praxis/Realbetrieb:
		header("Location: errors/db_connect.html");
	}
}
$conn->set_charset("utf8mb4");
// ENDE Schritt 1: Verbindung herstellen: ----
?>