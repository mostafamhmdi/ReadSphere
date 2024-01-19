<?php
header('Content-Type: application/json');
include "./db.php";

$image = $_POST['image'];
$name = $_POST['name'];
$description = $_POST['description'];
$author = $_POST['author'];
$price = $_POST['price'];
$genre = $_POST['genre'];

$stmt = $db->prepare("INSERT INTO book (image, name, description, author, price,genre) VALUES (?, ?, ?, ?, ?,?");
$result = $stmt->execute([$image, $name, $description, $author, $price,$genre]);

echo json_encode([
    'success' => $result
]);

?>
