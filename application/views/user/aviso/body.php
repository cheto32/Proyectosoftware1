<!-- <body> de alumno/aside.php-->
	<div class="col-md-10">
		<form method="POST" action="<?php echo base_url();?>index.php/principalUser/envio_formulario">
		  	<fieldset class="form-group">
			    <label for="exampleSelect1">Tipo Problema</label>
			    <select id="id_select" class="form-control" onchange="hola()" name="input_select" >
			    	<option selected="selected" value="PC NO ENCIENDE">PC NO ENCIENDE</option>
		    		<option value="RENDIMIENTO SISTEMA OPERATIVO">RENDIMIENTO SISTEMA OPERATIVO</option>
		      		<option value="VENTANAS DE ERRORES">VENTANAS DE ERRORES</option>
		      		<option value="REINICIO/APAGADO AUTOMÁTICO">REINICIO/APAGADO AUTOMÁTICO</option>
		      		<option value="VIBRACIÓN/RUIDO GABINETE">VIBRACIÓN/RUIDO GABINETE</option>
		      		<option value="DESCARGA LENTA">DESCARGA LENTA</option>
		      		<option value="IMPRESORA">IMPRESORA</option>
		      		<option value="OTRO">OTRO</option>
		    	</select>
		    	<div id="otrotipo"></div>
		  	</fieldset>

		  	<fieldset class="form-group">
			    <label for="exampleSelect1">Item Problema</label>
			    <select id="id_select_2" class="form-control" name="input_select_2" >
			    	<?php echo $cadena;?>
		    	</select>
		  	</fieldset>

		  	<fieldset class="form-group">
		    	<label for="exampleTextarea">Descripción Problema</label>
		    	<textarea id="id_textarea" class="form-control" name="input_textarea" required="true" rows="3"></textarea>
		  	</fieldset>
		  	<button type="submit" class="btn btn-primary">Submit</button>
		</form>
	</div>
</body>

<script type="text/javascript">
	function hola(){
		if(document.getElementById("id_select").selectedIndex==7){
     		document.getElementById("otrotipo").innerHTML = "<label>Que tipo de problema?</label><input id='id_otro' type='text' class='form-control' name='tipo_otro' required='true'>";
  		}else{
  			document.getElementById("otrotipo").innerHTML = "";
  		}
	}
</script>

