<?php
    include('../src/conn.php');
    session_start();

    // Data-hora atual
    date_default_timezone_set('America/Sao_Paulo');
    $dateToday = date('Y-m-d h:i:s', time());

    //ID do usuário que vai ser banido
    $unBanId = $_GET['unBanId'];
    
    //Data de BANIMENTO
    $date = $_GET['dateBan'];
    
    //ID do admin que BANIU o usuário a ser desbanido
    $admin = $_GET['adminBan'];
    
    // UPDATE da data de desbanimento do usuário para a data e hora de agora
    $sqlAlter= "UPDATE TBBanimento 
                SET dataHoraUnban ='".$dateToday."'
                WHERE idUsuario = ".$unBanId." AND dataHoraBanimento = '".$date."' AND idAdmin =".$admin;
    $action = $conn->query($sqlAlter);
    
    if($action){
        echo "<h1><span id='success'>Sucesso!</span><br>Usuário recebeu unban</h1>";
    } else{
        echo "<h1><span id='unsuccess'>Erro!</span><br>Não foi possível realizar operação</h1>" . $conn->error;
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