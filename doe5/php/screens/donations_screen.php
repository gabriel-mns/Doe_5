<html>
    <head>
        <title>Doe 5</title>
        <link rel="stylesheet" href="../../assets/styles/screens/login.css">
        <link rel="stylesheet" href="../../assets/styles/screens/don.css">
        <link rel="stylesheet" href="../../assets/styles/modules/header.css">
        <!-- <link rel="stylesheet" href="./assets/ban.css"> -->
    </head>
    <body>
        <header>
            <a id="voltar" href="../../index.php">
                <img src="../../assets/imgs/voltar.svg" alt="Voltar">
                <h1>Voltar</h1>
            </a>
        </header>
        
        <!-- Barra de pesquisa de doações realizadas -->
        <section>
            <h2>Doações</h2>
            <form id='form-search' name='search' action='' method='get'>
                <input id='barra-pesquisa' name='instituicao' placeholder='Insira o nome da instituição' autocomplete='off' type='searchbar'>
                <button id='btn-search' type='submit' value='' aria-label='Pesquisar'><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M416 208c0 45.9-14.9 88.3-40 122.7L502.6 457.4c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L330.7 376c-34.4 25.2-76.8 40-122.7 40C93.1 416 0 322.9 0 208S93.1 0 208 0S416 93.1 416 208zM208 352c79.5 0 144-64.5 144-144s-64.5-144-144-144S64 128.5 64 208s64.5 144 144 144z"/></svg></button>
            </form>
        </section>
        <a id='add-new-donation' href="../screens/add_donations_screen.php">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><path d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"/></svg>
        </a>
    </body>
</html>
<?php
    include('../src/conn.php');
    session_start();    

    // Nome da instituição sendo procurada 
    $instituicao = isset($_GET['instituicao'])? $_GET['instituicao'] : "";

    $sqlPes= "SELECT 
                DISTINCT I.razaoSocial,
                D.idCentro,
                CC.nome 
              FROM 
                TBDoacao D
                INNER JOIN TBCentrocaptacao CC
                    ON D.idCentro = CC.id
                INNER JOIN TBInstituicao I
                    ON CC.idInstituicao = I.idInstituicao
              WHERE 
                    D.idDoador = ".$_SESSION['idUsuario'].
              "     AND
                    I.razaoSocial LIKE '".$instituicao."%'";
    
    // Resultado do select
    $resultPes = $conn->query($sqlPes);

    //Print do banco de dados
    if($resultPes->num_rows > 0){
        //Print do header da tabela
        echo "<section id='don-list'>";
    
        while($row = $resultPes->fetch_assoc()){
            $sqlPesitens= "SELECT 
                                I.tipo, 
                                D.idDoacao, 
                                D.idCentro,
                                I.id,
                                D.dataHoraCentroRecebeu
                            FROM 
                                TBDoacao D
                                INNER JOIN  
                                TBItemDoacao I
                                ON D.idDoacao=I.id
                            WHERE 
                                D.idDoador = ".$_SESSION['idUsuario'];

           $resultPesitens = $conn->query($sqlPesitens);
            
            
            echo "
            <div class='donation-info-item'>
                <div id='donation-info-local-group'>
                    <img src='../../assets/imgs/local.svg' alt='Ícone de local'>
                    <h4>".$row['razaoSocial']." | ".$row['nome']."</h4>
                </div>
                <div id='donation-info-items-group'>
                    <ul>";

                    while($rowli = $resultPesitens->fetch_assoc()){
                        if($rowli ['idCentro']== $row['idCentro']){
                            if(is_null($rowli ['dataHoraCentroRecebeu']) ){
                                $status= "Em transporte";  
                            }
                            else{
                                $status="Entregue";
                            }
                            echo "<li>".$rowli['tipo']."[".$status."]</br></li>"; 
                        }
                       
                    }

            echo"
                    </ul>
                    <div id='donation-info-options-group'>
                        <a class='edit'><svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'><path d='M373.1 24.97C401.2-3.147 446.8-3.147 474.9 24.97L487 37.09C515.1 65.21 515.1 110.8 487 138.9L289.8 336.2C281.1 344.8 270.4 351.1 258.6 354.5L158.6 383.1C150.2 385.5 141.2 383.1 135 376.1C128.9 370.8 126.5 361.8 128.9 353.4L157.5 253.4C160.9 241.6 167.2 230.9 175.8 222.2L373.1 24.97zM440.1 58.91C431.6 49.54 416.4 49.54 407 58.91L377.9 88L424 134.1L453.1 104.1C462.5 95.6 462.5 80.4 453.1 71.03L440.1 58.91zM203.7 266.6L186.9 325.1L245.4 308.3C249.4 307.2 252.9 305.1 255.8 302.2L390.1 168L344 121.9L209.8 256.2C206.9 259.1 204.8 262.6 203.7 266.6zM200 64C213.3 64 224 74.75 224 88C224 101.3 213.3 112 200 112H88C65.91 112 48 129.9 48 152V424C48 446.1 65.91 464 88 464H360C382.1 464 400 446.1 400 424V312C400 298.7 410.7 288 424 288C437.3 288 448 298.7 448 312V424C448 472.6 408.6 512 360 512H88C39.4 512 0 472.6 0 424V152C0 103.4 39.4 64 88 64H200z'/></svg></a>
                        <a class='delete'><svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 448 512'><path d='M160 400C160 408.8 152.8 416 144 416C135.2 416 128 408.8 128 400V192C128 183.2 135.2 176 144 176C152.8 176 160 183.2 160 192V400zM240 400C240 408.8 232.8 416 224 416C215.2 416 208 408.8 208 400V192C208 183.2 215.2 176 224 176C232.8 176 240 183.2 240 192V400zM320 400C320 408.8 312.8 416 304 416C295.2 416 288 408.8 288 400V192C288 183.2 295.2 176 304 176C312.8 176 320 183.2 320 192V400zM317.5 24.94L354.2 80H424C437.3 80 448 90.75 448 104C448 117.3 437.3 128 424 128H416V432C416 476.2 380.2 512 336 512H112C67.82 512 32 476.2 32 432V128H24C10.75 128 0 117.3 0 104C0 90.75 10.75 80 24 80H93.82L130.5 24.94C140.9 9.357 158.4 0 177.1 0H270.9C289.6 0 307.1 9.358 317.5 24.94H317.5zM151.5 80H296.5L277.5 51.56C276 49.34 273.5 48 270.9 48H177.1C174.5 48 171.1 49.34 170.5 51.56L151.5 80zM80 432C80 449.7 94.33 464 112 464H336C353.7 464 368 449.7 368 432V128H80V432z'/></svg></a>
                    </div>
                </div>
            </div>
            ";
            
            //echo "<br>ID: ".$row['id']."Nome: ".$row['nome'];
        }
        echo "</section>";
    } else {
        echo "<section><br><h3 id='not-found-message'>Nenhum resutado encontrado</h3></section>";
    }
?>

