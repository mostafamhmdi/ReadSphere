<?php
header('Content-Type: application/json');
include "./db.php";

$stmt = $db->prepare("SELECT * FROM book");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>