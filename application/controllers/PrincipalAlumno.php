<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class PrincipalAlumno extends CI_Controller {

	public function __construct(){
		parent::__construct();

		$this->load->database();
		$this->load->helper("url_helper");
		$this->load->helper("url");
		$this->load->library('Grocery_CRUD');
		$this->load->library("session");
		$this->load->model("Grocery_crud_model"); 
		$this->load->model("Alumno_Model");
	}


	public function index(){
		$descripcion=null;
		$id=null;
		$cadena='';
		$respuesta=$this->Alumno_Model->items();
		foreach ($respuesta->result() as $atributo) {
			$id=$atributo->id;
			$descripcion=$atributo->descripcion;
			$aux="<option value='".$id."'>".$descripcion."</option>";
			$cadena.=$aux;
		}
		$salida['cadena']=$cadena;
		$this->load->view('alumno/index/head');
		$this->load->view('alumno/header');
		$this->load->view('alumno/aside');
		$this->load->view('alumno/index/body',$salida);
	}

	public function error(){
		$this->load->view("errors/head");
		$this->load->view("errors/body");
	}
	
	public function envio_formulario(){
		$arreglo['tipo']=$this->input->post("input_select");
		$arreglo['item']=$this->input->post("input_select_2");
		$arreglo['descripcion']=$this->input->post("input_textarea");
		if($arreglo['tipo']=='OTRO'){
			$arreglo['tipo']=$this->input->post("tipo_otro");
		}
		$respuesta=$this->Alumno_Model->insertar_aviso_problema($arreglo);
		if ($respuesta) {
			echo "Se ha insertado en la tabla aviso_problema";
		}else{
			echo "No se ha insertado :(";
		}
		header("Refresh:2 ;url='".base_url()."index.php/principalAlumno' ");
	}	
}
