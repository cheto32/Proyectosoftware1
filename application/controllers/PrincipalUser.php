<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class PrincipalUser extends CI_Controller {

	public function __construct(){
		parent::__construct();

		$this->load->database();
		$this->load->helper("url_helper");
		$this->load->helper("url");
		$this->load->library('Grocery_CRUD');
		$this->load->library("session");
		$this->load->model("Grocery_crud_model"); 
		$this->load->model("User_Model");
	}


	public function index(){
		$this->load->view('user/index/head');
		$this->load->view('user/header');
		$this->load->view('user/aside');
		$this->load->view('user/index/body');

	}

	public function error(){
		$this->load->view("errors/head");
		$this->load->view("errors/body");
	}


	public function itemsForUnit(){

		$id_post=$_POST['id_post'];

		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('item');
		$crud->where('item.id_unidad_item',$id_post);
		$crud->set_subject('Items');

		$crud->columns('id_item','codigo_externo','tipo_item','descripcion_item','estado_item','fecha_ingreso_item','fecha_baja_item','veces_reparacion_item','id_item_relacionado_item','id_unidad_item','id_empresa_proveedora_item','id_empresa_reparadora_item','id_empresa_desechadora_item');

		//Cambiar nombre de atributo de la DB, por uno más apropiado para el usuario

		$crud->display_as('id_item','ID');
		$crud->display_as('codigo_externo','Codigo Externo');
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

		$crud->callback_add_field('tipo_item',array($this,'callback_to_upper'));
		$crud->callback_before_insert(array($this,'prepare'));

		//El campo 'estado' es de tipo DROPDOWN
		$crud->field_type('estado_item','dropdown',array('ACTIVO' => 'ACTIVO' ,
													'REPARACION' => 'REPARACION',
													'EN TRANSITO' => 'EN TRANSITO',
													'DE BAJA' => 'DE BAJA'));

		

		if($crud->getState()=='add'){
			$crud->set_relation('id_item_relacionado_item','item','descripcion_item');
			$crud->add_fields('codigo_externo','tipo_item','descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
			$crud->required_fields('tipo_item','fecha_ingreso_item');
		}
		//Si se está editando...
		if($crud->getState()=='edit'){
			$crud->set_relation('id_item_relacionado_item','item','descripcion_item');
			$tipo=null;

			//Se consulta el tipo del item que se va a editar...
			$auxiliar['valor']=$this->grocery_crud->getStateInfo()->primary_key;
			$datos['respuesta_db']=$this->User_Model->consultar_tipo_item($auxiliar);
			$datos['respuesta_db_1']=$this->User_Model->consultar_item_relacionado($auxiliar);

			foreach ($datos['respuesta_db_1'] -> result() as $atributo1) {
				$id_item_rel=$atributo1->id_item_relacionado_item;
			}

			//Se capta el resultado...
			foreach ($datos['respuesta_db'] -> result() as $atributo) {
				$tipo=$atributo->tipo_item;
			}

			if($tipo=='EQUIPO'){
				$crud->edit_fields('descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item','id_empresa_reparadora_item','id_empresa_desechadora_item');
			}else{
				if($id_item_rel!=null){

					$crud->edit_fields('descripcion_item','fecha_ingreso_item','id_empresa_proveedora_item','id_item_relacionado_item','id_unidad_item','id_empresa_proveedora_item','id_empresa_reparadora_item','id_empresa_desechadora_item');

				}else{
					$crud->edit_fields('descripcion_item','id_item_relacionado_item','estado_item','fecha_ingreso_item','fecha_baja_item','id_unidad_item','id_empresa_proveedora_item','id_empresa_reparadora_item','id_empresa_desechadora_item');
				}	
			}
		}

		$output = $crud->render();
		$this->load->view('user/head',$output);
		$this->load->view('user/header');
		$this->load->view('user/aside');
		$this->load->view('user/body',$output);
	}


	public function equipo(){
		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('equipo');
		$crud->set_subject('Equipos');

		$crud->unset_add();
		$crud->unset_delete();

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

		if($crud->getState()=='edit'){

			$crud->edit_fields('descripcion_cpt','estado_cpt','fecha_ingreso_cpt','fecha_baja_cpt','id_empresa_reparadora_cpt','id_empresa_desechadora_cpt');
		}
		
		$output = $crud->render();
	
		$this->load->view('user/head',$output);
		$this->load->view('user/header');
		$this->load->view('user/aside');
		$this->load->view('user/body',$output);
	}

	public function item_comboboxes(){
		
		$datos['respuesta_uni']=$this->User_Model->getUniversidad();

		$crud = new grocery_CRUD();
		$crud->set_theme('bootstrap');

		$crud->set_table('item');
		$crud->set_subject('Inventario');

		$crud->columns('id_item','codigo_externo','tipo_item','descripcion_item','estado_item','fecha_ingreso_item','fecha_baja_item','veces_reparacion_item','id_item_relacionado_item','id_unidad_item','id_empresa_proveedora_item','id_empresa_reparadora_item','id_empresa_desechadora_item');

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
		
		if($crud->getState()=='add'){
			$crud->set_relation('id_item_relacionado_item','item','descripcion_item');
			$crud->add_fields('codigo_externo','tipo_item','descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
			$crud->required_fields('tipo_item','fecha_ingreso_item');
		}

		//Comentado en siguiente función, es el mismo funcionamiento
		if($crud->getState()=='edit'){
			$crud->set_relation('id_item_relacionado_item','item','descripcion_item');

			$tipo=null;

			//Se consulta el tipo del item que se va a editar...
			$auxiliar['valor']=$this->grocery_crud->getStateInfo()->primary_key;
			$datos['respuesta_db']=$this->User_Model->consultar_tipo_item($auxiliar);
			$datos['respuesta_db_1']=$this->User_Model->consultar_item_relacionado($auxiliar);

			foreach ($datos['respuesta_db_1'] -> result() as $atributo1) {
				$id_item_rel=$atributo1->id_item_relacionado_item;
			}

			//Se capta el resultado...
			foreach ($datos['respuesta_db'] -> result() as $atributo) {
				$tipo=$atributo->tipo_item;
			}

			if($tipo=='EQUIPO'){
				$crud->edit_fields('tipo_item','descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
				$crud->required_fields('tipo_item','descripcion_item','estado_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
			}else{
				if($id_item_rel!=null){

					$crud->edit_fields('descripcion_item','fecha_ingreso_item','fecha_baja_item','id_empresa_proveedora_item','id_item_relacionado_item','id_unidad_item','id_empresa_proveedora_item','id_empresa_reparadora_item','id_empresa_desechadora_item');

				}else{
					$crud->edit_fields('tipo_item','descripcion_item','estado_item','fecha_ingreso_item','fecha_baja_item','id_item_relacionado_item','id_unidad_item','id_empresa_proveedora_item','id_empresa_reparadora_item','id_empresa_desechadora_item');
					$crud->required_fields('tipo_item','descripcion_item','fecha_ingreso_item','id_unidad_item','id_empresa_proveedora_item');
				}	
			}
		}

		if ($this->input->post('unidad-post')!=null){
			//echo "si";
			$id_post=$this->input->post('unidad-post');
			$crud->where('item.id_unidad_item',$id_post);
		}
		
		$output = $crud->render();
		$output->datos=$datos;

		$this->load->view('user/itemsForUnit/head',$output);
		$this->load->view('user/header');
		$this->load->view('user/aside');
		$this->load->view('user/itemsForUnit/body',$output);
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

		$crud->unset_edit();

		$output = $crud->render();
		$this->load->view('user/head',$output);
		$this->load->view('user/header');
		$this->load->view('user/aside');
		$this->load->view('user/body',$output);

	}

	public function loadData(){
		$loadType=$_POST['loadType'];
		$loadId=$_POST['loadId'];

		$datos=$this->User_Model->getData($loadType,$loadId);
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

	
	public function agregar_aviso(){
		$descripcion=null;
		$id=null;
		$cadena='';
		$respuesta=$this->User_Model->items();
		foreach ($respuesta->result() as $atributo) {
			$id=$atributo->id_item;
			$descripcion=$atributo->descripcion_item;
			$aux="<option value='".$id."'>".$descripcion."</option>";
			$cadena.=$aux;
		}
		$salida['cadena']=$cadena;
		$this->load->view('user/aviso/head');
		$this->load->view('user/header');
		$this->load->view('user/aside');
		$this->load->view('user/aviso/body',$salida);
	}

	public function envio_formulario(){
		$arreglo['tipo']=$this->input->post("input_select");
		$arreglo['item']=$this->input->post("input_select_2");
		$arreglo['descripcion']=$this->input->post("input_textarea");
		if($arreglo['tipo']=='OTRO'){
			$arreglo['tipo']=$this->input->post("tipo_otro");
		}
		$respuesta=$this->User_Model->insertar_aviso_problema($arreglo);
		if ($respuesta) {
			$variable['html']="<div>Se ha enviado aviso</div>";
		}else{
			$variable['html']="<div style='color:red;'>No se ha podido enviar aviso</div>";
		}
		$this->load->view('insert/head');
		$this->load->view('insert/body',$variable);
		header("Refresh:2 ;url='".base_url()."index.php/principalUser' ");
	}	

	
}
