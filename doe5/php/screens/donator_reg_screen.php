<html>

    <head>
        <title>Doe 5</title>
        <link rel="stylesheet" href="../../assets/styles/screens/register.css">
        <link rel="stylesheet" href="../../assets/styles/modules/header.css">
        
    </head>

    <body>
        <header>
            <a id="voltar" href="../../index.php">
                <img src="../../assets/imgs/voltar.svg" alt="Voltar">
                <h1>Voltar</h1>
            </a>
        </header>

        <!--Form de dados de conta SENDO CADASTRADO - Cadastro -->
        <section id="main">
            <h2>Cadastrar-se</h2>
            <form id='form-donator-reg'name="new_donator" action="../actions/donator_reg_action.php" method="get">
                <div id="div-line-1">
                    <div class="col">
                        <div class="input-field">
                            <h4>Nome: <span>*</span></h4>
                            <input required name="nome" type="text" placeholder="John Doe">
                        </div>    
                        <div class="input-field">
                            <h4>Email: <span>*</span></h4>
                            <input required name="emailAdd" type="text" placeholder="exemplo@doe5.com">
                        </div>
                        <div class="input-field">
                            <h4>Telefone: </h4>
                            <input name="fone" type="tel" pattern="^[0-9]{11}$" placeholder="41998765432">
                        </div>
                        <div class="input-field">
                            <h4>Rua:<span>*</span> </h4>
                            <input required name="street" type="text" placeholder="Rua Imac. Conceição">
                        </div>
                        <div class="input-field">
                            <h4>Complemento: </h4>
                            <input name="complement" type="text" placeholder="Apartamento 404">
                        </div>
                    </div>



                    <br>
                    <hr>
                    <br>


                    <div class="col">
                        <div class="input-field">
                            <h4>Senha: <span>*</span></h4>
                            <input required name="senhaAdd" type="password" placeholder="Doe@eM%5">
                        </div>    
                        <div class="input-field">
                            <h4>Confirmação de senha: <span>*</span></h4>
                            <input required name="confirmaSenha" type="password" placeholder="Doe@eM%5">
                        </div>
                        <div class="input-field">
                            <h4>Data de nascimento: <span>*</span></h4>
                            <input required name="dataNasc" type="date" required>
                        </div>
                        <div class="input-field">
                            <h4>Número:<span>*</span> </h4>
                            <input required name="number" type="text" placeholder="123B">
                        </div>
                        <div class="input-field">
                            <h4>Bairro:<span>*</span> </h4>
                            <input required name="neighborhood" type="text" placeholder="Prado Velho">
                        </div>
                    </div>
                </div>
                <div id="div-line-2">
                    <div id="div-select-city" class="col">
                        <h4>Cidade:<span>*</span> </h4>
                        <select required name="city" id="select-city">
                            <option value="" disabled selected>Cidade:</option>
                            <?php
                                include('../src/conn.php');
                                $sqlCity = "SELECT id, cidade FROM TBCidade";
                                $result = $conn->query($sqlCity);

                                while($row = $result->fetch_assoc()){
                                    echo "<option value=".$row['id'].">".$row['cidade']."</option>";
                                }
                            
                            ?>
                        </select>
                    </div>
                </div>
                <input id='btn-submit'type="submit" value="Cadastrar">
            </form>
        </section>
    </body>
</html>