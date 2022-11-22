<?php
session_start();


if(isset($_SESSION['Versao'])){
    echo "<script>console.log('Versão da sessão: ".$_SESSION['Versao']."')</script>";
} else {
    echo $_SESSION['Versao'];
    echo "<script type='text/javascript'>alert('Nenhuma versão encontrada. Retornando...');</script>";
    header("Location: index.php");
}
?>