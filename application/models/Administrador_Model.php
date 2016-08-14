<?php
class Administrador_Model extends CI_Model{

	public function __construct(){
		parent::__construct();
		$this->load->database();
	}

	public function consultar_tipo_item($arreglo){
		$consulta="SELECT tipo FROM item WHERE
					id=".$arreglo['valor']."";
		$respuesta=$this->db->query($consulta);
		if($respuesta) return $respuesta;
		else return FALSE;
	}
	
	public function consultar_nombres_universidades(){
		$consulta="SELECT nombre FROM universidad";
		$respuesta=$this->db->query($consulta);
		if($respuesta) return $respuesta;
		else return FALSE;
	}

	function getUniversidad(){
		$this->db->select('id,nombre');
		$this->db->from('universidad');
		$this->db->order_by('nombre', 'asc'); 
		$query=$this->db->get();
		return $query; 
	}
	
	function getData($loadType,$loadId){
		if($loadType=="facultad"){
			$fieldList='id,nombre';
			$table='facultad';
			$fieldName='id_universidad';
			$orderByField='nombre';						
		}else{
			if ($loadType=="departamento") {
				$fieldList='id,nombre';
				$table='departamento';
				$fieldName='id_facultad';
				$orderByField='nombre';	
			}else{
				$fieldList='id,nombre';
				$table='unidad';
				$fieldName='id_depto';
				$orderByField='nombre';	
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