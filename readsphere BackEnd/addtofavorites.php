<?php
header('Content-Type: application/json');
include "./db.php";

$book_id = (int)$_POST['book_id'];

$stmt = $db->prepare("SELECT * FROM favorite_books WHERE book_id = ?");
$stmt->execute([$book_id]);
$existingRecord = $stmt->fetch(PDO::FETCH_ASSOC);

if ($existingRecord) {
    echo json_encode(["message" => "Book is already in Favorites"]);
} else {
    $stmt = $db->prepare("INSERT INTO favorite_books (book_id) VALUES (?)");
    $result = $stmt->execute([$book_id]);

    if ($result) {
        echo json_encode(["message" => "Book added to Favorites successfully"]);
    } else {
        echo json_encode(["error" => "Error inserting book to Favorites"]);
    }
}

?>
