<?php
class Alumno_Model extends CI_Model{

	public function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function insertar_aviso_problema($arreglo){
		$consulta="INSERT INTO aviso_problema(tipo,item_relacionado,descripcion) 
					VALUES ('".$arreglo['tipo']."',".$arreglo['item'].",'".$arreglo['descripcion']."')";
		$respuesta=$this->db->query($consulta);
		if($respuesta) return $respuesta;
		else return FALSE;
	}
	public function items(){
		$consulta="	SELECT id,descripcion FROM ITEM
					WHERE
					tipo!='MONITOR' AND
					tipo!='MOUSE' AND
					tipo!='TECLADO' AND
					tipo!='RAM' AND
					tipo!='PROCESADOR' AND
					tipo!='HDD' AND
					tipo!='MOTHERBOARD' AND
					tipo!='FUENTE PODER'
					";
		$respuesta=$this->db->query($consulta);
		if($respuesta) return $respuesta;
		else return FALSE;
	}

}