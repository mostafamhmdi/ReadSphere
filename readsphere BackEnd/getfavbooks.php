<?php
header('Content-Type: application/json');
include "./db.php";

$stmt = $db->prepare("SELECT * FROM book JOIN favorite_books ON favorite_books.book_id = book.id");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>
