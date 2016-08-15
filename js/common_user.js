function selectUniversidad(id_universidad){
	if(id_universidad!="-1"){
		loadData('facultad',id_universidad);
		$("#departamento_dropdown").html("<option value='-1'>Seleccione departamento</option>");	
		$("#unidad_dropdown").html("<option value='-1'>Seleccione unidad</option>");
		/*
		//Es para refrescar correctamente los números en pantalla, al ocupar las funciones "opcionTanto()"
		$("#opcionUniversidad").html("");
		$("#opcionFacultad").html("");
		$("#opcionDepartamento").html("");
		$("#opcionUnidad").html("");
		*/
	}else{
		$("#facultad_dropdown").html("<option value='-1'>Seleccione facultad</option>");
		$("#departamento_dropdown").html("<option value='-1'>Seleccione departamento</option>");
		$("#unidad_dropdown").html("<option value='-1'>Seleccione unidad</option>");
		/*
		//Es para refrescar correctamente los números en pantalla, al ocupar las funciones "opcionTanto()"
		$("#opcionFacultad").html("");
		$("#opcionDepartamento").html("");
		$("#opcionUnidad").html("");
		*/	
	}
}

function selectFacultad(id_facultad){
	if(id_facultad!="-1"){
		loadData('departamento',id_facultad);
		$("#unidad_dropdown").html("<option value='-1'>Seleccione unidad</option>");
		/*
		//Es para refrescar correctamente los números en pantalla, al ocupar las funciones "opcionTanto()"
		$("#opcionFacultad").html("");
		$("#opcionDepartamento").html("");
		$("#opcionUnidad").html("");
		*/
	}else{
		$("#departamento_dropdown").html("<option value='-1'>Seleccione departamento</option>");	
		$("#unidad_dropdown").html("<option value='-1'>Seleccione unidad</option>");
		/*
		//Es para refrescar correctamente los números en pantalla, al ocupar las funciones "opcionTanto()"
		$("#opcionDepartamento").html("");
		$("#opcionUnidad").html("");	
		*/
	}
}

function selectDepartamento(id_departamento){
	if(id_departamento!="-1"){
		loadData('unidad',id_departamento);
		/*
		//Es para refrescar correctamente los números en pantalla, al ocupar las funciones "opcionTanto()"
		$("#opcionDepartamento").html("");
		$("#opcionUnidad").html("");
		*/
	}else{
		$("#unidad_dropdown").html("<option value='-1'>Seleccione unidad</option>");
		/*
		//Es para refrescar correctamente los números en pantalla, al ocupar las funciones "opcionTanto()"
		$("#opcionUnidad").html("");
		*/
	}
}

//Funciones para visualizar el ID de la opción elegida, en tiempo real. (DEBUG)
/*
function opcionUniversidad() {
	var a = document.getElementById("universidad_dropdown");
	$("#opcionUniversidad").html(a.options[a.selectedIndex].value);
}

function opcionFacultad() {
	var a = document.getElementById("facultad_dropdown");
	$("#opcionFacultad").html(a.options[a.selectedIndex].value);
}

function opcionDepartamento() {
	var a = document.getElementById("departamento_dropdown");
	$("#opcionDepartamento").html(a.options[a.selectedIndex].value);
}

function opcionUnidad() {
	var a = document.getElementById("unidad_dropdown");
	$("#opcionUnidad").html(a.options[a.selectedIndex].value);
}
*/

//Funcion que spawnea el formulario, para enviarlo método POST a la funcion "item", para filtrar la salida


function loadData(loadType,loadId){
	var dataString = 'loadType='+ loadType +'&loadId='+ loadId;
	$("#"+loadType+"_loader").show();
    $("#"+loadType+"_loader").fadeIn(400).html('Espere...');
	$.ajax({
		type: "POST",
		url: "http://localhost/proyectosoftware1/index.php/principalUser/loadData",
		data: dataString,
		cache: false,
		success: function(result){
			$("#"+loadType+"_loader").hide();
			$("#"+loadType+"_dropdown").html("<option value='-1'>Seleccione "+loadType+"</option>");  
			$("#"+loadType+"_dropdown").append(result);  
		}
	});
}