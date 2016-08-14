<?php
class Administrador_Model extends CI_Model{

	public function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function consultar_tipo_item($arreglo){
		$consulta="SELECT tipo_item FROM item WHERE
					id_item=".$arreglo['valor']."";
		$respuesta=$this->db->query($consulta);
		if($respuesta) return $respuesta;
		else return FALSE;
	}
	
	public function consultar_nombres_universidades(){
		$consulta="SELECT nombre_uni FROM universidad";
		$respuesta=$this->db->query($consulta);
		if($respuesta) return $respuesta;
		else return FALSE;
	}

	function getUniversidad(){
		$this->db->select('id_uni,nombre_uni');
		$this->db->from('universidad');
		$this->db->order_by('nombre_uni', 'asc'); 
		$query=$this->db->get();
		return $query; 
	}
	
	function getData($loadType,$loadId){
		if($loadType=="facultad"){
			$fieldList='id_facultad,nombre_facultad';
			$table='facultad';
			$fieldName='id_universidad_facultad';
			$orderByField='nombre_facultad';						
		}else{
			if ($loadType=="departamento") {
				$fieldList='id_depto,nombre_depto';
				$table='departamento';
				$fieldName='id_facultad_depto';
				$orderByField='nombre_depto';	
			}else{
				$fieldList='id_unidad,nombre_unidad';
				$table='unidad';
				$fieldName='id_depto_unidad';
				$orderByField='nombre_unidad';	
			}	
		}
		
		$this->db->select($fieldList);
		$this->db->from($table);
		$this->db->where($fieldName, $loadId);
		$this->db->order_by($orderByField, 'asc');
		$query=$this->db->get();
		return $query; 
	}
}