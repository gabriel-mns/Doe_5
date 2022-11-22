<?php
    include('../src/conn.php');
    include('../src/session_start.php');
    
    $item1Tipo = $_GET['tipo-0'];
    $item1Qtd = $_GET['qtd-0'];

    $sql1 = "
    INSERT INTO TBDoacao 
    VALUES (
        ".$_SESSION['idUsuario'].",
        ".$item1Tipo.",
        3,
        11,
        ".$item1Qtd.",
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        true
    );
        
    
    ";
    
    $result1 = $conn->query($sql1);
    
    
    if(isset($_GET['tipo-1']) AND isset($_GET['qtd-1']))  {
        $item2Tipo = $_GET['tipo-1'];
        $item2Qtd = $_GET['qtd-1'];
        
        $sql2 = "
        INSERT INTO TBDoacao 
        VALUES (
            ".$_SESSION['idUsuario'].",
            ".$item2Tipo.",
            3,
            11,
            ".$item2Qtd.",
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            true
        );";
        
        $result2 = $conn->query($sql2);
        
    }      
    
    
    
    if(isset($_GET['tipo-2']) AND isset($_GET['qtd-2']))  {
        
        $item3Tipo = $_GET['tipo-2'];
        $item3Qtd = $_GET['qtd-2'];
            
            
            
            
            $sql3 = "
            INSERT INTO TBDoacao 
            VALUES (
                ".$_SESSION['idUsuario'].",
                ".$item3Tipo.",
                3,
                11,
                ".$item3Qtd.",
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                true
            );
            
            
            ";
            
            $result3 = $conn->query($sql3);
            
        }
        
        if(!$result1){
            echo "<h1><span id='unsuccess'>Erro!</span><br>Não foi possível cadastrar doação: " . $conn->error . "</h1>";
        } else {
            echo "<h1><span id='success'>Sucesso!</span><br>Doação cadastrada</h1>";
        }
    
    ?>

<html>
    <head>
        <title>Doe em 5</title>
        <link rel="stylesheet" href="../../assets/styles/screens/reg_donator_result.css">
    </head>
    <body>
        <br>
        <a id="return-login" href="../screens/donations_screen.php">Retornar para doações</a>
    </body>
</html>