<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class PrincipalAdministrador extends CI_Controller {

	public function __construct(){
		parent::__construct();

		$this->load->database();
		$this->load->helper("url_helper");
		$this->load->helper("url");
		$this->load->library('Grocery_CRUD');
		$this->load->library("session");
		$this->load->model("Grocery_crud_model"); 
		$this->load->model("Administrador_Model");
	}


	public function index(){
		$this->load->view('administrador/index/head');
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/index/body');

	}

	public function error(){
		$this->load->view("errors/head");
		$this->load->view("errors/body");
	}

	public function empresa_externa(){
		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('empresa_externa');
		$crud->set_subject('Empresas Externas');


		$crud->display_as('id_ex','ID');
		$crud->display_as('tipo_ex','Tipo Empresa');
		$crud->display_as('nombre_ex','Nombre Empresa');

		$crud->columns('id_ex','tipo_ex','nombre_ex');
		$crud->required_fields('id_ex','tipo_ex','nombre_ex');

		$crud->field_type('tipo_ex','dropdown',array('PROVEEDOR' => 'PROVEEDOR',
													'DESECHOS TECNOLOGICOS' => 'DESECHOS TECNOLOGICOS',
													'REPARADOR' => 'REPARADOR'));
		
		$output = $crud->render();
		$this->load->view('administrador/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/body',$output);
	}

	public function usuario(){
		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('usuario');
		$crud->set_subject('Usuarios');

		$crud->display_as('rut_usuario','RUT Usuario');
		$crud->display_as('nombre_usuario','Nombre');
		$crud->display_as('pass_usuario','Contraseña');


		$crud->columns('rut_usuario','nombre_usuario','pass_usuario');
		$crud->required_fields('rut_usuario','nombre_usuario','pass_usuario');
		
		$output = $crud->render();		
		$this->load->view('administrador/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/body',$output);
	}
		
	public function administrador(){
		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('administrador');
		$crud->set_subject('Administradores');

		$crud->display_as('rut_admin','RUT Administrador');
		$crud->display_as('nombre_admin','Nombre');
		$crud->display_as('pass_admin','Contraseña');

		$crud->columns('rut_admin','nombre_admin','pass_admin');
		$crud->required_fields('rut_admin','nombre_admin','pass_admin');
		
		$output = $crud->render();
		
		$this->load->view('administrador/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/body',$output);
	}

	public function universidad(){
		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('universidad');
		$crud->set_subject('Universidades');

		$crud->display_as('nombre_uni','Universidad');
		$crud->display_as('ubicacion_uni','Dirección');

		$crud->required_fields('nombre_uni');

		$output = $crud->render();
		$this->load->view('administrador/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/body',$output);
	}

	public function facultad(){
		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('facultad');
		$crud->set_subject('Facultades');

		$crud->display_as('nombre_facultad','Facultad');
		$crud->display_as('ubicacion_facultad','Dirección');
		$crud->display_as('id_universidad_facultad','Universidad');

		$crud->required_fields('nombre_facultad','id_universidad_facultad');

		//Relaciones(Modificar Vista de ID por otro atributo de la tabla).
		$crud->set_relation('id_universidad_facultad','universidad','nombre_uni');

		$output = $crud->render();
		$this->load->view('administrador/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/body',$output);
	}

	public function departamento(){
		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('departamento');
		$crud->set_subject('Departamentos');

		$crud->display_as('nombre_depto','Departamento');
		$crud->display_as('ubicacion_depto','Dirección');
		$crud->display_as('id_facultad_depto','Facultad');

		$crud->required_fields('nombre_depto','id_facultad_depto');

		$crud->set_relation('id_facultad_depto','facultad','nombre_facultad');

		$output = $crud->render();
		$this->load->view('administrador/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/body',$output);
	}

	public function unidad(){
		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('unidad');
		$crud->set_subject('Unidades');

		$crud->display_as('nombre_unidad','Unidad');
		$crud->display_as('ubicacion_unidad','Dirección');
		$crud->display_as('id_depto_unidad','Departamento');

		$crud->required_fields('nombre_unidad','id_depto_unidad');

		$crud->set_relation('id_depto_unidad','departamento','nombre_depto');

		$output = $crud->render();
		$this->load->view('administrador/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/body',$output);
	}

	public function itemsForUnit(){

		$id_post=$_POST['id_post'];

		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('item');
		$crud->where('item.id_unidad_item',$id_post);
		$crud->set_subject('Items');

		$crud->display_as('id_item','ID');
		$crud->display_as('veces_reparacion_item','Número Reparaciones');
		$crud->display_as('id_item_relacionado_item','ID Item Rel.');
		$crud->display_as('id_unidad_item','Unidad');
		$crud->display_as('id_empresa_proveedora_item','Emp. Proveedora');
		$crud->display_as('id_empresa_reparadora_item','Emp. Reparadora');
		$crud->display_as('id_empresa_desechadora_item','Emp. Desechadora');
		$crud->display_as('tipo_item','Tipo de Producto');

		$crud->set_relation('id_unidad_item','unidad','nombre_unidad');		
		$crud->set_relation('id_empresa_proveedora_item','empresa_externa','nombre_ex');
		$crud->set_relation('id_empresa_reparadora_item','empresa_externa','nombre_ex');
		$crud->set_relation('id_empresa_desechadora_item','empresa_externa','nombre_ex');

		$crud->field_type('estado_item','dropdown',array('ACTIVO' => 'ACTIVO',
													'REPARACION' => 'REPARACION',
													'EN TRANSITO' => 'EN TRANSITO',
													'DE BAJA' => 'DE BAJA'));
		
		$crud->add_fields('tipo_item','descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');

		//Comentado en siguiente función, es el mismo funcionamiento
		if($crud->getState()=='edit'){
			$crud->set_relation('id_item_relacionado_item','item','id_item');
			$tipo=null;

			$auxiliar['valor']=$this->grocery_crud->getStateInfo()->primary_key;
			$datos['respuesta_db']=$this->Administrador_Model->consultar_tipo_item($auxiliar);

			foreach ($datos['respuesta_db'] -> result() as $atributo) {
				$tipo=$atributo->tipo_item;
			}
			if($tipo=='EQUIPO'){
				$crud->edit_fields('tipo_item','descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
				$crud->required_fields('tipo_item','descripcion_item','estado_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
			}else{
				$crud->edit_fields('tipo_item','descripcion_item','estado_item','fecha_ingreso_item','fecha_baja_item','id_item_relacionado_item','id_unidad_item','id_empresa_proveedora_item','id_empresa_reparadora_item','id_empresa_desechadora_item');
				$crud->required_fields('tipo_item','descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
			}
		}

		$output = $crud->render();
		$this->load->view('administrador/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/body',$output);
	}

	public function itemsFullList(){
		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('item');
		$crud->set_subject('Lista Completa Inventario');

		$crud->columns('tipo_item','descripcion_item','estado_item','fecha_ingreso_item','fecha_baja_item','veces_reparacion_item','id_item_relacionado_item','id_unidad_item','id_empresa_proveedora_item','id_empresa_reparadora_item','id_empresa_desechadora_item');

		//Cambiar nombre de atributo de la DB, por uno más apropiado para el usuario
		$crud->display_as('id_item','ID');
		$crud->display_as('veces_reparacion_item','Número Reparaciones');
		$crud->display_as('id_item_relacionado_item','ID Item Rel.');
		$crud->display_as('id_unidad_item','Unidad');
		$crud->display_as('id_empresa_proveedora_item','Emp. Proveedora');
		$crud->display_as('id_empresa_reparadora_item','Emp. Reparadora');
		$crud->display_as('id_empresa_desechadora_item','Emp. Desechadora');
		$crud->display_as('tipo_item','Tipo de Producto');

		//Relaciones
		$crud->set_relation('id_unidad_item','unidad','nombre_unidad');		
		$crud->set_relation('id_empresa_proveedora_item','empresa_externa','nombre_ex');
		$crud->set_relation('id_empresa_reparadora_item','empresa_externa','nombre_ex');
		$crud->set_relation('id_empresa_desechadora_item','empresa_externa','nombre_ex');

		//El campo 'estado' es de tipo DROPDOWN
		$crud->field_type('estado_item','dropdown',array('ACTIVO' => 'ACTIVO' ,
													'REPARACION' => 'REPARACION',
													'EN TRANSITO' => 'EN TRANSITO',
													'DE BAJA' => 'DE BAJA'));

		$crud->add_fields('tipo_item','descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');

		//Si se está editando...
		if($crud->getState()=='edit'){
			$crud->set_relation('id_item_relacionado_item','item','id_item');

			$tipo=null;

			//Se consulta el tipo del item que se va a editar...
			$auxiliar['valor']=$this->grocery_crud->getStateInfo()->primary_key;
			$datos['respuesta_db']=$this->Administrador_Model->consultar_tipo_item($auxiliar);

			//Se capta el resultado...
			foreach ($datos['respuesta_db'] -> result() as $atributo) {
				$tipo=$atributo->tipo_item;
			}

			if($tipo=='EQUIPO'){
				$crud->edit_fields('tipo_item','descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
				$crud->required_fields('tipo_item','descripcion_item','estado_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
			}else{
				$crud->edit_fields('tipo_item','descripcion_item','estado_item','fecha_ingreso_item','fecha_baja_item','id_item_relacionado_item','id_unidad_item','id_empresa_proveedora_item','id_empresa_reparadora_item','id_empresa_desechadora_item');
				$crud->required_fields('tipo_item','descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
			}
		}

		$output = $crud->render();
		$this->load->view('administrador/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/body',$output);
	}

	public function equipo(){
		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('equipo');
		$crud->set_subject('Equipos');

		$crud->unset_add();
		$crud->columns('id_cpt','descripcion_cpt','tipo_cpt','estado_cpt','fecha_ingreso_cpt','fecha_baja_cpt','veces_reparacion_cpt','id_equipo_relacionado_cpt','id_pieza_nueva_cpt','id_empresa_reparadora_cpt','id_empresa_desechadora_cpt');
		
		$crud->display_as('id_cpt','ID');
		$crud->display_as('descripcion_cpt','Descripcion');
		$crud->display_as('estado_cpt','Estado Producto');
		$crud->display_as('fecha_ingreso_cpt','Fecha Ingreso');
		$crud->display_as('fecha_baja_cpt','Fecha Baja');
		$crud->display_as('veces_reparacion_cpt','Número Reparaciones');
		$crud->display_as('id_equipo_relacionado_cpt','ID Equipo');
		$crud->display_as('id_pieza_nueva_cpt','ID Pieza');
		$crud->display_as('id_empresa_reparadora_cpt','ID Emp. Reparadora');
		$crud->display_as('id_empresa_desechadora_cpt','ID Emp. Desechadora');
		$crud->display_as('tipo_cpt','Tipo de Producto');

		$crud->set_relation('id_empresa_reparadora_cpt','empresa_externa','nombre_ex');
		$crud->set_relation('id_empresa_desechadora_cpt','empresa_externa','nombre_ex');
		$crud->set_relation('id_pieza_nueva_cpt','item','id_item');
		$crud->set_relation('id_equipo_relacionado_cpt','item','id_item');

		$crud->field_type('estado_cpt','dropdown',array('ACTIVO' => 'ACTIVO',
													'REPARACION' => 'REPARACION',
													'EN TRANSITO' => 'EN TRANSITO',
													'DE BAJA' => 'DE BAJA'));

		$output = $crud->render();
	
		$this->load->view('administrador/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/body',$output);
	}

	public function item_comboboxes(){
		
		$datos['respuesta_uni']=$this->Administrador_Model->getUniversidad();

		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('item');
		$crud->set_subject('Inventario');

		$crud->columns('id_item','tipo_item','descripcion_item','estado_item','fecha_ingreso_item','fecha_baja_item','veces_reparacion_item','id_item_relacionado_item','id_unidad_item','id_empresa_proveedora_item','id_empresa_reparadora_item','id_empresa_desechadora_item');

		$crud->display_as('id_item','ID');
		$crud->display_as('veces_reparacion_item','Número Reparaciones');
		$crud->display_as('id_item_relacionado_item','ID Item Rel.');
		$crud->display_as('id_unidad_item','Unidad');
		$crud->display_as('id_empresa_proveedora_item','Emp. Proveedora');
		$crud->display_as('id_empresa_reparadora_item','Emp. Reparadora');
		$crud->display_as('id_empresa_desechadora_item','Emp. Desechadora');
		$crud->display_as('tipo_item','Tipo de Producto');

		$crud->set_relation('id_unidad_item','unidad','nombre_unidad');		
		$crud->set_relation('id_empresa_proveedora_item','empresa_externa','nombre_ex');
		$crud->set_relation('id_empresa_reparadora_item','empresa_externa','nombre_ex');
		$crud->set_relation('id_empresa_desechadora_item','empresa_externa','nombre_ex');

		$crud->callback_add_field('tipo_item',array($this,'callback_to_upper'));
		$crud->callback_before_insert(array($this,'prepare'));

		$crud->field_type('estado_item','dropdown',array('ACTIVO' => 'ACTIVO',
													'REPARACION' => 'REPARACION',
													'EN TRANSITO' => 'EN TRANSITO',
													'DE BAJA' => 'DE BAJA'));
		
		$crud->add_fields('tipo_item','descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');

		//Comentado en siguiente función, es el mismo funcionamiento
		if($crud->getState()=='edit'){
			$crud->set_relation('id_item_relacionado_item','item','descripcion_item');
			$tipo=null;

			$auxiliar['valor']=$this->grocery_crud->getStateInfo()->primary_key;
			$datos['respuesta_db']=$this->Administrador_Model->consultar_tipo_item($auxiliar);

			foreach ($datos['respuesta_db'] -> result() as $atributo) {
				$tipo=$atributo->tipo_item;
			}
			if($tipo=='EQUIPO'){
				$crud->edit_fields('descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
				$crud->required_fields('descripcion_item','estado_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
			}else{
				$crud->edit_fields('descripcion_item','estado_item','fecha_ingreso_item','fecha_baja_item','id_item_relacionado_item','id_unidad_item','id_empresa_proveedora_item','id_empresa_reparadora_item','id_empresa_desechadora_item');
				$crud->required_fields('descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
			}
		}
		$crud->columns('id_item','tipo_item','descripcion_item','estado_item','fecha_ingreso_item','fecha_baja_item','veces_reparacion_item','id_item_relacionado_item','id_unidad_item','id_empresa_proveedora_item','id_empresa_reparadora_item','id_empresa_desechadora_item');
		
		if ($this->input->post('unidad-post')!=null){
			//echo "si";
			$id_post=$this->input->post('unidad-post');
			$crud->where('item.id_unidad_item',$id_post);
		}
		
		$output = $crud->render();
		$output->datos=$datos;

		$this->load->view('administrador/itemsForUnit/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/itemsForUnit/body',$output);
	}
	function callback_to_upper(){
		return '<input id="field-tipo_item" type="text" class="form-control" name="tipo_item" style="text-transform:uppercase;">';
	}
	public function prepare($post_array){
		$post_array['tipo_item'] = strtoupper(trim($post_array['tipo_item']));
		return $post_array;
	}

	public function historico(){
		$crud= new grocery_CRUD();
		$crud->set_theme('bootstrap');
		$crud->set_table('historico_item');
		$crud->set_subject('Histórico');

		$crud->display_as('id_item_hi','ID Item');
		$crud->display_as('id_componente_hi','ID Componente');
		$crud->display_as('fecha_hi','Fecha');
		$crud->display_as('descripcion_hi','Descripción');

		$crud->set_relation('id_item_hi','item','id_item');
		$crud->set_relation('id_componente_hi','equipo','id_cpt');

		$output = $crud->render();
		$this->load->view('administrador/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/body',$output);

	}

	public function loadData()
	{
		$loadType=$_POST['loadType'];
		$loadId=$_POST['loadId'];

		$datos=$this->Administrador_Model->getData($loadType,$loadId);
		$HTML="";
		
		if($datos->num_rows() > 0){
			foreach($datos->result() as $atributo){
				if (isset($atributo->id_facultad)) {
					$HTML.="<option value='".$atributo->id_facultad."'>".$atributo->nombre_facultad."</option>";
				}else{
					if (isset($atributo->id_depto)) {
						$HTML.="<option value='".$atributo->id_depto."'>".$atributo->nombre_depto."</option>";
					}else{
						if (isset($atributo->id_unidad)) {
							$HTML.="<option value='".$atributo->id_unidad."'>".$atributo->nombre_unidad."</option>";
						}
					}
				}
			}
		}
		echo $HTML;
	}

	public function avisos(){
		$crud= new grocery_CRUD();
		$crud->set_theme('bootstrap');
		$crud->set_table('aviso_problema');
		$crud->set_subject('Aviso Problemas');

		$crud->display_as('tipo_aviso','Tipo de Aviso');
		$crud->display_as('item_relacionado_aviso','Item Relacionado');
		$crud->display_as('descripcion_aviso','Descripción');

		$crud->set_relation('item_relacionado_aviso','item','descripcion_item');

		$output = $crud->render();
		$this->load->view('administrador/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/body',$output);
	}
}
