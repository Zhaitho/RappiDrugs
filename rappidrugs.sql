-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-05-2026 a las 15:27:37
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `rappidrugs`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre`, `descripcion`, `estado`) VALUES
(1, 'Analgésicos', 'Medicamentos para aliviar el dolor', 1),
(2, 'Antibióticos', 'Medicamentos para tratar infecciones bacterianas', 1),
(3, 'Antihipertensivos', 'Medicamentos para controlar la presión arterial', 1),
(4, 'Antidiabéticos', 'Medicamentos para controlar la diabetes', 1),
(5, 'Antiinflamatorios', 'Medicamentos para reducir inflamación y dolor', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id_inventario` int(11) NOT NULL,
  `id_medicamento` int(11) NOT NULL,
  `stock_actual` int(11) NOT NULL DEFAULT 0,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_inventario`, `id_medicamento`, `stock_actual`, `fecha_actualizacion`) VALUES
(1, 1, 120, '2026-05-04 00:26:58'),
(2, 2, 80, '2026-05-04 00:26:58'),
(3, 3, 50, '2026-05-04 00:26:58'),
(4, 4, 100, '2026-05-04 00:26:58'),
(5, 5, 90, '2026-05-04 00:26:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lotes`
--

CREATE TABLE `lotes` (
  `id_lote` int(11) NOT NULL,
  `id_medicamento` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `numero_lote` varchar(80) NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `cantidad_inicial` int(11) NOT NULL,
  `cantidad_disponible` int(11) NOT NULL,
  `estado` enum('DISPONIBLE','AGOTADO','VENCIDO') NOT NULL DEFAULT 'DISPONIBLE'
) ;

--
-- Volcado de datos para la tabla `lotes`
--

INSERT INTO `lotes` (`id_lote`, `id_medicamento`, `id_proveedor`, `numero_lote`, `fecha_vencimiento`, `cantidad_inicial`, `cantidad_disponible`, `estado`) VALUES
(1, 1, 1, 'LOT-ACET-001', '2027-06-30', 120, 120, 'DISPONIBLE'),
(2, 2, 2, 'LOT-IBU-001', '2027-03-15', 80, 80, 'DISPONIBLE'),
(3, 3, 3, 'LOT-AMOX-001', '2026-12-20', 50, 50, 'DISPONIBLE'),
(4, 4, 1, 'LOT-LOS-001', '2027-09-10', 100, 100, 'DISPONIBLE'),
(5, 5, 2, 'LOT-MET-001', '2027-11-05', 90, 90, 'DISPONIBLE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamentos`
--

CREATE TABLE `medicamentos` (
  `id_medicamento` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `medicamentos`
--

INSERT INTO `medicamentos` (`id_medicamento`, `codigo`, `nombre`, `id_categoria`, `estado`) VALUES
(1, 'MED001', 'Acetaminofén 500 mg', 1, 1),
(2, 'MED002', 'Ibuprofeno 400 mg', 5, 1),
(3, 'MED003', 'Amoxicilina 500 mg', 2, 1),
(4, 'MED004', 'Losartán 50 mg', 3, 1),
(5, 'MED005', 'Metformina 850 mg', 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_inventario`
--

CREATE TABLE `movimientos_inventario` (
  `id_movimiento` int(11) NOT NULL,
  `id_medicamento` int(11) NOT NULL,
  `id_lote` int(11) DEFAULT NULL,
  `tipo_movimiento` enum('ENTRADA','SALIDA','AJUSTE') NOT NULL,
  `cantidad` int(11) NOT NULL,
  `motivo` varchar(255) NOT NULL,
  `fecha_movimiento` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Volcado de datos para la tabla `movimientos_inventario`
--

INSERT INTO `movimientos_inventario` (`id_movimiento`, `id_medicamento`, `id_lote`, `tipo_movimiento`, `cantidad`, `motivo`, `fecha_movimiento`) VALUES
(1, 1, 1, 'ENTRADA', 120, 'Carga inicial de inventario', '2026-05-04 00:26:58'),
(2, 2, 2, 'ENTRADA', 80, 'Carga inicial de inventario', '2026-05-04 00:26:58'),
(3, 3, 3, 'ENTRADA', 50, 'Carga inicial de inventario', '2026-05-04 00:26:58'),
(4, 4, 4, 'ENTRADA', 100, 'Carga inicial de inventario', '2026-05-04 00:26:58'),
(5, 5, 5, 'ENTRADA', 90, 'Carga inicial de inventario', '2026-05-04 00:26:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `correo` varchar(120) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre`, `telefono`, `correo`, `direccion`, `estado`) VALUES
(1, 'Distribuidora FarmaSalud', '3001234567', 'contacto@farmasalud.com', 'Calle 10 # 20-30', 1),
(2, 'Medicamentos Colombia S.A.S', '3019876543', 'ventas@medicolombia.com', 'Carrera 45 # 12-80', 1),
(3, 'Laboratorios Vida', '3024567890', 'info@labvida.com', 'Avenida 30 # 15-25', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_inventario`),
  ADD UNIQUE KEY `id_medicamento` (`id_medicamento`);

--
-- Indices de la tabla `lotes`
--
ALTER TABLE `lotes`
  ADD PRIMARY KEY (`id_lote`),
  ADD UNIQUE KEY `uq_lote_medicamento` (`id_medicamento`,`numero_lote`),
  ADD KEY `fk_lotes_proveedores` (`id_proveedor`);

--
-- Indices de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  ADD PRIMARY KEY (`id_medicamento`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD KEY `fk_medicamentos_categorias` (`id_categoria`);

--
-- Indices de la tabla `movimientos_inventario`
--
ALTER TABLE `movimientos_inventario`
  ADD PRIMARY KEY (`id_movimiento`),
  ADD KEY `fk_movimientos_medicamentos` (`id_medicamento`),
  ADD KEY `fk_movimientos_lotes` (`id_lote`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_inventario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lotes`
--
ALTER TABLE `lotes`
  MODIFY `id_lote` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  MODIFY `id_medicamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `movimientos_inventario`
--
ALTER TABLE `movimientos_inventario`
  MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `fk_inventario_medicamentos` FOREIGN KEY (`id_medicamento`) REFERENCES `medicamentos` (`id_medicamento`);

--
-- Filtros para la tabla `lotes`
--
ALTER TABLE `lotes`
  ADD CONSTRAINT `fk_lotes_medicamentos` FOREIGN KEY (`id_medicamento`) REFERENCES `medicamentos` (`id_medicamento`),
  ADD CONSTRAINT `fk_lotes_proveedores` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`);

--
-- Filtros para la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  ADD CONSTRAINT `fk_medicamentos_categorias` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`);

--
-- Filtros para la tabla `movimientos_inventario`
--
ALTER TABLE `movimientos_inventario`
  ADD CONSTRAINT `fk_movimientos_lotes` FOREIGN KEY (`id_lote`) REFERENCES `lotes` (`id_lote`),
  ADD CONSTRAINT `fk_movimientos_medicamentos` FOREIGN KEY (`id_medicamento`) REFERENCES `medicamentos` (`id_medicamento`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
