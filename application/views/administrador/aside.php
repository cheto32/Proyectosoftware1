<body>
  <div class="col-md-2">
    <div class="panel panel-default">
      <div class="panel-heading">Panel Administración</div>

        <div class="panel-body">
            <a id="instituciones_menu" class="color-panel" onclick="toggle_menu_1()">Mantenedores</a>
        </div>
        <ul id="instituciones" style="display: none;">
          <div class="panel-body">
            <a class="color-panel" href="<?php echo base_url()?>index.php/principalAdministrador/universidad">Universidad</a>
          </div>
          <div class="panel-body">
            <a class="color-panel" href="<?php echo base_url()?>index.php/principalAdministrador/facultad">Facultad</a>
          </div>
          <div class="panel-body">
            <a class="color-panel" href="<?php echo base_url()?>index.php/principalAdministrador/departamento">Departamento</a>
          </div>
          <div class="panel-body">
            <a class="color-panel" href="<?php echo base_url()?>index.php/principalAdministrador/unidad">Unidad</a>
          </div>
          <div class="panel-body">
            <a class="color-panel" href="<?php echo base_url()?>index.php/principalAdministrador/empresa_externa">Empresa Externa</a>
          </div>
        </ul>

        <div class="panel-body">
            <a id="instituciones_menu" class="color-panel" onclick="toggle_menu_2()">Roles</a>
        </div>
        <ul id="usuarios" style="display: none;">
          <div class="panel-body">
            <a class="color-panel" href="<?php echo base_url()?>index.php/principalAdministrador/administrador">Administrador</a>
          </div>
          <div class="panel-body">
            <a class="color-panel" href="<?php echo base_url()?>index.php/principalAdministrador/usuario">Usuario</a>
          </div>
        </ul>

        
        <div class="panel-body">
          <a class="color-panel" href="<?php echo base_url()?>index.php/principalAdministrador/equipo">Equipo</a>
        </div>
        <div class="panel-body">
          <a class="color-panel" href="<?php echo base_url()?>index.php/principalAdministrador/item_comboboxes">Inventario por Unidad</a>
        </div>
        <div class="panel-body">
          <a class="color-panel" href="<?php echo base_url()?>index.php/principalAdministrador/itemsFullList">Lista Completa Inventario</a>
        </div>
        <div class="panel-body">
          <a class="color-panel" href="<?php echo base_url()?>index.php/principalAdministrador/avisos">Avisos</a>
        </div>
        <div class="panel-body">
          <a class="color-panel" href="<?php echo base_url()?>index.php/principalAdministrador/historico">Historico</a>
        </div>
    </div>
  </div>
  