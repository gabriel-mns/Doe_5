<?php
    include('../src/session_start.php');
    include('../src/conn.php');

    $idUser = $_GET['id'];
    $status = "<span class='active'>Ativo</span>";

    $sqlPesq = "SELECT * 
                FROM 
                    TBUsuario U 
                    LEFT JOIN 
                    tbBanimento B 
                    ON U.id = B.idUsuario
                WHERE U.id = ".$idUser.";";

    $resultPesq = $conn->query($sqlPesq);

    while($row = $resultPesq->fetch_assoc()){
        if (!is_null($row['dataHoraBanimento'])){
            $status = "<span class='banned'>Banido</span>";
        }

        
        $name = $row['nome'];
        $email = $row['email'];
        $telefone = $row['celular'];
        $dataNasc = $row['dataNascimento'];
    }
?>

<html>
    <head>
        <title>Doe em 5</title>
        <link rel="stylesheet" href="../../assets/styles/modules/header.css">
        <link rel="stylesheet" href="../../assets/styles/modules/modal.css">
        <link rel="stylesheet" href="../../assets/styles/screens/profile_page.css">
    </head>
    <body>
        
        <header>
            <a id="voltar" aria-label="Voltar para página anterior" href="manage_users_screen.php">
                <img src="../../assets/imgs/voltar.svg" alt="Voltar">
                <h1>Voltar</h1>
            </a>
        </header>
        
        <section id="main">
            <section id="sidebar">
                <div id='profile-side'>
                    <img id="profile-photo" src="../../assets/imgs/usuario.svg" alt="Foto de perfil">
                    <p>Status: <?php echo $status?></p>
                </div>
                <div id="options">
                    <button id="ban-option"> Banir usuário</button>
                </div>
            </section>
            <section id="container">
                <div class="info-container">
                    <h4>Nome:               </h4>&nbsp;
                    <?php echo "<p>".$name."</p>"?>
                </div>
                <div class="info-container">
                    <h4>Data de nascimento:</h4>&nbsp;
                    <?php echo "<p>".$dataNasc."</p>"?>
                </div>
                <div class="info-container">
                    <h4>Telefone:           </h4>&nbsp;
                    <?php echo "<p>".$telefone."</p>"?>
                </div>
                <div class="info-container">
                    <h4>Email:              </h4>&nbsp;
                    <?php echo "<p>".$email."</p>"?>                    
                </div>
            </section>
        </section>

        <div class="hidden" id="modal-container">
            <div id="modal">
                <button id='btn-close' onclick="showModal">X</button>
                <h4>Motivo de banimento:</h4>
                <form action="../actions/ban_action.php">
                    <input name='idUser' type="text" value='<?php echo $idUser?>' hidden>
                    <textarea required placeholder="Descreva o motivo do banimento" name="reason" id="txtarea-reason" cols="30" rows="10" style="resize: none;"></textarea>
                    <button id="btn-ban" type="submit">Banir</button>
                </form>
            </div>
        </div>
    </body>

    <script>
        let banBtn = document.querySelector('#ban-option');
        
        function showModal(modalId){
            let modal = document.getElementById(modalId);
            console.log(modal)
            
            if(modal){
                modal.classList.add('show');
                modal.addEventListener('click', (e)=>{
                    if(e.target.id == modalId || e.target.id == 'btn-close'){
                        modal.classList.remove('show')
                        modal.classList.add('hidden')
                    }
                })
            }
        }

        banBtn.addEventListener('click', ()=>showModal('modal-container'))

    </script>
</html>