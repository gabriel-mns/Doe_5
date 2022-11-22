<html>

    <head>
        <title>Doe 5</title>
        <link rel="stylesheet" href="../../assets/styles/modules/header.css">
        <link rel="stylesheet" href="../../assets/styles/screens/ban_screen.css">
    </head>

    <header>
        <a id="voltar" aria-label="Voltar para página anterior" href="admin_screen.php">
            <img src="../../assets/imgs/voltar.svg" alt="Voltar">
            <h1>Voltar</h1>
        </a>
    </header>
    <section id="main">
        <!--Barra de PESQUISA de usuários BANIDOS - Lista de banidos -->
        <h2>Usuários banidos</h2>
        <form id='form-search' name='search' action='' method='get'>
            <input id='barra-pesquisa' aria-label='Caixa de texto para email do usuário' placeholder="Insira o email do usuário" name='email' type='searchbar'>
            <button id='btn-search' title='Pesquisar' type='submit' value='Pesquisar'><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M416 208c0 45.9-14.9 88.3-40 122.7L502.6 457.4c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L330.7 376c-34.4 25.2-76.8 40-122.7 40C93.1 416 0 322.9 0 208S93.1 0 208 0S416 93.1 416 208zM208 352c79.5 0 144-64.5 144-144s-64.5-144-144-144S64 128.5 64 208s64.5 144 144 144z"/></svg></button>
        </form>
        
        <?php
        //Conexão com BD
        include('../src/conn.php');
        //Sessão iniciada
        session_start();
        
        //Email inserido na barra de pesquisa pelo usuário
        $email = isset($_GET['email'])? $_GET['email'] : "";
        
        /*
        Select dos registros de banimento com emails
        similares ao inserido pelo usuário
        */
        $sqlPes= 
        "SELECT 
                    DISTINCT B.idUsuario,
                    U.email,
                    B.idAdmin,
                    B.dataHoraBanimento,
                    B.motivo
                FROM
                    TBBanimento B
                    INNER JOIN TBUsuario U
                    ON B.idUsuario = U.id
                WHERE 
                    B.dataHoraUnban IS NULL
                    AND
                    U.email LIKE '".$email."%';";


    //Executa o código sql acima ↑
    $resultPes = $conn->query($sqlPes);

    //Print do resultado de resultPes
    if($resultPes->num_rows > 0){
        
        //Cabeçalho
        echo "
        <table id='ban-table'>
            <tr class='table-header'>
                <th>ID</th>
                <th>Email</th>
                <th>Motivo</th>
                <th>Admin</th>    
                <th>Data-hora banimento</th>    
                <th>Opções</th>     
            </tr>";
        
        //Print de cada linha da tabela    
            while($row = $resultPes->fetch_assoc()){
                echo "
                <tr>
                <td>".$row['idUsuario']        ."</td>
                <td>".$row['email']            ."</td>
                <td class='motivo'>".$row['motivo']           ."</td>
                <td>".$row['idAdmin']          ."</td>
                <td>".$row['dataHoraBanimento']."</td>
                <td>
                    <a title='Unban usuário' aria-label='Unban usuário' id='btn-unban' class='btn-option' href='../actions/unban_action.php?unBanId=".$row['idUsuario']."&&adminBan=".$row['idAdmin']."&&dateBan=".$row['dataHoraBanimento']."'><svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 448 512'><path d='M144 144c0-44.2 35.8-80 80-80c31.9 0 59.4 18.6 72.3 45.7c7.6 16 26.7 22.8 42.6 15.2s22.8-26.7 15.2-42.6C331 33.7 281.5 0 224 0C144.5 0 80 64.5 80 144v48H64c-35.3 0-64 28.7-64 64V448c0 35.3 28.7 64 64 64H384c35.3 0 64-28.7 64-64V256c0-35.3-28.7-64-64-64H144V144z'/></svg></a>
                    <a title='Apagar registro' aria-label='Apagar registro' id='btn-delban' class='btn-option' href='../actions/del_ban_action.php?deleteId=".$row['idUsuario']."&&"."deleteDataHoraBan=".$row['dataHoraBanimento']."'><svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 576 512'><path d='M290.7 57.4L57.4 290.7c-25 25-25 65.5 0 90.5l80 80c12 12 28.3 18.7 45.3 18.7H288h9.4H512c17.7 0 32-14.3 32-32s-14.3-32-32-32H387.9L518.6 285.3c25-25 25-65.5 0-90.5L381.3 57.4c-25-25-65.5-25-90.5 0zM297.4 416H288l-105.4 0-80-80L227.3 211.3 364.7 348.7 297.4 416z'/></svg></a>
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