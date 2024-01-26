<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
      body {
        background: skyblue
      }
      h1{
        text-align: center
      }
    </style>
  </head>
  <body>
    <h1>Mostafa mohammadi</h1>
    <div id="dataContainer"></div>
  </body>
    <?php
      include "./db.php";
      
      try{

        $stmt = $db->prepare("SELECT name , author,genres FROM book");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        echo json_encode($result);
      }catch (Exception $e) {
        echo $e->getMessage();
      }
    ?>

</html>
