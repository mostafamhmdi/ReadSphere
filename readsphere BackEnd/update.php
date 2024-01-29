<?php
header('Content-Type: application/json');
include "./db.php";

$name = $_POST['name'];
$author = $_POST['author'];
$rating = $_POST['rating'];
$description = $_POST['description'];
$genres = $_POST['genres'];
$price = $_POST['price'];
$book_path = $_POST['book_path'];
$id = $_POST['id']; 

$stmtCheck = $db->prepare("SELECT * FROM book WHERE id = ?");
$stmtCheck->execute([$id]);
$existingBook = $stmtCheck->fetch();

if ($existingBook) {
    $stmt = $db->prepare("UPDATE book SET book_path = ?, name = ?, description = ?, author = ?, price = ?, genres = ?, rating = ? WHERE id = ?");
    $result = $stmt->execute([$book_path, $name, $description, $author, $price, $genres, $rating, $id]); // Fix the order and remove the extra comma
} else {
    $stmt = $db->prepare("INSERT INTO book (name, author, rating, description, genres, price, book_path) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $result = $stmt->execute([$name, $author, $rating, $description, $genres, $price, $book_path]);
}

echo json_encode([
    'success' => $result
]);
?>
