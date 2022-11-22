<?php
    include('../src/conn.php');
    session_start();

    //Data-hora atual
    date_default_timezone_set('America/Sao_Paulo');
    $date = date('Y-m-d h:i:s', time());

    //Motivo pelo qual o usuário foi banido
    $reason= isset($_GET['reason'])? $_GET['reason'] : "";

    //ID da pessoa que está sendo banida
    $idPes = $_GET['idUser'];
    
    //Script da inserção do usuário na tabela de banidos
    $sqlAdd= "INSERT INTO TBBanimento VALUES('".$reason."','".$idPes."','".$_SESSION['idUsuario']."','".$date."', NULL)";

    //Inserção do usuário na tabela de banidos se email e motivo não forem vazios
    if($conn->query($sqlAdd) === TRUE){
        echo "<h1><span id='success'>Sucesso!</span><br>Usuário banido</h1>";
    } else{
        echo "<h1><span id='unsuccess'>Erro!</span><br>Não foi possível banir usuário " . $conn->error . "</h1> " . $conn->error;
    }

?>

<html>
    <head>
        <title>Doe em 5</title>
        <link rel="stylesheet" href="../../assets/styles/screens/reg_donator_result.css">
    </head>
    <body>
        <br>
        <a id="return-login" href="../screens/manage_users_screen.php">Voltar</a>    
    </body>
</html>