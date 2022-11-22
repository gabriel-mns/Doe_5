<?php
$severname="localhost";
$username ="admin";
$password ="admin";
$dbname   ="doe5";

//Conexão com banco de dados(BD) criada
$conn = new mysqli($severname,$username,$password,$dbname);

//Verificando possíveis erros de conexão com o BD
if($conn->connect_error){
    die("Conexão falhou : ". $conn->connect_error);
}
?>