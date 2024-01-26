<?php
header('Content-Type: application/json');
include "./db.php";

if (isset($_GET['name'])) {
    $name = $_GET['name'];

    $stmt = $db->prepare("SELECT * FROM book WHERE name = :name");
    $stmt->bindParam(':name', $name);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($result);
} else {
    echo json_encode(['error' => 'name parameter is missing']);
}
?>
