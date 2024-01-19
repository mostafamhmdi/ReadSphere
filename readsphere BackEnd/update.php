<?php
header('Content-Type: application/json');
include "./db.php";

$id = $_POST['id'];
$image = $_POST['image'];
$name = $_POST['name'];
$description = $_POST['description'];
$author = $_POST['author'];
$price = $_POST['price'];
$genre = $_POST['genre'];

$stmtCheck = $db->prepare("SELECT * FROM book WHERE id = ?");
$stmtCheck->execute([$id]);
$existingBook = $stmtCheck->fetch();

if ($existingBook) {
    $stmt = $db->prepare("UPDATE book SET image = ?, name = ?, description = ?, author = ?, price = ? , genre = ? WHERE id = ?");
    $result = $stmt->execute([$image, $name, $description, $author, $price,$genre, $id]);
} else {
    $stmt = $db->prepare("INSERT INTO book (image, name, description, author, price,genre) VALUES (?, ?, ?, ?, ?,?)");
    $result = $stmt->execute([$image, $name, $description, $author, $price,$genre]);
}

echo json_encode([
    'success' => $result
]);

?>
