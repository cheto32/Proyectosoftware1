<?php   
    if(isset($_SESSION['rol'])){
        if ($_SESSION['rol']=="ADMINISTRADOR") {
            $admin="ADMINISTRADOR";
        }else{
            $admin="NO ADMIN";
        }        
    }else{
        $admin="NO SET";
    }

    if($admin=="NO SET")
        header("Location: ".base_url());
    if($admin=="NO ADMIN")
        header("Location: ".base_url()."index.php/principalAdministrador/error");
    if($admin=="ADMINISTRADOR")

?>

<!DOCTYPE html>
<html>
<head>
    <title></title>
  	
    <?php
    foreach($css_files as $file): ?>
    <link type="text/css" rel="stylesheet" href="<?php echo $file; ?>" />
    <?php endforeach; ?>
    <?php foreach($js_files as $file): ?>
    <script src="<?php echo $file; ?>"></script>
    <?php endforeach; ?>

    <script src="<?php echo base_url();?>js/aside.js"></script>
    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>css/estilo_panel.css">
    <script type="text/javascript" src="<?php echo base_url();?>js/common.js"></script>
</head>