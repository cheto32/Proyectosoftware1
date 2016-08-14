<?php
class Usuarios_Model extends CI_Model{

	public function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function consultar_administrador($arreglo){
		$consulta="SELECT * FROM administrador WHERE
					rut_admin='".$arreglo['rut']."' AND
					pass_admin='".$arreglo['pass']."'";
		$respuesta=$this->db->query($consulta);
		if($respuesta) return $respuesta;
		else return FALSE;
	}

	public function consultar_usuario($arreglo){
		$consulta="SELECT * FROM usuario WHERE
					rut_usuario='".$arreglo['rut']."' AND
					pass_usuario='".$arreglo['pass']."'";
		$respuesta=$this->db->query($consulta);
		if($respuesta) return $respuesta;
		else return FALSE;
	}
	
}