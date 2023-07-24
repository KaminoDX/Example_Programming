<?php
$conn = new MySQLi("localhost","root","","db_3443_musikverwaltung");
if($conn->connect_errno>0) {
	//es ist (irgendein) Fehler während des Versuches, eine Verbindung zum DB-Server herzustellen oder die DB auszuwählen, aufgetreten
	//Praxis: header("Location: errors/db_connect.html"); //Weiterleitung auf eine Fehlerseite (die wir nicht haben)
	die("Fehler im Verbindungsaufbau: " . $conn->connect_error);
}
$conn->set_charset("UTF8");
?>