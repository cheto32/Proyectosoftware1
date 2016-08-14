	<div class="col-md-10">
		<div class="col-md-12">
			<?php
				if($datos['respuesta_uni']->num_rows() > 0){
			?>

			<table class="col-md-12">
				<!--Universidad DropDown-->
				<tr>
					<td>
						<select class="form-control" id="universidad_dropdown" onchange="selectUniversidad(this.options[this.selectedIndex].value)">
							<option value="-1">Seleccione universidad</option>
							<?php
							foreach($datos['respuesta_uni']->result() as $respuesta_uniElement){
								?>
								<option value="<?php echo $respuesta_uniElement->id_uni?>"><?php echo $respuesta_uniElement->nombre_uni?></option>
								<?php
							}
							?>
						</select>
					</td>
					<td>
						<select class="form-control" id="facultad_dropdown" onchange="selectFacultad(this.options[this.selectedIndex].value)">
							<option value="-1">Seleccione facultad</option>
							<span id="facultad_loader"></span>
						</select>
					</td>
					<td>
						<select class="form-control" id="departamento_dropdown" onchange="selectDepartamento(this.options[this.selectedIndex].value)">
							<option value="-1">Seleccione departamento</option>
							<span id="departamento_loader"></span>
						</select>
					</td>
					<td>
						<form method="POST" action="http://localhost/proyectosoftware1/index.php/principaladministrador/item_comboboxes">
							<select name="unidad-post" class="form-control" id="unidad_dropdown" onchange="this.form.submit()">
								<option value="-1">Seleccione unidad</option>
								<span id="unidad_loader"></span>
							</select>
						</form>
						
					</td>
				</tr>				
			</table>
			<?php
				}else{
					echo 'No Encontrado';
				}
			?>
		</div>

		<div id="grocery" class="col-md-7"><?php echo $output;?></div>
	</div>
</body>
