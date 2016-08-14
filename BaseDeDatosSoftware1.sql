CREATE TABLE administrador(
	rut int primary key,
	nombre varchar(250),
	pass varchar(250)
);
CREATE TABLE alumno(
	rut int primary key,
	nombre varchar(250),
	pass varchar(250)
);

CREATE TABLE empresa_externa(
	id int not null auto_increment primary key,
	tipo varchar(250),/*si es tipo proveedor, reparador, o desechadora(?)*/
	nombre varchar(250)
);

CREATE TABLE universidad(
	id int not null auto_increment primary key,
	nombre varchar(250)
);

CREATE TABLE facultad(
	id int not null auto_increment primary key,
	nombre varchar(250),
	id_universidad int,
	foreign key(id_universidad)references universidad(id)
);

CREATE TABLE departamento(
	id int not null auto_increment primary key,
	nombre varchar(250),
	id_facultad int,
	foreign key(id_facultad) references facultad(id)
);
CREATE TABLE unidad(
	id int not null auto_increment primary key,
	nombre varchar(250),
	id_depto int,
	foreign key(id_depto)references departamento(id)
);	

CREATE TABLE item(
	id int not null auto_increment primary key,
	tipo varchar(250),
	descripcion varchar(250),
	estado varchar(250),
	fecha_ingreso datetime,
	fecha_baja datetime,
	veces_reparacion int default 0, /*si es un item que puede ser contenido por otro, este valor será el
	mismo que el que está en la tabla "equipo". pd:cada UPDATE en la tabla "equipo", para un
	componente de un pc,cambiará el estado del item(completo)(de tipo equipo) a "reparacion"*/
	id_item_relacionado int,
	id_unidad int,
	id_empresa_proveedora int,
	id_empresa_reparadora int,
	id_empresa_desechadora int,
	constraint fk_item_item foreign key(id_item_relacionado) references item(id),
	constraint fk_item_unidad foreign key(id_unidad) references unidad(id),
	constraint fk_item_empresa_proveedora
		foreign key(id_empresa_proveedora) references empresa_externa(id),
	constraint fk_item_empresa_reparadora
		foreign key(id_empresa_reparadora) references empresa_externa(id),
	constraint fk_item_empresa_desechadora
		foreign key(id_empresa_desechadora) references empresa_externa(id)
);

CREATE TABLE equipo(
	/*cada vez que se crea un item de tipo "equipo", se insertan TODOS sus componentes
	en esta tabla, estos son monitor,mouse,teclado,ram, procesador,hdd,motherboard.
	*/
	id_componente int not null auto_increment primary key,
	descripcion varchar(250),
	tipo varchar(250),/*tipo monitor, mouse,teclado,ram,procesador,hdd,motherboard*/
	estado varchar(250),
	fecha_ingreso datetime,
	fecha_baja datetime,
	veces_reparacion int,/*para saber el numero de rearaciones de cada item de un pc*/
	id_equipo_relacionado int,
	id_pieza_nueva int,
	id_empresa_reparadora int,
	id_empresa_desechadora int,
	constraint fk_equipo_item foreign key(id_equipo_relacionado) references item(id),
	constraint fk_equipo_pieza_nueva foreign key(id_pieza_nueva) references item(id),
	constraint fk_equipo_empresa_reparadora
		foreign key(id_empresa_reparadora) references empresa_externa(id),
	constraint fk_equipo_empresa_desechadora
		foreign key(id_empresa_desechadora) references empresa_externa(id)
);

CREATE TRIGGER insertar_item
	BEFORE INSERT
	ON item
	for EACH ROW
	BEGIN
		set new.estado='ACTIVO';
	END;



CREATE TRIGGER cambiar_estado_componente_i
	AFTER UPDATE
	on equipo
	for EACH ROW
	BEGIN
		DECLARE num_rep INT default 0;
		DECLARE num_baj INT default 0;
		DECLARE	num_act INT default 0;
		DECLARE sum INT default 0;
		SELECT COUNT(*) INTO num_rep FROM equipo WHERE estado='REPARACION' AND id_equipo_relacionado=old.id_equipo_relacionado;
		SELECT COUNT(*) INTO num_baj FROM equipo WHERE estado='DE BAJA' AND id_equipo_relacionado=old.id_equipo_relacionado;
		SELECT COUNT(*) INTO num_act FROM equipo WHERE estado='ACTIVO' AND id_equipo_relacionado=old.id_equipo_relacionado;
		set sum=num_rep+num_baj+num_act;
		if num_rep>0 THEN
			update item
			set estado='REPARACION'
			where id=old.id_equipo_relacionado;
		else
			update item
			set estado='ACTIVO'
			where id=old.id_equipo_relacionado;
		end if;
	END;


CREATE TRIGGER cambiar_estado_componente
	BEFORE UPDATE
	ON equipo
	FOR EACH ROW
	BEGIN
		IF NOT(NEW.estado <=> OLD.estado) THEN
			IF NEW.estado='REPARACION' THEN
				SET NEW.veces_reparacion=OLD.veces_reparacion+1;

				UPDATE item
				SET veces_reparacion=veces_reparacion+1
				WHERE id=OLD.id_equipo_relacionado;

				IF old.id_pieza_nueva IS NOT NULL THEN
					UPDATE item
					SET veces_reparacion=veces_reparacion+1
					WHERE id=OLD.id_pieza_nueva;
				END IF;

			END IF;
			IF NEW.estado='DE BAJA' THEN
				SET NEW.fecha_baja=now();
			END IF;
			IF OLD.estado='DE BAJA' AND NEW.estado!='DE BAJA' THEN
				set new.fecha_baja=null;
			END IF;
		END IF;
	END;

