<?php
    include('./php/src/conn.php');
    session_start();
    $_SESSION['Versao'] = 1;

    //Dados de login
    $login = isset($_GET["login"]) ? $_GET["login"] : "";
    $senha = isset($_GET["senha"]) ? $_GET["senha"]: "";

?>
<html>
    <head>
        <meta charset="utf-8">
        <title>Doe em 5</title>
        <link rel="stylesheet" href="./assets/styles/screens/login.css">
        <link rel="stylesheet" href="./assets/styles/modules/header.css">
    </head>
    <body>
        <header>
            <a id="voltar"href="#">
                <img src="./assets/imgs/voltar.svg" alt="Voltar">
                <h1>Voltar</h1>
            </a>
        </header>

        <main>
            <div id="esquerda">
                <a href="#"><img src="./assets/imgs/logo_doe5.svg" alt="Logo da doe em 5"></a>
            </div>
    
            <div id="direita">
                <!-- Formulário de login/senha -->
                <form id="form-login" action="./php/actions/login_action.php" method="get">
                    
                    <h2>LOGIN</h2>
                
                    <div class="form-login-input">
                        <h4>Email: <span>*</span></h4>
                        <input required placeholder="exemplo@gmail.com" type="email" name="login" value="<?=$login?>">
                    </div>
                    <div class="form-login-input">
                        <h4>Senha: <span> * </span></h4>
                        <input required placeholder="doe_5@" type="password" name="senha" value="<?=$senha?>">    
                    </div>
                    <div id="div-entrar">
                        <input id="entrar" type="submit" value="entrar">
                    </div>
                    <div id="div-options">
                        <a class='second-option' href="./php/screens/donator_reg_screen.php">Cadastrar-se</a>
                        <a class='second-option' href="#">Esqueceu a senha?</a>
                    </div>
                </form>
            </div>
        </main>
    </body>
</html>