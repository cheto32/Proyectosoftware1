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

		$crud->columns('id','tipo','nombre');
		$crud->required_fields('id','tipo','nombre');

		$crud->field_type('tipo','dropdown',array('PROVEEDOR' => 'PROVEEDOR',
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

		$crud->columns('rut','nombre','pass');
		$crud->required_fields('rut','nombre','pass');
		
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

		$crud->columns('rut','nombre','pass');
		$crud->required_fields('rut','nombre','pass');
		
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

		$crud->columns('id','nombre');
		$crud->required_fields('nombre');

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

		$crud->columns('id','nombre','id_universidad');
		$crud->required_fields('nombre','id_universidad');

		//Relaciones(Modificar Vista de ID por otro atributo de la tabla).
		$crud->set_relation('id_universidad','universidad','nombre');

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

		$crud->columns('id','nombre','id_facultad');
		$crud->required_fields('nombre','id_facultad');

		$crud->set_relation('id_facultad','facultad','nombre');

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

		$crud->columns('id','nombre','id_depto');
		$crud->required_fields('nombre','id_depto');

		$crud->set_relation('id_depto','departamento','nombre');

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
		$crud->where('item.id_unidad',$id_post);
		$crud->set_subject('Items');

		$crud->columns('id','tipo','descripcion','estado','fecha_ingreso','fecha_baja','veces_reparacion','id_item_relacionado','id_unidad','id_empresa_proveedora','id_empresa_reparadora','id_empresa_desechadora');

		$crud->display_as('id','ID');
		$crud->display_as('veces_reparacion','Número Reparaciones');
		$crud->display_as('id_item_relacionado','ID Item Rel.');
		$crud->display_as('id_unidad','Unidad');
		$crud->display_as('id_empresa_proveedora','Emp. Proveedora');
		$crud->display_as('id_empresa_reparadora','Emp. Reparadora');
		$crud->display_as('id_empresa_desechadora','Emp. Desechadora');
		$crud->display_as('tipo','Tipo de Producto');

		$crud->set_relation('id_item_relacionado','item','descripcion');
		$crud->set_relation('id_unidad','unidad','nombre');		
		$crud->set_relation('id_empresa_proveedora','empresa_externa','nombre');
		$crud->set_relation('id_empresa_reparadora','empresa_externa','nombre');
		$crud->set_relation('id_empresa_desechadora','empresa_externa','nombre');

		$crud->field_type('estado','dropdown',array('ACTIVO' => 'ACTIVO',
													'REPARACION' => 'REPARACION',
													'EN TRANSITO' => 'EN TRANSITO',
													'DE BAJA' => 'DE BAJA'));
		
		$crud->add_fields('tipo','descripcion','fecha_ingreso','id_unidad','id_empresa_proveedora');

		//Comentado en siguiente función, es el mismo funcionamiento
		if($crud->getState()=='edit'){
			$tipo=null;

			$auxiliar['valor']=$this->grocery_crud->getStateInfo()->primary_key;
			$datos['respuesta_db']=$this->Administrador_Model->consultar_tipo_item($auxiliar);

			foreach ($datos['respuesta_db'] -> result() as $atributo) {
				$tipo=$atributo->tipo;
			}
			if($tipo=='EQUIPO'){
				$crud->edit_fields('tipo','descripcion','fecha_ingreso','id_unidad','id_empresa_proveedora');
				$crud->required_fields('tipo','descripcion','estado','fecha_ingreso','id_unidad','id_empresa_proveedora');
			}else{
				$crud->edit_fields('tipo','descripcion','estado','fecha_ingreso','fecha_baja','id_item_relacionado','id_unidad','id_empresa_proveedora','id_empresa_reparadora','id_empresa_desechadora');
				$crud->required_fields('tipo','descripcion','fecha_ingreso','id_unidad','id_empresa_proveedora');
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

		$crud->columns('id','tipo','descripcion','estado','fecha_ingreso','fecha_baja','veces_reparacion','id_item_relacionado','id_unidad','id_empresa_proveedora','id_empresa_reparadora','id_empresa_desechadora');

		//Cambiar nombre de atributo de la DB, por uno más apropiado para el usuario
		$crud->display_as('id','ID');
		$crud->display_as('veces_reparacion','Número Reparaciones');
		$crud->display_as('id_item_relacionado','ID Item Rel.');
		$crud->display_as('id_unidad','Unidad');
		$crud->display_as('id_empresa_proveedora','Emp. Proveedora');
		$crud->display_as('id_empresa_reparadora','Emp. Reparadora');
		$crud->display_as('id_empresa_desechadora','Emp. Desechadora');
		$crud->display_as('tipo','Tipo de Producto');

		//Relaciones
		$crud->set_relation('id_item_relacionado','item','descripcion');
		$crud->set_relation('id_unidad','unidad','nombre');		
		$crud->set_relation('id_empresa_proveedora','empresa_externa','nombre');
		$crud->set_relation('id_empresa_reparadora','empresa_externa','nombre');
		$crud->set_relation('id_empresa_desechadora','empresa_externa','nombre');

		//El campo 'estado' es de tipo DROPDOWN
		$crud->field_type('estado','dropdown',array('ACTIVO' => 'ACTIVO' ,
													'REPARACION' => 'REPARACION',
													'EN TRANSITO' => 'EN TRANSITO',
													'DE BAJA' => 'DE BAJA'));

		$crud->add_fields('tipo','descripcion','fecha_ingreso','id_unidad','id_empresa_proveedora');

		//Si se está editando...
		if($crud->getState()=='edit'){
			$tipo=null;

			//Se consulta el tipo del item que se va a editar...
			$auxiliar['valor']=$this->grocery_crud->getStateInfo()->primary_key;
			$datos['respuesta_db']=$this->Administrador_Model->consultar_tipo_item($auxiliar);

			//Se capta el resultado...
			foreach ($datos['respuesta_db'] -> result() as $atributo) {
				$tipo=$atributo->tipo;
			}

			if($tipo=='EQUIPO'){
				$crud->edit_fields('tipo','descripcion','fecha_ingreso','id_unidad','id_empresa_proveedora');
				$crud->required_fields('tipo','descripcion','estado','fecha_ingreso','id_unidad','id_empresa_proveedora');
			}else{
				$crud->edit_fields('tipo','descripcion','estado','fecha_ingreso','fecha_baja','id_item_relacionado','id_unidad','id_empresa_proveedora','id_empresa_reparadora','id_empresa_desechadora');
				$crud->required_fields('tipo','descripcion','fecha_ingreso','id_unidad','id_empresa_proveedora');
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
		$crud->columns('id_componente','descripcion','tipo','estado','fecha_ingreso','fecha_baja','veces_reparacion','id_equipo_relacionado','id_pieza_nueva','id_empresa_reparadora','id_empresa_desechadora');
		$crud->required_fields('nombre_asignatura');
		
		$crud->display_as('id_componente','ID');
		$crud->display_as('veces_reparacion','Número Reparaciones');
		$crud->display_as('id_equipo_relacionado','ID Equipo');
		$crud->display_as('id_pieza_nueva','ID Pieza');
		$crud->display_as('id_empresa_reparadora','ID Emp. Reparadora');
		$crud->display_as('id_empresa_desechadora','ID Emp. Desechadora');
		$crud->display_as('tipo','Tipo de Producto');

		$crud->field_type('estado','dropdown',array('ACTIVO' => 'ACTIVO',
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

		$crud->columns('id','tipo','descripcion','estado','fecha_ingreso','fecha_baja','veces_reparacion','id_item_relacionado','id_unidad','id_empresa_proveedora','id_empresa_reparadora','id_empresa_desechadora');

		$crud->display_as('id','ID');
		$crud->display_as('veces_reparacion','Número Reparaciones');
		$crud->display_as('id_item_relacionado','ID Item Rel.');
		$crud->display_as('id_unidad','Unidad');
		$crud->display_as('id_empresa_proveedora','Emp. Proveedora');
		$crud->display_as('id_empresa_reparadora','Emp. Reparadora');
		$crud->display_as('id_empresa_desechadora','Emp. Desechadora');
		$crud->display_as('tipo','Tipo de Producto');

		$crud->set_relation('id_item_relacionado','item','descripcion');
		$crud->set_relation('id_unidad','unidad','nombre');		
		$crud->set_relation('id_empresa_proveedora','empresa_externa','nombre');
		$crud->set_relation('id_empresa_reparadora','empresa_externa','nombre');
		$crud->set_relation('id_empresa_desechadora','empresa_externa','nombre');

		$crud->callback_add_field('tipo',array($this,'callback_to_upper'));
		$crud->callback_before_insert(array($this,'prepare'));

		$crud->field_type('estado','dropdown',array('ACTIVO' => 'ACTIVO',
													'REPARACION' => 'REPARACION',
													'EN TRANSITO' => 'EN TRANSITO',
													'DE BAJA' => 'DE BAJA'));
		
		$crud->add_fields('tipo','descripcion','fecha_ingreso','id_unidad','id_empresa_proveedora');

		//Comentado en siguiente función, es el mismo funcionamiento
		if($crud->getState()=='edit'){
			$tipo=null;

			$auxiliar['valor']=$this->grocery_crud->getStateInfo()->primary_key;
			$datos['respuesta_db']=$this->Administrador_Model->consultar_tipo_item($auxiliar);

			foreach ($datos['respuesta_db'] -> result() as $atributo) {
				$tipo=$atributo->tipo;
			}
			if($tipo=='EQUIPO'){
				$crud->edit_fields('descripcion','fecha_ingreso','id_unidad','id_empresa_proveedora');
				$crud->required_fields('descripcion','estado','fecha_ingreso','id_unidad','id_empresa_proveedora');
			}else{
				$crud->edit_fields('descripcion','estado','fecha_ingreso','fecha_baja','id_item_relacionado','id_unidad','id_empresa_proveedora','id_empresa_reparadora','id_empresa_desechadora');
				$crud->required_fields('descripcion','fecha_ingreso','id_unidad','id_empresa_proveedora');
			}
		}
		$crud->columns('id','tipo','descripcion','estado','fecha_ingreso','fecha_baja','veces_reparacion','id_item_relacionado','id_unidad','id_empresa_proveedora','id_empresa_reparadora','id_empresa_desechadora');
		
		if ($this->input->post('unidad-post')!=null){
			//echo "si";
			$id_post=$this->input->post('unidad-post');
			$crud->where('item.id_unidad',$id_post);
		}
		
		$output = $crud->render();
		$output->datos=$datos;

		$this->load->view('administrador/itemsForUnit/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/itemsForUnit/body',$output);
	}
	function callback_to_upper(){
		return '<input id="field-tipo" type="text" class="form-control" name="tipo" style="text-transform:uppercase;">';
	}
	public function prepare($post_array){
		$post_array['tipo'] = strtoupper(trim($post_array['tipo']));
		return $post_array;
	}

	public function historico(){
		$crud= new grocery_CRUD();
		$crud->set_theme('bootstrap');
		$crud->set_table('historico_item');
		$crud->set_subject('Histórico');

		$crud->set_relation("id_item","item","descripcion");

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
				$HTML.="<option value='".$atributo->id."'>".$atributo->nombre."</option>";
			}
		}
		echo $HTML;
	}

	public function avisos(){
		$crud= new grocery_CRUD();
		$crud->set_theme('bootstrap');
		$crud->set_table('aviso_problema');
		$crud->set_subject('Aviso Problemas');

		$crud->unset_add();

		$crud->set_relation("item_relacionado","item","descripcion");
		$output = $crud->render();
		$this->load->view('administrador/head',$output);
		$this->load->view('administrador/header');
		$this->load->view('administrador/aside');
		$this->load->view('administrador/body',$output);
	}
}
