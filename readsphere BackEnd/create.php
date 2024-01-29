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

$stmt = $db->prepare("INSERT INTO book (name, author, rating, description, genres, price, book_path) VALUES (?, ?, ?, ?, ?, ?, ?)");
$result = $stmt->execute([$name, $author, $rating, $description, $genres, $price, $book_path]);

echo json_encode([
    'success' => $result
]);
?>
