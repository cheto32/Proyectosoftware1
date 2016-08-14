-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-08-2016 a las 02:16:43
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `rut_admin` int(11) NOT NULL,
  `nombre_admin` varchar(250) DEFAULT NULL,
  `pass_admin` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`rut_admin`, `nombre_admin`, `pass_admin`) VALUES
(1234, 'kari', '111'),
(18000, 'JUAN', '123');

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
(8, 'PC NO ENCIENDE', '6', 'asdasdasda'),
(9, 'PC NO ENCIENDE', '6', 'hola'),
(10, 'DESCARGA LENTA', '9', 'holi'),
(11, 'REINICIO/APAGADO AUTOMÁTICO', '8', '123');

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
(1, 'INFORMATICA', '', 1),
(2, 'CONSTRUCCION', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa_externa`
--

CREATE TABLE `empresa_externa` (
  `id_ex` int(11) NOT NULL,
  `tipo_ex` varchar(250) DEFAULT NULL,
  `ubicacion_ex` varchar(250) default NULL,
  `nombre_ex` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empresa_externa`
--

INSERT INTO `empresa_externa` (`id_ex`, `tipo_ex`,`ubicacion_ex` ,`nombre_ex`) VALUES
(1, 'PROVEEDOR','' ,'MSI'),
(2, 'DESECHOS TECNOLOGICOS','' ,'ECO_PC LTDA.'),
(3, 'REPARADOR','','SERVICIO TECNICO PC LTDA.');

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

INSERT INTO `equipo` (`id_componente_cpt`, `descripcion_cpt`, `tipo_cpt`, `estado_cpt`, `fecha_ingreso_cpt`, `fecha_baja_cpt`, `veces_reparacion_cpt`, `id_equipo_relacionado_cpt`, `id_pieza_nueva_cpt`, `id_empresa_reparadora_cpt`, `id_empresa_desechadora_cpt`) VALUES
(18, NULL, 'MONITOR', 'DE BAJA', '2016-07-13 07:26:42', '2016-07-22 10:13:27', 0, 6, NULL, NULL, NULL),
(19, NULL, 'MOUSE', 'REPARACION', '2016-07-13 07:26:42', NULL, 2, 6, NULL, NULL, NULL),
(20, NULL, 'TECLADO', 'REPARACION', '2016-07-13 07:26:42', NULL, 2, 6, NULL, NULL, NULL),
(21, NULL, 'RAM', 'REPARACION', '2016-07-13 07:26:42', NULL, 1, 6, NULL, NULL, NULL),
(22, NULL, 'PROCESADOR', 'ACTIVO', '2016-07-13 07:26:42', NULL, 0, 6, NULL, NULL, NULL),
(23, NULL, 'HDD', 'ACTIVO', '2016-07-13 07:26:42', NULL, 0, 6, NULL, NULL, NULL),
(24, NULL, 'MOTHERBOARD', 'ACTIVO', '2016-07-13 07:26:42', NULL, 0, 6, NULL, NULL, NULL),
(25, NULL, 'MONITOR', 'ACTIVO', '2016-07-22 11:25:31', NULL, 0, 7, NULL, NULL, NULL),
(26, NULL, 'MOUSE', 'ACTIVO', '2016-07-22 11:25:31', NULL, 0, 7, NULL, NULL, NULL),
(27, NULL, 'TECLADO', 'ACTIVO', '2016-07-22 11:25:31', NULL, 0, 7, NULL, NULL, NULL),
(28, NULL, 'RAM', 'ACTIVO', '2016-07-22 11:25:31', NULL, 0, 7, NULL, NULL, NULL),
(29, NULL, 'PROCESADOR', 'ACTIVO', '2016-07-22 11:25:31', NULL, 0, 7, NULL, NULL, NULL),
(30, NULL, 'HDD', 'ACTIVO', '2016-07-22 11:25:31', NULL, 0, 7, NULL, NULL, NULL),
(31, NULL, 'MOTHERBOARD', 'ACTIVO', '2016-07-22 11:25:31', NULL, 0, 7, NULL, NULL, NULL),
(32, NULL, 'RAM', 'ACTIVO', NULL, NULL, 5, 7, 2, NULL, NULL),
(33, NULL, 'MONITOR', 'ACTIVO', '2016-07-22 12:30:32', NULL, 0, 8, NULL, NULL, NULL),
(34, NULL, 'MOUSE', 'ACTIVO', '2016-07-22 12:30:32', NULL, 0, 8, NULL, NULL, NULL),
(35, NULL, 'TECLADO', 'ACTIVO', '2016-07-22 12:30:32', NULL, 0, 8, NULL, NULL, NULL),
(36, NULL, 'RAM', 'ACTIVO', '2016-07-22 12:30:32', NULL, 0, 8, NULL, NULL, NULL),
(37, NULL, 'PROCESADOR', 'ACTIVO', '2016-07-22 12:30:32', NULL, 0, 8, NULL, NULL, NULL),
(38, NULL, 'HDD', 'ACTIVO', '2016-07-22 12:30:32', NULL, 0, 8, NULL, NULL, NULL),
(39, NULL, 'MOTHERBOARD', 'ACTIVO', '2016-07-22 12:30:32', NULL, 0, 8, NULL, NULL, NULL),
(40, NULL, 'MONITOR', 'ACTIVO', '2016-07-26 07:17:23', NULL, 0, 9, NULL, NULL, NULL),
(41, NULL, 'MOUSE', 'ACTIVO', '2016-07-26 07:17:23', NULL, 0, 9, NULL, NULL, NULL),
(42, NULL, 'TECLADO', 'ACTIVO', '2016-07-26 07:17:23', NULL, 0, 9, NULL, NULL, NULL),
(43, NULL, 'RAM', 'ACTIVO', '2016-07-26 07:17:23', NULL, 0, 9, NULL, NULL, NULL),
(44, NULL, 'PROCESADOR', 'ACTIVO', '2016-07-26 07:17:23', NULL, 0, 9, NULL, NULL, NULL),
(45, NULL, 'HDD', 'ACTIVO', '2016-07-26 07:17:23', NULL, 0, 9, NULL, NULL, NULL),
(46, NULL, 'MOTHERBOARD', 'ACTIVO', '2016-07-26 07:17:23', NULL, 0, 9, NULL, NULL, NULL),
(47, NULL, 'FUENTE PODER', 'ACTIVO', '2016-07-26 07:17:23', NULL, 0, 9, NULL, NULL, NULL),
(48, NULL, 'MONITOR', 'ACTIVO', '2016-08-10 07:19:24', '2016-08-19 07:18:25', 0, 12, NULL, NULL, NULL),
(49, NULL, 'MOUSE', 'DE BAJA', '2016-08-10 07:19:24', '2016-08-10 12:07:27', 0, 12, NULL, NULL, NULL),
(50, NULL, 'TECLADO', 'REPARACION', '2016-08-10 07:19:24', NULL, 1, 12, NULL, NULL, NULL),
(51, NULL, 'RAM', 'ACTIVO', '2016-08-10 07:19:24', NULL, 0, 12, NULL, NULL, NULL),
(52, NULL, 'PROCESADOR', 'ACTIVO', '2016-08-10 07:19:24', NULL, 0, 12, NULL, NULL, NULL),
(53, NULL, 'HDD', 'ACTIVO', '2016-08-10 07:19:24', NULL, 0, 12, NULL, NULL, NULL),
(54, NULL, 'MOTHERBOARD', 'ACTIVO', '2016-08-10 07:19:24', NULL, 0, 12, NULL, NULL, NULL),
(55, NULL, 'FUENTE PODER', 'ACTIVO', '2016-08-10 07:19:24', NULL, 0, 12, NULL, NULL, NULL),
(56, NULL, 'PROCESADOR', 'ACTIVO', NULL, NULL, 0, 12, 13, NULL, NULL);

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
(1, 'INGENIERIA', '', 1),
(2, 'MEDICINA', '', 1);

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
(1, 9, 0, '2016-07-26 22:26:19', 'Se agregó PC id=9 y sus componentes'),
(2, 10, 0, '2016-07-26 22:28:54', 'Se agregó item id=10'),
(3, 11, 0, '2016-07-26 22:35:02', 'Se agregó PROCESADORid=11'),
(4, 10, 0, '2016-07-26 23:05:59', 'Se actualizó estado item id=10 de ACTIVO a REPARACION'),
(5, 6, 0, '2016-07-26 23:45:05', 'Se actualizó estado item id=6 de ACTIVO a REPARACION'),
(7, 6, 21, '2016-07-26 23:55:22', 'Se actualizó estado equipo id=21 de PC id=6 deACTIVO a REPARACION'),
(8, 12, 0, '2016-08-10 12:03:43', 'Se agregó PC id=12 y sus componentes'),
(9, 12, 49, '2016-08-10 12:07:27', 'Se actualizó estado equipo id=49 de PC id=12 deACTIVO a DE BAJA'),
(10, 12, 50, '2016-08-10 12:10:02', 'Se actualizó estado equipo id=50 de PC id=12 deACTIVO a REPARACION'),
(11, 12, 0, '2016-08-10 12:10:02', 'Se actualizó estado item id=12 de ACTIVO a REPARACION'),
(12, 13, 0, '2016-08-10 12:11:51', 'Se agregó PROCESADOR id=13'),
(13, 0, 0, '2016-08-13 17:23:13', 'Se agregó aviso, item id=6 problema=PC NO ENCIENDEdescripcion=hola'),
(14, 9, 0, '2016-08-13 17:24:24', 'Se agregó aviso, item id=9 problema=DESCARGA LENTAdescripcion=holi'),
(15, 8, 0, '2016-08-13 17:25:19', 'Se agregó aviso, item id=8, problema=REINICIO/APAGADO AUTOMÁTICO, descripcion=123');

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
(2, 'RAM', 'RAM 1GB', 'ACTIVO', '2016-07-16 09:25:27', NULL, 5, 7, NULL, NULL, NULL, NULL),
(6, 'EQUIPO', 'PC001', 'REPARACION', '2016-07-13 07:26:42', NULL, 5, NULL, 1, 2, NULL, NULL),
(7, 'EQUIPO', 'PC010', 'ACTIVO', '2016-07-22 11:25:31', NULL, 2, NULL, 4, 1, NULL, NULL),
(8, 'EQUIPO', 'PC0012', 'ACTIVO', '2016-07-22 12:30:32', NULL, 0, NULL, 2, 1, NULL, NULL),
(9, 'EQUIPO', 'PC100', 'ACTIVO', '2016-07-26 07:17:23', NULL, 0, NULL, 4, 1, NULL, NULL),
(10, 'MOTHERBOARD', 'MSI H55H-M', 'REPARACION', '2016-07-25 07:24:31', NULL, 1, NULL, 4, 1, NULL, NULL),
(11, 'PROCESADOR', 'Intel i3 540', 'ACTIVO', '2016-07-26 07:20:26', NULL, 0, NULL, 1, 2, NULL, NULL),
(12, 'EQUIPO', 'PC00234', 'REPARACION', '2016-08-10 07:19:24', NULL, 1, NULL, 4, 1, NULL, NULL),
(13, 'PROCESADOR', 'i3 540', 'ACTIVO', '2012-04-11 05:19:27', NULL, 0, 12, 3, 1, NULL, NULL);

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
(1, 'DCI01', '', 1),
(2, 'DCI02', '', 1),
(3, 'DCI03', '', 1),
(4, 'LABORATORIO HARDWARE', '', 1);

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
(1, 'UCM', ''),
(2, 'UTAL', ''),
(3, 'INACAP', ''),
(4, 'ARICA', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `rut_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(250) DEFAULT NULL,
  `pass_usuario` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`rut_usuario`, `nombre_usuario`, `pass_usuario`) VALUES
(12000, 'hola', '123');

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
  ADD PRIMARY KEY (`id_depto`),
  ADD KEY `id_facultad` (`id_facultad`);

--
-- Indices de la tabla `empresa_externa`
--
ALTER TABLE `empresa_externa`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `equipo`
--
ALTER TABLE `equipo`
  ADD PRIMARY KEY (`id_componente`),
  ADD KEY `fk_equipo_item` (`id_equipo_relacionado`),
  ADD KEY `fk_equipo_pieza_nueva` (`id_pieza_nueva`),
  ADD KEY `fk_equipo_empresa_reparadora` (`id_empresa_reparadora`),
  ADD KEY `fk_equipo_empresa_desechadora` (`id_empresa_desechadora`);

--
-- Indices de la tabla `facultad`
--
ALTER TABLE `facultad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_universidad` (`id_universidad`);

--
-- Indices de la tabla `historico_item`
--
ALTER TABLE `historico_item`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_item_item` (`id_item_relacionado`),
  ADD KEY `fk_item_unidad` (`id_unidad`),
  ADD KEY `fk_item_empresa_proveedora` (`id_empresa_proveedora`),
  ADD KEY `fk_item_empresa_reparadora` (`id_empresa_reparadora`),
  ADD KEY `fk_item_empresa_desechadora` (`id_empresa_desechadora`);

--
-- Indices de la tabla `unidad`
--
ALTER TABLE `unidad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_depto` (`id_depto`);

--
-- Indices de la tabla `universidad`
--
ALTER TABLE `universidad`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`rut`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aviso_problema`
--
ALTER TABLE `aviso_problema`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `empresa_externa`
--
ALTER TABLE `empresa_externa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `equipo`
--
ALTER TABLE `equipo`
  MODIFY `id_componente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;
--
-- AUTO_INCREMENT de la tabla `facultad`
--
ALTER TABLE `facultad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `historico_item`
--
ALTER TABLE `historico_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT de la tabla `item`
--
ALTER TABLE `item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `unidad`
--
ALTER TABLE `unidad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `universidad`
--
ALTER TABLE `universidad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD CONSTRAINT `departamento_ibfk_1` FOREIGN KEY (`id_facultad`) REFERENCES `facultad` (`id`);

--
-- Filtros para la tabla `equipo`
--
ALTER TABLE `equipo`
  ADD CONSTRAINT `fk_equipo_empresa_desechadora` FOREIGN KEY (`id_empresa_desechadora`) REFERENCES `empresa_externa` (`id`),
  ADD CONSTRAINT `fk_equipo_empresa_reparadora` FOREIGN KEY (`id_empresa_reparadora`) REFERENCES `empresa_externa` (`id`),
  ADD CONSTRAINT `fk_equipo_item` FOREIGN KEY (`id_equipo_relacionado`) REFERENCES `item` (`id`),
  ADD CONSTRAINT `fk_equipo_pieza_nueva` FOREIGN KEY (`id_pieza_nueva`) REFERENCES `item` (`id`);

--
-- Filtros para la tabla `facultad`
--
ALTER TABLE `facultad`
  ADD CONSTRAINT `facultad_ibfk_1` FOREIGN KEY (`id_universidad`) REFERENCES `universidad` (`id`);

--
-- Filtros para la tabla `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `fk_item_empresa_desechadora` FOREIGN KEY (`id_empresa_desechadora`) REFERENCES `empresa_externa` (`id`),
  ADD CONSTRAINT `fk_item_empresa_proveedora` FOREIGN KEY (`id_empresa_proveedora`) REFERENCES `empresa_externa` (`id`),
  ADD CONSTRAINT `fk_item_empresa_reparadora` FOREIGN KEY (`id_empresa_reparadora`) REFERENCES `empresa_externa` (`id`),
  ADD CONSTRAINT `fk_item_item` FOREIGN KEY (`id_item_relacionado`) REFERENCES `item` (`id`),
  ADD CONSTRAINT `fk_item_unidad` FOREIGN KEY (`id_unidad`) REFERENCES `unidad` (`id`);

--
-- Filtros para la tabla `unidad`
--
ALTER TABLE `unidad`
  ADD CONSTRAINT `unidad_ibfk_1` FOREIGN KEY (`id_depto`) REFERENCES `departamento` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
