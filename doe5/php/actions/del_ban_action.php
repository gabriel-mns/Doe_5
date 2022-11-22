<?php
    include('../src/conn.php');
    session_start();

    //Dados do usuário que vai ter o registro de banimento deletado
    $date     = isset($_GET['date'])? $_GET['date'] : "0000-01-01";
    $emailAdd = isset($_GET['emailAdd'])? $_GET['emailAdd'] : "";
    $admin    = isset($_GET['idAdmin'])? $_GET['idAdmin'] : 1;
    $search   = $conn->query("SELECT U.id, U.email, B.dataHoraBanimento, B.dataHoraUnban, B.idAdmin FROM TBUsuario U INNER JOIN TBBanimento B ON U.id = B.idUsuario WHERE email = '".$emailAdd."';");
    
    if(isset($_GET['deleteId'])){
        $deleteId = $_GET['deleteId'];
        $deleteDataHoraBan = $_GET['deleteDataHoraBan'];
        $sqlDelete = "DELETE FROM tbbanimento WHERE dataHoraBanimento = '".$deleteDataHoraBan."' AND idUsuario = ".$deleteId;
        $action = $conn->query($sqlDelete);

        if($action){
            echo "<h1><span id='success'>Sucesso!</span><br>Registro de banimento apagado</h1>";
        } else{
            echo "<h1><span id='unsuccess'>Erro!</span><br>Não foi possível apagar registro de banimento " . $conn->error . "</h1> " . $conn->error;
        }

    }
?>

<html>
    <head>
        <title>Doe em 5</title>
        <link rel="stylesheet" href="../../assets/styles/screens/reg_donator_result.css">
    </head>
    <body>
        <br>
        <a id="return-login" href="../screens/ban_screen.php">Voltar</a>    
    </body>
</html>