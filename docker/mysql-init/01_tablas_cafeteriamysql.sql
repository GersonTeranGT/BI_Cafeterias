-- 01_mysql_cafeteria_creacion.sql
-- Base operacional de ventas e inventario para "Café & Alma"
-- Cadena de cafeterías especializadas
-- drop database cafeteria_db;
CREATE DATABASE IF NOT EXISTS cafeteria_db;
USE cafeteria_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS detalle_venta;
DROP TABLE IF EXISTS venta;
DROP TABLE IF EXISTS inventario;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS categoria_producto;
DROP TABLE IF EXISTS proveedor;
DROP TABLE IF EXISTS turno_barista;
SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- 1. PROVEEDORES
-- =====================================================
CREATE TABLE proveedor (
    ruc VARCHAR(13) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    pais VARCHAR(50),
    telefono VARCHAR(20),
    email VARCHAR(80),
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

-- =====================================================
-- 2. CATEGORÍA DE PRODUCTOS (CON DUPLICADOS CONCEPTUALES)
-- =====================================================
CREATE TABLE categoria_producto (
    codigo_categoria VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    descripcion VARCHAR(200)
);

-- =====================================================
-- 3. PRODUCTOS
-- =====================================================
CREATE TABLE producto (
    codigo_producto VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    codigo_categoria VARCHAR(10),
    ruc_proveedor VARCHAR(13),
    presentacion VARCHAR(80),
    tamanio VARCHAR(20),
    costo DECIMAL(10,2),
    precio_venta DECIMAL(10,2),
    dias_caducidad INT,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_prod_categoria FOREIGN KEY (codigo_categoria)
        REFERENCES categoria_producto(codigo_categoria),
    CONSTRAINT fk_prod_proveedor FOREIGN KEY (ruc_proveedor)
        REFERENCES proveedor(ruc)
);

-- =====================================================
-- 4. VENTAS
-- =====================================================
CREATE TABLE venta (
    numero_venta VARCHAR(25) PRIMARY KEY,
    fecha_hora DATETIME NOT NULL,
    tienda_origen VARCHAR(60) NOT NULL,
    documento_cliente VARCHAR(25),
    forma_pago VARCHAR(30),
    descuento DECIMAL(10,2) DEFAULT 0,
    es_para_llevar CHAR(1) DEFAULT 'N',
    estado VARCHAR(20) NOT NULL DEFAULT 'COMPLETADA',
    observacion VARCHAR(200)
);

-- =====================================================
-- 5. DETALLE DE VENTAS
-- =====================================================
CREATE TABLE detalle_venta (
    numero_venta VARCHAR(25) NOT NULL,
    linea SMALLINT NOT NULL,
    codigo_producto VARCHAR(15),
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2),
    descuento_aplicado DECIMAL(10,2) DEFAULT 0,
    PRIMARY KEY (numero_venta, linea),
    CONSTRAINT fk_det_venta FOREIGN KEY (numero_venta)
        REFERENCES venta(numero_venta),
    CONSTRAINT fk_det_producto FOREIGN KEY (codigo_producto)
        REFERENCES producto(codigo_producto)
);

-- =====================================================
-- 6. INVENTARIO
-- =====================================================
CREATE TABLE inventario (
    tienda_origen VARCHAR(60) NOT NULL,
    codigo_producto VARCHAR(15) NOT NULL,
    stock_actual INT,
    stock_minimo INT,
    fecha_ultima_entrada DATE,
    fecha_ultimo_movimiento DATE,
    PRIMARY KEY (tienda_origen, codigo_producto),
    CONSTRAINT fk_inv_producto FOREIGN KEY (codigo_producto)
        REFERENCES producto(codigo_producto)
);

-- =====================================================
-- 7. TURNOS DE BARISTAS
-- =====================================================
CREATE TABLE turno_barista (
    id_turno INT AUTO_INCREMENT PRIMARY KEY,
    tienda_origen VARCHAR(60) NOT NULL,
    barista_nombre VARCHAR(80) NOT NULL,
    fecha DATE NOT NULL,
    hora_inicio TIME,
    hora_fin TIME,
    ventas_atendidas INT DEFAULT 0,
    tiempo_promedio_atencion_seg INT,
    observacion VARCHAR(200)
);

-- Índices
CREATE INDEX idx_venta_fecha ON venta(fecha_hora);
CREATE INDEX idx_venta_tienda ON venta(tienda_origen);
CREATE INDEX idx_venta_cliente ON venta(documento_cliente);
CREATE INDEX idx_det_producto ON detalle_venta(codigo_producto);
CREATE INDEX idx_turno_fecha ON turno_barista(fecha);