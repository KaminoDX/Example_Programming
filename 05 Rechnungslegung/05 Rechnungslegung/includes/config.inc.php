<?php
define("TESTMODUS",true);
define("DB",[
	"host" => "localhost",
	"user" => "root",
	"pwd" => "",
	"name" => "db_rechnungslegung"
]);

if(TESTMODUS) {
	error_reporting(E_ALL); //sämtliche Fehler werden protokolliert
	ini_set("display_errors",1); //zeigt die auftretenden und zu protokollierenden Fehler auch tatsächlich an
}
else {
	error_reporting(0);
	ini_set("display_errors",0);
}
?>