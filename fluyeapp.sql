-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-03-2025 a las 00:28:17
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `fluyeapp`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prueba`
--

CREATE TABLE `prueba` (
  `ID` int(11) NOT NULL,
  `ESTADO` tinyint(1) NOT NULL,
  `NIVEL` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `prueba`
--

INSERT INTO `prueba` (`ID`, `ESTADO`, `NIVEL`) VALUES
(1, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_bomba`
--

CREATE TABLE `tbl_bomba` (
  `num_bomba` int(11) NOT NULL,
  `cod_procesoFK` int(11) NOT NULL,
  `estado` text NOT NULL,
  `presion` text NOT NULL,
  `num_tanqueFK` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_bomba`
--

INSERT INTO `tbl_bomba` (`num_bomba`, `cod_procesoFK`, `estado`, `presion`, `num_tanqueFK`) VALUES
(1, 1, 'off', '8', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_monitorea`
--

CREATE TABLE `tbl_monitorea` (
  `id_usuario` int(11) NOT NULL,
  `cod_proceso` int(11) NOT NULL,
  `administrador` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_proceso`
--

CREATE TABLE `tbl_proceso` (
  `codigo` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `presion_prom` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_proceso`
--

INSERT INTO `tbl_proceso` (`codigo`, `nombre`, `presion_prom`) VALUES
(1, 'EICA', '7.5');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tanque`
--

CREATE TABLE `tbl_tanque` (
  `num_tanque` int(11) NOT NULL,
  `cod_procesoFK` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `estado` text NOT NULL,
  `capacidad` text NOT NULL,
  `proceso` text NOT NULL,
  `ancho` float NOT NULL,
  `altura` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_tanque`
--

INSERT INTO `tbl_tanque` (`num_tanque`, `cod_procesoFK`, `nombre`, `estado`, `capacidad`, `proceso`, `ancho`, `altura`) VALUES
(1, 1, 'Prueba', 'Neutro', '500', '22', 10, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuario`
--

CREATE TABLE `tbl_usuario` (
  `id` int(11) NOT NULL,
  `correo` text NOT NULL,
  `contraseña` text NOT NULL,
  `usuario` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `prueba`
--
ALTER TABLE `prueba`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `tbl_bomba`
--
ALTER TABLE `tbl_bomba`
  ADD PRIMARY KEY (`num_bomba`,`cod_procesoFK`),
  ADD KEY `cod_precesoFK` (`cod_procesoFK`),
  ADD KEY `num_tanqueFK` (`num_tanqueFK`);

--
-- Indices de la tabla `tbl_monitorea`
--
ALTER TABLE `tbl_monitorea`
  ADD PRIMARY KEY (`id_usuario`,`cod_proceso`),
  ADD KEY `cod_procesoFK` (`cod_proceso`);

--
-- Indices de la tabla `tbl_proceso`
--
ALTER TABLE `tbl_proceso`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `tbl_tanque`
--
ALTER TABLE `tbl_tanque`
  ADD PRIMARY KEY (`num_tanque`,`cod_procesoFK`),
  ADD KEY `cod_preceso_FK` (`cod_procesoFK`);

--
-- Indices de la tabla `tbl_usuario`
--
ALTER TABLE `tbl_usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `prueba`
--
ALTER TABLE `prueba`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_bomba`
--
ALTER TABLE `tbl_bomba`
  ADD CONSTRAINT `cod_precesoFK` FOREIGN KEY (`cod_procesoFK`) REFERENCES `tbl_proceso` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `num_tanqueFK` FOREIGN KEY (`num_tanqueFK`) REFERENCES `tbl_tanque` (`num_tanque`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tbl_monitorea`
--
ALTER TABLE `tbl_monitorea`
  ADD CONSTRAINT `cod_procesoFK` FOREIGN KEY (`cod_proceso`) REFERENCES `tbl_proceso` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `id_usuarioFK` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tbl_tanque`
--
ALTER TABLE `tbl_tanque`
  ADD CONSTRAINT `cod_preceso_FK` FOREIGN KEY (`cod_procesoFK`) REFERENCES `tbl_proceso` (`codigo`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
