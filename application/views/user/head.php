<?php   
    if(isset($_SESSION['rol'])){
        if ($_SESSION['rol']=="USUARIO") {
            $alumno="USUARIO";
        }else{
            $alumno="NO USUARIO";
        }        
    }else{
        $alumno="NO SET";
    }

    if($alumno=="NO SET")
        header("Location: ".base_url());
    if($alumno=="NO USUARIO")
        header("Location: ".base_url()."index.php/principalUser/error");
    if($alumno=="USUARIO")

?>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <!-- Grocery CRUD CSS and JS Files -->
    <?php
    foreach($css_files as $file): ?>
    <link type="text/css" rel="stylesheet" href="<?php echo $file; ?>" />
    <?php endforeach; ?>
    <?php foreach($js_files as $file): ?>
    <script src="<?php echo $file; ?>"></script>
    <?php endforeach; ?>

    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>css/estilo_panel.css">
    <link type="text/css" rel="stylesheet" href="<?php echo base_url();?>css/estilo_GC_OUTPUT.css" />

    <script src="<?php echo base_url();?>js/aside.js"></script>

</head>