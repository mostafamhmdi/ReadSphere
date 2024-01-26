<?php
header('Content-Type: application/json');
include "./db.php";

if (isset($_GET['genre'])) {
    $genre = $_GET['genre'];

    $stmt = $db->prepare("SELECT * FROM book WHERE genres = :genre");
    $stmt->bindParam(':genre', $genre);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($result);
} else {
    echo json_encode(['error' => 'Genre parameter is missing']);
}
?>