/*Si un item cambia a estado REPARACION (que no sea tipo EQUIPO), el item aumentará el número de reparaciones
Si un item tiene fecha de baja, entonces cambia su estado a DE BAJA
IMPORTANTE: UN ITEM TIPO EQUIPO NO PUEDE CAMBIAR DE ESTADO!, SU ESTADO DEPENDERÁ DEL ESTADO DE SUS COMPONENTES*/
CREATE TRIGGER cambiar_estado_item
	BEFORE UPDATE
	ON item
	FOR EACH ROW
	BEGIN
		DECLARE variable int;
		IF NOT(NEW.estado <=>  OLD.estado) THEN
			IF NEW.estado='REPARACION' THEN
			/*si es tipo EQUIPO, no se permite cambiar directamente desde la tabla ITEM, 
			se cambia por UPDATE de sus componentes de la tabla EQUIPO*/
				IF OLD.tipo!='EQUIPO' THEN
					SET NEW.veces_reparacion=OLD.veces_reparacion+1;
				END IF;
			END IF;
			IF NEW.estado='DE BAJA' THEN
				IF OLD.tipo!='EQUIPO' THEN
					SET NEW.fecha_baja=getdate();
				END IF;
			END IF;
		END IF;
		IF NOT(NEW.fecha_baja <=> OLD.fecha_baja) THEN
			SET NEW.estado='DE BAJA';
		END IF;
		IF NOT(NEW.id_item_relacionado <=> OLD.id_item_relacionado) THEN
			SELECT count(*) INTO variable FROM equipo WHERE id_pieza_nueva=OLD.id;
			IF variable=0 THEN 
				INSERT into equipo(tipo,estado,veces_reparacion,id_equipo_relacionado,id_pieza_nueva)
				values(OLD.tipo,OLD.estado,OLD.veces_reparacion,NEW.id_item_relacionado,OLD.id);
			END IF;
		END IF;
	END;


/*Si se agrega un item de tipo EQUIPO, se agregarán sus componentes por
separado a la tabla EQUIPO*/
CREATE TRIGGER agregar_componentes_equipo
	AFTER INSERT 
	ON item
	FOR EACH ROW
	BEGIN
		IF NEW.tipo='EQUIPO' THEN 
			INSERT INTO equipo(tipo,estado,fecha_ingreso,veces_reparacion,id_equipo_relacionado)
			VALUES('MONITOR','ACTIVO',NEW.fecha_ingreso,0,NEW.id)	;
			INSERT INTO equipo(tipo,estado,fecha_ingreso,veces_reparacion,id_equipo_relacionado)
			VALUES('MOUSE','ACTIVO',NEW.fecha_ingreso,0,NEW.id);
			INSERT INTO equipo(tipo,estado,fecha_ingreso,veces_reparacion,id_equipo_relacionado)
			VALUES('TECLADO','ACTIVO',NEW.fecha_ingreso,0,NEW.id);
			INSERT INTO equipo(tipo,estado,fecha_ingreso,veces_reparacion,id_equipo_relacionado)
			VALUES('RAM','ACTIVO',NEW.fecha_ingreso,0,NEW.id);
			INSERT INTO equipo(tipo,estado,fecha_ingreso,veces_reparacion,id_equipo_relacionado)
			VALUES('PROCESADOR','ACTIVO',NEW.fecha_ingreso,0,NEW.id);
			INSERT INTO equipo(tipo,estado,fecha_ingreso,veces_reparacion,id_equipo_relacionado)
			VALUES('HDD','ACTIVO',NEW.fecha_ingreso,0,NEW.id);
			INSERT INTO equipo(tipo,estado,fecha_ingreso,veces_reparacion,id_equipo_relacionado)
			VALUES('MOTHERBOARD','ACTIVO',NEW.fecha_ingreso,0,NEW.id);
			INSERT INTO equipo(tipo,estado,fecha_ingreso,veces_reparacion,id_equipo_relacionado)
			VALUES('FUENTE PODER','ACTIVO',NEW.fecha_ingreso,0,NEW.id);
		END IF;
	END;



/* Tabla creada para documentar cada cambio(o sea CRUD) en la tupla de items o equipo
CREATE TABLE historial(
	
	no estoy seguro de esto, esperaré a ver que se nos ocurre xD

	id_historial int primary key,
	tipo_historial varchar(250), si es un tipo, ocupará tal columna, y así sucesivamente.
	fecha_evento date,
	id_item int foreign key references item(id),
	id_item_contenido int foreign key references item(id),
	id_componente int foreign key references equipo(id_componente),
	id_empresa int foreign key references empresa_externa(id),
	id_unidad int foreign key references unidad(id),
	id_facultad int foreign key references facultad(id),
	id_departamento int foreign key references departamento(id),
	id_universidad int foreign key references universidad(id),
);

*/