-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-08-2016 a las 19:50:36
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto_software_uno`
--

DELIMITER $$
--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `validate_rut` (`RUT` VARCHAR(12)) RETURNS INT(11) BEGIN
	DECLARE strlen INT;
	DECLARE i INT;
	DECLARE j INT;
	DECLARE suma NUMERIC;
	DECLARE temprut VARCHAR(12);
	DECLARE verify_dv CHAR(2);
	DECLARE DV CHAR(1);
	SET RUT = REPLACE(REPLACE(RUT, '.', ''),'-','');
	SET DV = SUBSTR(RUT,-1,1);
	SET RUT = SUBSTR(RUT,1,LENGTH(RUT)-1);
	SET i = 1;
  	SET strlen = LENGTH(RUT);
  	SET j = 2;
  	SET suma = 0;
	IF strlen = 8 OR strlen = 7 THEN
		SET temprut = REVERSE(RUT);
		moduloonce: LOOP
		    IF i <= LENGTH(temprut) THEN
    			SET suma = suma + (CONVERT(SUBSTRING(temprut, i, 1),UNSIGNED INTEGER) * j); 
	      		SET i = i + 1;
	      		IF j = 7 THEN
		    		SET j = 2;
	    		ELSE
	    			SET j = j + 1;
    			END IF;
	      		ITERATE moduloonce;
		    END IF;
		    LEAVE moduloonce;
	  	END LOOP moduloonce;
	  	SET verify_dv = 11 - (suma % 11);
	  	IF verify_dv = 11 THEN
	  		SET verify_dv = 0;
	  	ELSEIF verify_dv = 10 THEN 
	  		SET verify_dv = 'K';
	  	END IF;
	  	IF DV = verify_dv THEN
	  		RETURN 1;
	  	ELSE 
	  		RETURN 0;
	  	END IF;
	END IF;
	RETURN 0;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `rut_admin` varchar(12) NOT NULL,
  `nombre_admin` varchar(250) DEFAULT NULL,
  `pass_admin` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`rut_admin`, `nombre_admin`, `pass_admin`) VALUES
('11111111-1', 'Juan', '123');

--
-- Disparadores `administrador`
--
DELIMITER $$
CREATE TRIGGER `validar_rut_admin` BEFORE INSERT ON `administrador` FOR EACH ROW BEGIN
	IF validate_rut(new.rut_admin)=0 THEN
   		SIGNAL SQLSTATE '45000'
      	SET MESSAGE_TEXT = 'RUT ISSUE';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aviso_problema`
--

