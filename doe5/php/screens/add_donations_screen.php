<html>
    <head>
        <meta charset="utf-8">
        <title>Cadastro</title>
        <link rel="stylesheet" href="../../assets/styles/modules/header.css">
        <link rel="stylesheet" href="../../assets/styles/screens/add_donation_screen.css">
    </head>
    <body>
        <header>
            <a id="voltar" href="../screens/donations_screen.php">
                <img src="../../assets/imgs/voltar.svg" alt="Voltar">
                <h1>Voltar</h1>
            </a>
        </header>

        <section id="main">
            <h2>Nova doação</h2>
            <div id="don-items">

                <h3>🎁 Itens de doação:</h3>
                <form id='form-add-don' method="get" action="../actions/add_donation_action.php">
                    <div id="items">
                        <table id='items-table'>
                            <tr>
                                <td>
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Tipo:           </th>
                                                <th>Quantidade:     </th>
                                                <th>Altura(cm):     </th>
                                                <th>Largura(cm):    </th>
                                                <th>Comprimento(cm):</th>
                                            </tr>
                                        </thead>
                                        <tbody>
        
                                        <?php
                                            include('../src/conn.php');
                                            
                                            $sql = "SELECT * FROM TBItemDoacao ORDER BY tipo";
                                            $result1 = $conn->query($sql);
                                            $result2 = $conn->query($sql);
                                            $result3 = $conn->query($sql);
        
                                            $required = 'required';
                                            for($i = 0; $i < 3; $i++){
                                                if($i > 0){
                                                    $required = '';
                                                }
                                                
                                                echo "
                                                    <tr>
                                                        <td>
                                                            <select class='item-input-select' name='tipo-".$i."'".$required.">
                                                                <option value='' disabled selected>Item sendo doado:</option>";
                                                            
                                                                
                                                                while($row = $result1->fetch_assoc()){
                                                                    echo "<option value='".$row['id']."'>".ucfirst($row['tipo'])."</option>";
                                                                }

                                                                if($i == 1){
                                                                    $required = '';
                                                                    while($row2 = $result2->fetch_assoc()){
                                                                        echo "<option value='".$row2['id']."'>".ucfirst($row2['tipo'])."</option>";
                                                                    }
                                                                }
                                                                
                                                                if($i == 2){
                                                                    while($row3 = $result3->fetch_assoc()){
                                                                        echo "<option value='".$row3['id']."'>".ucfirst($row3['tipo'])."</option>";
                                                                    }
                                                                }
                                                                
                                                           echo"
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <input class='item-input-info-number' type='number' name='qtd-".$i."' min='0'".$required."/><!--Para todos-->
                                                        </td>
                                                        <td>
                                                            <input class='item-input-info-number' type='number' name='alt-".$i."' min='0'/></br><!--Para Colchao,cobertor,mesa e sofa-->
                                                        </td>
                                                        <td>
                                                            <input class='item-input-info-number' type='number' name='lar-".$i."' min='0'/></br><!--Para Colchao,cobertor,mesa e sofa-->
                                                        </td>
                                                        <td>
                                                            <input class='item-input-info-number' type='number' name='com-".$i."' min='0'/></br><!--Para Colchao,cobertor,mesa e sofa-->
                                                        </td>
                                                        </td>
                                                    </tr>
                                                    
                                                ";
                                            }
                                        ?>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </table>
                </div>
            </div>
                
                <div id="observacoes">
                    <h3>👁️‍🗨️ Observações:</h3>
                    <textarea 
                        class="description" 
                        id="descr_don" 
                        name="descr_don" 
                        cols="30" 
                        rows="10"
                        placeholder="Insira observações da sua doação"
                        maxlength="300"
                        ></textarea>
                </div>
                <br>
                <br>
                <hr>
                <br>
                <div id="encargos">
                    <h3>📄 Encargo:</h3>
                    <br>
                    <div id="encargos-check-field">
                    &emsp;&emsp;&emsp;<input type="checkbox" name="encargo" id="encargo-option"> Esta doação possui encargos
                    </div>
                    <textarea 
                        class="description hidden" 
                        name="descr_enc" 
                        class='hidden' 
                        id="descr_enc" 
                        cols="30" 
                        rows="10"
                        placeholder="Insira a descrição dos seus encargos"
                        maxlength="300"
                        ></textarea>
                </div>
                <br>
                <br>
                <hr>
                <br>
                <h3>🏠Instituição destino:</h3>
                <div id="instituicaoBeneficente">
                    <br>
                    <select name="instituicaoBeneficente" id="instituicaoBeneficente-select" required>
                        <option value="" disabled selected>Instituição destino:</option>
                        <?php
                            $resultInst = $conn->query('SELECT idInstituicao, razaoSocial FROM TBInstituicao');
                        

                            while($rowInst = $resultInst->fetch_assoc()){
                                echo "<option value=".$rowInst['idInstituicao']." >".$rowInst['razaoSocial']."</option>";
                                $inst = $rowInst['idInstituicao'];
                            }
                        ?>
                    </select>
                </div>
                <div id="submit">
                    <input id='btn-submit' type="submit" value="Enviar"/>
                </div>
            </form>
        </section>
    </body>

    <script>
        let check = document.querySelector('#encargo-option');
        let encargoDesc = document.querySelector('#descr_enc');

        check.addEventListener('click', 
            function showEncargo(){
                if(check.checked){
                    encargoDesc.classList.remove('hidden')
                } else {
                    encargoDesc.classList.add('hidden')
                }
            }
        );


    </script>
</html>