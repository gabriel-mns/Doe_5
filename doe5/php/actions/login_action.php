<?php
include("../src/conn.php");
session_start();

//Login e senha inseridos pelo usuário
$login = isset($_GET["login"]) ? $_GET["login"]: "";
$senha = isset($_GET["senha"]) ? $_GET["senha"]: "";

// Select dos dados para verificação de login e tipo de conta (adm, doador)
$sql    = "SELECT U.id, U.email, U.senha, A.idAdmin FROM TBUsuario U LEFT JOIN TBAdministrador A ON A.idAdmin = U.id;";
$result = $conn->query($sql);

if($result->num_rows > 0){
    while($row = $result->fetch_assoc()){
        // Se login e senha baterem
        if($row['email'] == $login && $row['senha'] == $senha){

            $_SESSION['idUsuario'] = $row['id'];

            // Se usuário é administrador
            if(!is_null($row['idAdmin'])){
                // Leva para tela de admin
                header("Location: ../screens/admin_screen.php");
                exit();
                break;
            }
            
            // Leva para tela de doador
            header("Location: ../screens/donations_screen.php");
            exit();
            break;
        }
    }
}

?>

<html>
    <head>
        <title>Doe em 5</title>
        <link rel="stylesheet" href="../../assets/styles/screens/reg_donator_result.css">
    </head>
    <body>
        <h1>
            <span id='unsuccess'>Erro!</span>
            <br>
            Email ou senha inválidos
        <br>
        <a id="return-login" href="../../index.php">Voltar</a>    
    </body>
</html>