CREATE TABLE `aviso_problema` (
  `id_aviso` int(11) NOT NULL,
  `tipo_aviso` varchar(250) NOT NULL,
  `item_relacionado_aviso` varchar(250) NOT NULL,
  `descripcion_aviso` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `aviso_problema`
--

INSERT INTO `aviso_problema` (`id_aviso`, `tipo_aviso`, `item_relacionado_aviso`, `descripcion_aviso`) VALUES
(1, 'HOLA', '', '<p>\r\n	asdasdsa</p>\r\n'),
(2, 'asdasdas', '', '<p>\r\n	qeqwewqe</p>\r\n'),
(3, 'Problema 1', '1', 'asdf'),
(4, 'VIBRACIÓN/RUIDO GABINETE', '1', 'Holamundo'),
(5, 'PC NO ENCIENDE', '1', 'asdasdsadsadasdasd'),
(6, 'PC NO ENCIENDE', '1', 'qwerty'),
(7, 'PC NO ENCIENDE', '1', '1234'),
(8, 'PC NO ENCIENDE', '1', 'zxcv'),
(9, 'PC NO ENCIENDE', '1', '123'),
(10, 'VENTANAS DE ERRORES', '1', 'zxcxzc'),
(11, 'PC NO ENCIENDE', '1', 'zxcvfdsf');

--
-- Disparadores `aviso_problema`
--
DELIMITER $$
CREATE TRIGGER `aviso_historico` AFTER INSERT ON `aviso_problema` FOR EACH ROW insert into historico_item(id_item_hi,fecha_hi,descripcion_hi) VALUES
(new.item_relacionado_aviso,now(),concat('Se agregó aviso, item id=',new.item_relacionado_aviso,', problema=',new.tipo_aviso,', descripcion=',new.descripcion_aviso))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `id_depto` int(11) NOT NULL,
  `nombre_depto` varchar(250) DEFAULT NULL,
  `ubicacion_depto` varchar(250) NOT NULL,
  `id_facultad_depto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`id_depto`, `nombre_depto`, `ubicacion_depto`, `id_facultad_depto`) VALUES
(1, 'INFORMATICA', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa_externa`
--

CREATE TABLE `empresa_externa` (
  `id_ex` int(11) NOT NULL,
  `tipo_ex` varchar(250) DEFAULT NULL,
  `ubicacion_ex` varchar(250) DEFAULT NULL,
  `nombre_ex` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo`
--

CREATE TABLE `equipo` (
  `id_cpt` int(11) NOT NULL,
  `descripcion_cpt` varchar(250) DEFAULT NULL,
  `tipo_cpt` varchar(250) DEFAULT NULL,
  `estado_cpt` varchar(250) DEFAULT NULL,
  `fecha_ingreso_cpt` datetime DEFAULT NULL,
  `fecha_baja_cpt` datetime DEFAULT NULL,
  `veces_reparacion_cpt` int(11) DEFAULT NULL,
  `id_equipo_relacionado_cpt` int(11) DEFAULT NULL,
  `id_pieza_nueva_cpt` int(11) DEFAULT NULL,
  `id_empresa_reparadora_cpt` int(11) DEFAULT NULL,
  `id_empresa_desechadora_cpt` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `equipo`
--

INSERT INTO `equipo` (`id_cpt`, `descripcion_cpt`, `tipo_cpt`, `estado_cpt`, `fecha_ingreso_cpt`, `fecha_baja_cpt`, `veces_reparacion_cpt`, `id_equipo_relacionado_cpt`, `id_pieza_nueva_cpt`, `id_empresa_reparadora_cpt`, `id_empresa_desechadora_cpt`) VALUES
(1, NULL, 'MONITOR', 'ACTIVO', '2016-08-10 00:00:00', NULL, 0, 1, NULL, NULL, NULL),
(2, NULL, 'MOUSE', 'ACTIVO', '2016-08-10 00:00:00', NULL, 0, 1, NULL, NULL, NULL),
(3, NULL, 'TECLADO', 'ACTIVO', '2016-08-10 00:00:00', NULL, 0, 1, NULL, NULL, NULL),
(4, NULL, 'RAM', 'ACTIVO', '2016-08-10 00:00:00', NULL, 0, 1, NULL, NULL, NULL),
(5, NULL, 'PROCESADOR', 'ACTIVO', '2016-08-10 00:00:00', NULL, 0, 1, NULL, NULL, NULL),
(6, NULL, 'HDD', 'ACTIVO', '2016-08-10 00:00:00', NULL, 0, 1, NULL, NULL, NULL),
(7, NULL, 'MOTHERBOARD', 'ACTIVO', '2016-08-10 00:00:00', NULL, 0, 1, NULL, NULL, NULL),
(8, NULL, 'FUENTE PODER', 'ACTIVO', '2016-08-10 00:00:00', NULL, 0, 1, NULL, NULL, NULL);

--
-- Disparadores `equipo`
--
DELIMITER $$
CREATE TRIGGER `cambiar_estado_componente` BEFORE UPDATE ON `equipo` FOR EACH ROW BEGIN
		IF NOT(NEW.estado_cpt <=> OLD.estado_cpt) THEN
      INSERT into historico_item(id_item_hi,id_componente_hi,fecha_hi,descripcion_hi)
      VALUES(old.id_equipo_relacionado_cpt,old.id_cpt,now(),concat("Se actualizó estado equipo id=",old.id_cpt," de PC id=",old.id_equipo_relacionado_cpt," de",old.estado_cpt," a ",new.estado_cpt));
			IF NEW.estado_cpt='REPARACION' THEN
				SET NEW.veces_reparacion_cpt=OLD.veces_reparacion_cpt+1;

				UPDATE item
				SET veces_reparacion_item=veces_reparacion_item+1
				WHERE id_item=OLD.id_equipo_relacionado_cpt;

				IF old.id_pieza_nueva_cpt IS NOT NULL THEN
					UPDATE item
					SET veces_reparacion_item=veces_reparacion_item+1
					WHERE id_item=OLD.id_pieza_nueva_cpt;
				END IF;
			END IF;
			IF NEW.estado_cpt='DE BAJA' THEN
				SET NEW.fecha_baja_cpt=now();
			END IF;
		END IF;
	END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cambiar_estado_componente_i` AFTER UPDATE ON `equipo` FOR EACH ROW BEGIN
		DECLARE num_rep INT default 0;
		DECLARE num_tran INT default 0;
		DECLARE num_baj INT default 0;
		DECLARE total INT default 0;
		DECLARE sum INT default 0;
		SELECT COUNT(*) INTO num_rep FROM equipo WHERE estado_cpt='REPARACION' AND id_equipo_relacionado_cpt=old.id_equipo_relacionado_cpt;
		SELECT COUNT(*) INTO num_tran FROM equipo WHERE estado_cpt='EN TRANSITO' AND id_equipo_relacionado_cpt=old.id_equipo_relacionado_cpt;
		SELECT COUNT(*) INTO num_baj FROM equipo WHERE estado_cpt='DE BAJA' AND id_equipo_relacionado_cpt=old.id_equipo_relacionado_cpt;
		SELECT COUNT(*) INTO total FROM equipo WHERE id_equipo_relacionado_cpt=old.id_equipo_relacionado_cpt;

		set sum=num_rep+num_tran;

		if num_baj=total THEN
			update item
			set estado_item='DE BAJA'
			where id_item=old.id_equipo_relacionado_cpt;
		else
			IF sum>0 THEN
				IF num_rep>0 THEN
					update item
					set estado_item='REPARACION'
					where id_item=old.id_equipo_relacionado_cpt;
				ELSE 
					IF num_tran>0 THEN
						update item
						set estado_item='EN TRANSITO'
						where id_item=old.id_equipo_relacionado_cpt;
					END IF;
				END IF; 
			else 
				update item
				set estado_item='ACTIVO'
				where id_item=old.id_equipo_relacionado_cpt;
			end if;
		end if;
	END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `equipo_historico` BEFORE INSERT ON `equipo` FOR EACH ROW BEGIN
	insert into historico_item(id_item_hi,id_componente_hi,fecha_hi,descripcion_hi)
		values(new.id_equipo_relacionado_cpt,new.id_pieza_nueva_cpt,now(),concat("Se agregó ",new.tipo_cpt,", componente ID=",new.id_cpt,", relacionado con PC ID=",new.id_equipo_relacionado_cpt,", pieza origen ID=",new.id_pieza_nueva_cpt));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facultad`
--

CREATE TABLE `facultad` (
  `id_facultad` int(11) NOT NULL,
  `nombre_facultad` varchar(250) DEFAULT NULL,
  `ubicacion_facultad` varchar(250) NOT NULL,
  `id_universidad_facultad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `facultad`
--

INSERT INTO `facultad` (`id_facultad`, `nombre_facultad`, `ubicacion_facultad`, `id_universidad_facultad`) VALUES
(1, 'INGENIERIA', 'Allí', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historico_item`
--

CREATE TABLE `historico_item` (
  `id_hi` int(11) NOT NULL,
  `id_item_hi` int(11) NOT NULL,
  `id_componente_hi` int(11) NOT NULL,
  `fecha_hi` datetime NOT NULL,
  `descripcion_hi` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `historico_item`
--

INSERT INTO `historico_item` (`id_hi`, `id_item_hi`, `id_componente_hi`, `fecha_hi`, `descripcion_hi`) VALUES
(1, 1, 0, '2016-08-14 17:13:41', 'Se agregó PC id=1 y sus componentes'),
(2, 2, 0, '2016-08-14 17:14:19', 'Se agregó RAM id=2'),
(3, 0, 0, '2016-08-14 17:15:04', 'Se agregó aviso, item id=, problema=HOLA, descripcion=<p>\r\n	asdasdsa</p>\r\n'),
(4, 0, 0, '2016-08-14 17:15:12', 'Se agregó aviso, item id=, problema=asdasdas, descripcion=<p>\r\n	qeqwewqe</p>\r\n'),
(5, 1, 0, '2016-08-15 02:16:38', 'Se agregó aviso, item id=1, problema=Problema 1, descripcion=asdf'),
(6, 1, 0, '2016-08-15 02:47:35', 'Se agregó aviso, item id=1, problema=VIBRACIÓN/RUIDO GABINETE, descripcion=Holamundo'),
(7, 1, 0, '2016-08-15 02:51:52', 'Se agregó aviso, item id=1, problema=PC NO ENCIENDE, descripcion=asdasdsadsadasdasd'),
(8, 1, 0, '2016-08-15 02:52:51', 'Se agregó aviso, item id=1, problema=PC NO ENCIENDE, descripcion=qwerty'),
(9, 1, 0, '2016-08-15 02:53:04', 'Se agregó aviso, item id=1, problema=PC NO ENCIENDE, descripcion=1234'),
(10, 1, 0, '2016-08-15 02:53:53', 'Se agregó aviso, item id=1, problema=PC NO ENCIENDE, descripcion=zxcv'),
(11, 1, 0, '2016-08-15 02:55:05', 'Se agregó aviso, item id=1, problema=PC NO ENCIENDE, descripcion=123'),
(12, 1, 0, '2016-08-15 02:55:25', 'Se agregó aviso, item id=1, problema=VENTANAS DE ERRORES, descripcion=zxcxzc'),
(13, 1, 0, '2016-08-15 02:55:39', 'Se agregó aviso, item id=1, problema=PC NO ENCIENDE, descripcion=zxcvfdsf'),
(14, 1, 2, '2016-08-15 14:41:02', 'Se agregó RAM, componente ID=0, relacionado con PC ID=1, pieza origen ID=2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `item`
--

CREATE TABLE `item` (
  `id_item` int(11) NOT NULL,
  `tipo_item` varchar(250) DEFAULT NULL,
  `descripcion_item` varchar(250) DEFAULT NULL,
  `estado_item` varchar(250) DEFAULT NULL,
  `fecha_ingreso_item` datetime DEFAULT NULL,
  `fecha_baja_item` datetime DEFAULT NULL,
  `veces_reparacion_item` int(11) DEFAULT '0',
  `id_item_relacionado_item` int(11) DEFAULT NULL,
  `id_unidad_item` int(11) DEFAULT NULL,
  `id_empresa_proveedora_item` int(11) DEFAULT NULL,
  `id_empresa_reparadora_item` int(11) DEFAULT NULL,
  `id_empresa_desechadora_item` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `item`
--

INSERT INTO `item` (`id_item`, `tipo_item`, `descripcion_item`, `estado_item`, `fecha_ingreso_item`, `fecha_baja_item`, `veces_reparacion_item`, `id_item_relacionado_item`, `id_unidad_item`, `id_empresa_proveedora_item`, `id_empresa_reparadora_item`, `id_empresa_desechadora_item`) VALUES
(1, 'EQUIPO', 'PC01', 'ACTIVO', '2016-08-10 00:00:00', NULL, 0, NULL, 1, NULL, NULL, NULL),
(2, 'RAM', 'RAM 1GB', 'ACTIVO', '2016-08-16 00:00:00', NULL, 0, NULL, 2, NULL, NULL, NULL);

--
-- Disparadores `item`
--
DELIMITER $$
CREATE TRIGGER `agregar_componentes_equipo` AFTER INSERT ON `item` FOR EACH ROW BEGIN
		IF NEW.tipo_item='EQUIPO' THEN 
			INSERT INTO equipo(tipo_cpt,estado_cpt,fecha_ingreso_cpt,veces_reparacion_cpt,id_equipo_relacionado_cpt)
			VALUES('MONITOR','ACTIVO',NEW.fecha_ingreso_item,0,NEW.id_item)	;
			INSERT INTO equipo(tipo_cpt,estado_cpt,fecha_ingreso_cpt,veces_reparacion_cpt,id_equipo_relacionado_cpt)
			VALUES('MOUSE','ACTIVO',NEW.fecha_ingreso_item,0,NEW.id_item);
			INSERT INTO equipo(tipo_cpt,estado_cpt,fecha_ingreso_cpt,veces_reparacion_cpt,id_equipo_relacionado_cpt)
			VALUES('TECLADO','ACTIVO',NEW.fecha_ingreso_item,0,NEW.id_item);
			INSERT INTO equipo(tipo_cpt,estado_cpt,fecha_ingreso_cpt,veces_reparacion_cpt,id_equipo_relacionado_cpt)
			VALUES('RAM','ACTIVO',NEW.fecha_ingreso_item,0,NEW.id_item);
			INSERT INTO equipo(tipo_cpt,estado_cpt,fecha_ingreso_cpt,veces_reparacion_cpt,id_equipo_relacionado_cpt)
			VALUES('PROCESADOR','ACTIVO',NEW.fecha_ingreso_item,0,NEW.id_item);
			INSERT INTO equipo(tipo_cpt,estado_cpt,fecha_ingreso_cpt,veces_reparacion_cpt,id_equipo_relacionado_cpt)
			VALUES('HDD','ACTIVO',NEW.fecha_ingreso_item,0,NEW.id_item);
			INSERT INTO equipo(tipo_cpt,estado_cpt,fecha_ingreso_cpt,veces_reparacion_cpt,id_equipo_relacionado_cpt)
			VALUES('MOTHERBOARD','ACTIVO',NEW.fecha_ingreso_item,0,NEW.id_item);
			INSERT INTO equipo(tipo_cpt,estado_cpt,fecha_ingreso_cpt,veces_reparacion_cpt,id_equipo_relacionado_cpt)
			VALUES('FUENTE PODER','ACTIVO',NEW.fecha_ingreso_item,0,NEW.id_item);

      INSERT into historico_item(id_item_hi,fecha_hi,descripcion_hi)
      VALUES(new.id_item,now(),concat("Se agregó PC id=",new.id_item," y sus componentes"));
		ELSE
      INSERT into historico_item(id_item_hi,fecha_hi,descripcion_hi)
      VALUES(new.id_item,now(),concat("Se agregó ",new.tipo_item," id=",new.id_item));
    END IF;


	END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cambiar_estado_item` BEFORE UPDATE ON `item` FOR EACH ROW BEGIN
		DECLARE variable int;
		IF NOT(NEW.estado_item <=>  OLD.estado_item) THEN
      insert into historico_item(id_item_hi,fecha_hi,descripcion_hi)
      values(old.id_item,now(),concat("Se actualizó estado item id=",old.id_item," de ",old.estado_item," a ",new.estado_item));
			IF NEW.estado_item='REPARACION' THEN
			
				IF OLD.tipo_item!='EQUIPO' THEN
					SET NEW.veces_reparacion_item=OLD.veces_reparacion_item+1;
				END IF;
			END IF;
			IF NEW.estado_item='DE BAJA' THEN
				IF OLD.tipo_item!='EQUIPO' THEN
					SET NEW.fecha_baja_item=now();
				END IF;
			END IF;
		END IF;
		IF NOT(NEW.fecha_baja_item <=> OLD.fecha_baja_item) THEN
			SET NEW.estado_item='DE BAJA';
		END IF;
		IF NOT(NEW.id_item_relacionado_item <=> OLD.id_item_relacionado_item) THEN
			SELECT count(*) INTO variable FROM equipo WHERE id_pieza_nueva_cpt=OLD.id_item;
			IF variable=0 THEN 
				INSERT into equipo(tipo_cpt,estado_cpt,fecha_ingreso_cpt,veces_reparacion_cpt,id_equipo_relacionado_cpt,id_pieza_nueva_cpt)
				values(OLD.tipo_item,OLD.estado_item,now(),OLD.veces_reparacion_item,NEW.id_item_relacionado_item,OLD.id_item);
			END IF;
			If new.id_item_relacionado_item is null THEN
				delete from equipo where id_pieza_nueva_cpt=old.id_item;
			end if;
		END IF;
	END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertar_item` BEFORE INSERT ON `item` FOR EACH ROW BEGIN
	set new.estado_item='ACTIVO';
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad`
--

CREATE TABLE `unidad` (
  `id_unidad` int(11) NOT NULL,
  `nombre_unidad` varchar(250) DEFAULT NULL,
  `ubicacion_unidad` varchar(250) NOT NULL,
  `id_depto_unidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `unidad`
--

INSERT INTO `unidad` (`id_unidad`, `nombre_unidad`, `ubicacion_unidad`, `id_depto_unidad`) VALUES
(1, 'DCI1', '', 1),
(2, 'DCI2', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `universidad`
--

CREATE TABLE `universidad` (
  `id_uni` int(11) NOT NULL,
  `nombre_uni` varchar(250) DEFAULT NULL,
  `ubicacion_uni` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `universidad`
--

INSERT INTO `universidad` (`id_uni`, `nombre_uni`, `ubicacion_uni`) VALUES
(3, 'UCM', ''),
(4, 'INACAP', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `rut_usuario` varchar(12) NOT NULL,
  `nombre_usuario` varchar(250) DEFAULT NULL,
  `pass_usuario` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`rut_usuario`, `nombre_usuario`, `pass_usuario`) VALUES
('18123456-3', 'Juan 2', '123');

--
-- Disparadores `usuario`
--
DELIMITER $$
CREATE TRIGGER `validar_rut_usuario` BEFORE INSERT ON `usuario` FOR EACH ROW BEGIN
	IF validate_rut(new.rut_usuario)=0 THEN
   		SIGNAL SQLSTATE '45000'
      	SET MESSAGE_TEXT = 'RUT ISSUE';
    END IF;
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`rut_admin`);

--
-- Indices de la tabla `aviso_problema`
--
ALTER TABLE `aviso_problema`
  ADD PRIMARY KEY (`id_aviso`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`id_depto`);

--
-- Indices de la tabla `empresa_externa`
--
ALTER TABLE `empresa_externa`
  ADD PRIMARY KEY (`id_ex`);

--
-- Indices de la tabla `equipo`
--
ALTER TABLE `equipo`
  ADD PRIMARY KEY (`id_cpt`);

--
-- Indices de la tabla `facultad`
--
ALTER TABLE `facultad`
  ADD PRIMARY KEY (`id_facultad`);

--
-- Indices de la tabla `historico_item`
--
ALTER TABLE `historico_item`
  ADD PRIMARY KEY (`id_hi`);

--
-- Indices de la tabla `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id_item`);

--
-- Indices de la tabla `unidad`
--
ALTER TABLE `unidad`
  ADD PRIMARY KEY (`id_unidad`);

--
-- Indices de la tabla `universidad`
--
ALTER TABLE `universidad`
  ADD PRIMARY KEY (`id_uni`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`rut_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aviso_problema`
--
ALTER TABLE `aviso_problema`
  MODIFY `id_aviso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `id_depto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `empresa_externa`
--
ALTER TABLE `empresa_externa`
  MODIFY `id_ex` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `equipo`
--
ALTER TABLE `equipo`
  MODIFY `id_cpt` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT de la tabla `facultad`
--
ALTER TABLE `facultad`
  MODIFY `id_facultad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `historico_item`
--
ALTER TABLE `historico_item`
  MODIFY `id_hi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT de la tabla `item`
--
ALTER TABLE `item`
  MODIFY `id_item` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `unidad`
--
ALTER TABLE `unidad`
  MODIFY `id_unidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `universidad`
--
ALTER TABLE `universidad`
  MODIFY `id_uni` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
