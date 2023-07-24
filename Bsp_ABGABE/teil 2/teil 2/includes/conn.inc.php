<?php
$dns = 'mysql:host=' . DB["host"] . ';dbname=' . DB["name"];
$conn = new PDO($dns, DB["user"], DB["pwd"]);

$conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_SILENT);
