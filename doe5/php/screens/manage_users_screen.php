<html>
    <head>
        <meta charset="UTF-8">
        <title>Doe em 5</title>
        <link rel="stylesheet" href="../../assets/styles/modules/header.css">
        <link rel="stylesheet" href="../../assets/styles/screens/ban_screen.css">
        <style>
            #main{
                height: max-content;
                padding: 10vh 5vw 5vh 5vw;
            }
        </style>
    </head>

    <body>
        <header>
            <a id="voltar" aria-label="Voltar para página anterior" href="admin_screen.php">
                <img src="../../assets/imgs/voltar.svg" alt="Voltar">
                <h1>Voltar</h1>
            </a>
        </header>
        
        <section id="main">

            <h2>Usuários</h2>
            <!-- Barra de pesquisa -->
            <form id='form-search' method="GET" action="" name="form">
                <input placeholder='Insira o email do usuário' id='barra-pesquisa' type="search" name="emailPes" id="emailPes">
                <button id='btn-search' title='Pesquisar' type='submit' value='Pesquisar'><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M416 208c0 45.9-14.9 88.3-40 122.7L502.6 457.4c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L330.7 376c-34.4 25.2-76.8 40-122.7 40C93.1 416 0 322.9 0 208S93.1 0 208 0S416 93.1 416 208zM208 352c79.5 0 144-64.5 144-144s-64.5-144-144-144S64 128.5 64 208s64.5 144 144 144z"/></svg></button>
            </form>

        </body>
        
        <?php

        include('../src/conn.php');
        include('../src/session_start.php');

        // Email do usuário que será pesquisado
        $emailPes= isset($_GET['emailPes']) ? $_GET['emailPes'] : "";

        //Select dos usuários com email parecido com $emailPes
        $sql    = "SELECT * FROM TBUsuario WHERE email LIKE '".$emailPes."%'
                    AND id NOT IN (SELECT idAdmin FROM TBAdministrador);";
        $result = $conn->query($sql);

        //Print do BD
        if($result->num_rows > 0){
            echo "<table id='ban-table'>
            <tr class='table-header'>
                <th>ID</th>
                <th>Nome</th>    
                <th>Email</th>    
                <th>Opções</th>    
            </tr>";
            
            while($row = $result->fetch_assoc()){
                
                echo "
                <tr>
                    <td id='id'>"
                    .$row['id'].
                    "</td>
                    <td>"
                    .$row['nome'].
                    "</td>
                    <td>"
                    .$row['email'].
                    "</td>
                    <td>
                        <a href='./profile_page.php?id=".$row['id']."'>Detalhes</a>
                    </td>
                </tr>
                ";
            }
            echo "</table>";
        } else {
            echo "<section><br><h3 id='not-found-message'>Nenhum resutado encontrado</h3></section>";
        }

        ?>
    </section>
</html>