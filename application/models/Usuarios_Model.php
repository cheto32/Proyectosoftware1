<?php
class Usuarios_Model extends CI_Model{

	public function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function consultar_administrador($arreglo){
		$consulta="SELECT * FROM administrador WHERE
					RUT='".$arreglo['rut']."' AND
					pass='".$arreglo['pass']."'";
		$respuesta=$this->db->query($consulta);
		if($respuesta) return $respuesta;
		else return FALSE;
	}

	public function consultar_alumno($arreglo){
		$consulta="SELECT * FROM usuario WHERE
					RUT='".$arreglo['rut']."' AND
					pass='".$arreglo['pass']."'";
		$respuesta=$this->db->query($consulta);
		if($respuesta) return $respuesta;
		else return FALSE;
	}
	
}