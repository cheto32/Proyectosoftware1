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
  `rut` int(11) NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `pass` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`rut`, `nombre`, `pass`) VALUES
(1234, 'kari', '111'),
(18000, 'JUAN', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aviso_problema`
--

CREATE TABLE `aviso_problema` (
  `id` int(11) NOT NULL,
  `tipo` varchar(250) NOT NULL,
  `item_relacionado` varchar(250) NOT NULL,
  `descripcion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `aviso_problema`
--

INSERT INTO `aviso_problema` (`id`, `tipo`, `item_relacionado`, `descripcion`) VALUES
(8, 'PC NO ENCIENDE', '6', 'asdasdasda'),
(9, 'PC NO ENCIENDE', '6', 'hola'),
(10, 'DESCARGA LENTA', '9', 'holi'),
(11, 'REINICIO/APAGADO AUTOMÁTICO', '8', '123');

--
-- Disparadores `aviso_problema`
--
DELIMITER $$
CREATE TRIGGER `aviso_historico` AFTER INSERT ON `aviso_problema` FOR EACH ROW insert into historico_item(id_item,fecha,descripcion) VALUES
(new.item_relacionado,now(),concat('Se agregó aviso, item id=',new.item_relacionado,', problema=',new.tipo,', descripcion=',new.descripcion))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `id` int(11) NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `ubicacion` varchar(250) NOT NULL,
  `id_facultad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`id`, `nombre`, `ubicacion`, `id_facultad`) VALUES
(1, 'INFORMATICA', '', 1),
(2, 'CONSTRUCCION', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa_externa`
--

CREATE TABLE `empresa_externa` (
  `id` int(11) NOT NULL,
  `tipo` varchar(250) DEFAULT NULL,
  `nombre` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empresa_externa`
--

INSERT INTO `empresa_externa` (`id`, `tipo`, `nombre`) VALUES
(1, 'PROVEEDOR', 'MSI'),
(2, 'DESECHOS TECNOLOGICOS', 'ECO_PC LTDA.'),
(3, 'REPARADOR', 'SERVICIO TECNICO PC LTDA.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo`
--

CREATE TABLE `equipo` (
  `id_componente` int(11) NOT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `tipo` varchar(250) DEFAULT NULL,
  `estado` varchar(250) DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  `fecha_baja` datetime DEFAULT NULL,
  `veces_reparacion` int(11) DEFAULT NULL,
  `id_equipo_relacionado` int(11) DEFAULT NULL,
  `id_pieza_nueva` int(11) DEFAULT NULL,
  `id_empresa_reparadora` int(11) DEFAULT NULL,
  `id_empresa_desechadora` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `equipo`
--

INSERT INTO `equipo` (`id_componente`, `descripcion`, `tipo`, `estado`, `fecha_ingreso`, `fecha_baja`, `veces_reparacion`, `id_equipo_relacionado`, `id_pieza_nueva`, `id_empresa_reparadora`, `id_empresa_desechadora`) VALUES
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
		IF NOT(NEW.estado <=> OLD.estado) THEN
      INSERT into historico_item(id_item,id_componente,fecha,descripcion)
      VALUES(old.id_equipo_relacionado,old.id_componente,now(),concat("Se actualizó estado equipo id=",old.id_componente," de PC id=",old.id_equipo_relacionado," de",old.estado," a ",new.estado));
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
		END IF;
	END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cambiar_estado_componente_i` AFTER UPDATE ON `equipo` FOR EACH ROW BEGIN
		DECLARE num_rep INT default 0;
		DECLARE num_tran INT default 0;
		DECLARE sum INT default 0;
		SELECT COUNT(*) INTO num_rep FROM equipo WHERE estado='REPARACION' AND id_equipo_relacionado=old.id_equipo_relacionado;
		SELECT COUNT(*) INTO num_tran FROM equipo WHERE estado='EN TRANSITO' AND id_equipo_relacionado=old.id_equipo_relacionado;
		set sum=num_rep+num_tran;
		IF sum>0 THEN
			IF num_rep>0 THEN
				update item
				set estado='REPARACION'
				where id=old.id_equipo_relacionado;
			ELSE 
				IF num_tran>0 THEN
					update item
					set estado='EN TRANSITO'
					where id=old.id_equipo_relacionado;
				END IF;
			END IF; 
		else
			update item
			set estado='ACTIVO'
			where id=old.id_equipo_relacionado;
		end IF;
	END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facultad`
--

CREATE TABLE `facultad` (
  `id` int(11) NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `ubicacion` varchar(250) NOT NULL,
  `id_universidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `facultad`
--

INSERT INTO `facultad` (`id`, `nombre`, `ubicacion`, `id_universidad`) VALUES
(1, 'INGENIERIA', '', 1),
(2, 'MEDICINA', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historico_item`
--

CREATE TABLE `historico_item` (
  `id` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `id_componente` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `descripcion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `historico_item`
--

INSERT INTO `historico_item` (`id`, `id_item`, `id_componente`, `fecha`, `descripcion`) VALUES
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
  `id` int(11) NOT NULL,
  `tipo` varchar(250) DEFAULT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `estado` varchar(250) DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  `fecha_baja` datetime DEFAULT NULL,
  `veces_reparacion` int(11) DEFAULT '0',
  `id_item_relacionado` int(11) DEFAULT NULL,
  `id_unidad` int(11) DEFAULT NULL,
  `id_empresa_proveedora` int(11) DEFAULT NULL,
  `id_empresa_reparadora` int(11) DEFAULT NULL,
  `id_empresa_desechadora` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `item`
--

INSERT INTO `item` (`id`, `tipo`, `descripcion`, `estado`, `fecha_ingreso`, `fecha_baja`, `veces_reparacion`, `id_item_relacionado`, `id_unidad`, `id_empresa_proveedora`, `id_empresa_reparadora`, `id_empresa_desechadora`) VALUES
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

      INSERT into historico_item(id_item,fecha,descripcion)
      VALUES(new.id,now(),concat("Se agregó PC id=",new.id," y sus componentes"));
		ELSE
      INSERT into historico_item(id_item,fecha,descripcion)
      VALUES(new.id,now(),concat("Se agregó ",new.tipo," id=",new.id));
    END IF;


	END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cambiar_estado_item` BEFORE UPDATE ON `item` FOR EACH ROW BEGIN
		DECLARE variable int;
		IF NOT(NEW.estado <=>  OLD.estado) THEN
      insert into historico_item(id_item,fecha,descripcion)
      values(old.id,now(),concat("Se actualizó estado item id=",old.id," de ",old.estado," a ",new.estado));
			IF NEW.estado='REPARACION' THEN
			
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
	END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertar_item` BEFORE INSERT ON `item` FOR EACH ROW BEGIN
	set new.estado='ACTIVO';
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad`
--

CREATE TABLE `unidad` (
  `id` int(11) NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `ubicacion` varchar(250) NOT NULL,
  `id_depto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `unidad`
--

INSERT INTO `unidad` (`id`, `nombre`, `ubicacion`, `id_depto`) VALUES
(1, 'DCI01', '', 1),
(2, 'DCI02', '', 1),
(3, 'DCI03', '', 1),
(4, 'LABORATORIO HARDWARE', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `universidad`
--

CREATE TABLE `universidad` (
  `id` int(11) NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `ubicacion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `universidad`
--

INSERT INTO `universidad` (`id`, `nombre`, `ubicacion`) VALUES
(1, 'UCM', ''),
(2, 'UTAL', ''),
(3, 'INACAP', ''),
(4, 'ARICA', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `rut` int(11) NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `pass` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`rut`, `nombre`, `pass`) VALUES
(12000, 'hola', '123');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`rut`);

--
-- Indices de la tabla `aviso_problema`
--
ALTER TABLE `aviso_problema`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`id`),
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
