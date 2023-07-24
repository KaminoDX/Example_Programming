<?php
define("TESTMODUS",true); //Testmodus: gibt an, ob wir in der Development- (true) oder der Live-Phase (false) sind

define("DB",[
	"host" => "localhost",
	"user" => "root",
	"pwd" => "",
	"name" => "db_lap_registrierung"
]);

if(TESTMODUS) {
	error_reporting(E_ALL);
	ini_set("display_errors",1);
}
else {
	error_reporting(0);
	ini_set("display_errors",0);
}
?>