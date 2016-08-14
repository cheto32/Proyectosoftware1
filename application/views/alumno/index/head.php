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
        header("Location: ".base_url()."index.php/principalAlumno/error");
    if($alumno=="USUARIO")

?>

<!DOCTYPE html>
<html>
<head>
	<title></title>
    <link type="text/css" rel="stylesheet" href="<?php echo base_url();?>assets/grocery_crud/themes/bootstrap/css/bootstrap/bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="<?php echo base_url();?>assets/grocery_crud/themes/bootstrap/css/font-awesome/css/font-awesome.min.css" />
    <link type="text/css" rel="stylesheet" href="<?php echo base_url();?>assets/grocery_crud/themes/bootstrap/css/common.css" />
    <link type="text/css" rel="stylesheet" href="<?php echo base_url();?>assets/grocery_crud/themes/bootstrap/css/list.css" />
    <link type="text/css" rel="stylesheet" href="<?php echo base_url();?>assets/grocery_crud/themes/bootstrap/css/general.css" />
    <link type="text/css" rel="stylesheet" href="<?php echo base_url();?>assets/grocery_crud/themes/bootstrap/css/plugins/animate.min.css" />

  	<script src="<?php echo base_url();?>assets/grocery_crud/js/jquery-1.11.1.min.js"></script>
    <script src="<?php echo base_url();?>assets/grocery_crud/themes/bootstrap/build/js/global-libs.min.js"></script>
    <script src="<?php echo base_url();?>assets/grocery_crud/themes/bootstrap/js/bootstrap/dropdown.min.js"></script>
    <script src="<?php echo base_url();?>assets/grocery_crud/themes/bootstrap/js/bootstrap/modal.min.js"></script>
    <script src="<?php echo base_url();?>assets/grocery_crud/themes/bootstrap/js/jquery-plugins/bootstrap-growl.min.js"></script>
    <script src="<?php echo base_url();?>assets/grocery_crud/themes/bootstrap/js/jquery-plugins/jquery.print-this.js"></script>
    <script src="<?php echo base_url();?>assets/grocery_crud/themes/bootstrap/js/datagrid/gcrud.datagrid.js"></script>
    <script src="<?php echo base_url();?>assets/grocery_crud/themes/bootstrap/js/datagrid/list.js"></script>

    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>css/estilo_panel.css">
</head>