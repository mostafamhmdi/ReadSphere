<?php

$db_name = "competent_sammet";
$db_server = "book:3306";
$db_user = "root";
$db_pass = "z3QRn4aQFJDLV8cKhMwvAzTS";

$db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

?>