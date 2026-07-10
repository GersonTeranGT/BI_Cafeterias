-- 01_mysql_cafeteria_creacion.sql
-- BASE DE OPERACIONES - ENFOQUE EN EFICIENCIA OPERATIVA
-- CAFETERIA "CAFE & ALMA"
-- drop database cafeteria_db;
CREATE DATABASE IF NOT EXISTS cafeteria_db;
USE cafeteria_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS preparacion_producto;
DROP TABLE IF EXISTS atencion_cliente;
DROP TABLE IF EXISTS registro_turno;
DROP TABLE IF EXISTS inventario_insumo;
DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS receta_estandar;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS categoria_producto;
DROP TABLE IF EXISTS proveedor;
SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- 1. PROVEEDORES (Sin cambios)
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
-- 2. CATEGORIA DE PRODUCTOS (Con duplicados)
-- =====================================================
CREATE TABLE categoria_producto (
    codigo_categoria VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    descripcion VARCHAR(200)
);

-- =====================================================
-- 3. PRODUCTOS (Catálogo)
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
    tiempo_preparacion_estandar_seg INT,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_prod_categoria FOREIGN KEY (codigo_categoria)
        REFERENCES categoria_producto(codigo_categoria),
    CONSTRAINT fk_prod_proveedor FOREIGN KEY (ruc_proveedor)
        REFERENCES proveedor(ruc)
);

-- =====================================================
-- 4. RECETA ESTANDAR (Control de mezcla de café)
-- =====================================================
CREATE TABLE receta_estandar (
    codigo_producto VARCHAR(15) PRIMARY KEY,
    cafe_premium_gramos DECIMAL(6,2),
    cafe_regular_gramos DECIMAL(6,2),
    leche_ml DECIMAL(6,2),
    otros_ingredientes VARCHAR(200),
    CONSTRAINT fk_receta_producto FOREIGN KEY (codigo_producto)
        REFERENCES producto(codigo_producto)
);

-- =====================================================
-- 5. EMPLEADOS (Baristas)
-- =====================================================
CREATE TABLE empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    documento VARCHAR(20),
    fecha_contratacion DATE,
    salario_mensual DECIMAL(10,2),
    certificacion VARCHAR(50),
    tienda_origen VARCHAR(60) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

-- =====================================================
-- 6. REGISTRO DE TURNOS (Asistencia y tiempos)
-- =====================================================
CREATE TABLE registro_turno (
    id_turno INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    fecha DATE NOT NULL,
    hora_inicio TIME,
    hora_fin TIME,
    pausa_inicio TIME,
    pausa_fin TIME,
    horas_trabajadas DECIMAL(4,2),
    observacion VARCHAR(200),
    CONSTRAINT fk_turno_empleado FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado)
);

-- =====================================================
-- 7. ATENCION AL CLIENTE (Tiempos de servicio)
-- =====================================================
CREATE TABLE atencion_cliente (
    id_atencion INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    fecha DATE NOT NULL,
    hora_llegada TIME,
    hora_atencion TIME,
    hora_entrega TIME,
    tiempo_espera_seg INT,
    tiempo_preparacion_seg INT,
    tipo_pedido VARCHAR(20),
    codigo_producto VARCHAR(15),
    tienda_origen VARCHAR(60),
    observacion VARCHAR(200),
    CONSTRAINT fk_atencion_empleado FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado),
    CONSTRAINT fk_atencion_producto FOREIGN KEY (codigo_producto)
        REFERENCES producto(codigo_producto)
);

-- =====================================================
-- 8. PREPARACION DE PRODUCTOS (Control de producción y mezcla)
-- =====================================================
CREATE TABLE preparacion_producto (
    id_preparacion INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    codigo_producto VARCHAR(15),
    fecha DATETIME,
    cantidad INT,
    tiempo_preparacion_seg INT,
    cafe_premium_gramos DECIMAL(6,2),
    cafe_regular_gramos DECIMAL(6,2),
    leche_ml DECIMAL(6,2),
    observacion VARCHAR(200),
    CONSTRAINT fk_preparacion_empleado FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado),
    CONSTRAINT fk_preparacion_producto FOREIGN KEY (codigo_producto)
        REFERENCES producto(codigo_producto)
);

-- =====================================================
-- 9. INVENTARIO DE INSUMOS (Control de stock y caducidad)
-- =====================================================
CREATE TABLE inventario_insumo (
    id_insumo INT AUTO_INCREMENT PRIMARY KEY,
    tienda_origen VARCHAR(60) NOT NULL,
    nombre_insumo VARCHAR(50),
    stock_actual DECIMAL(10,2),
    stock_minimo DECIMAL(10,2),
    unidad_medida VARCHAR(20),
    fecha_caducidad DATE,
    fecha_ultima_compra DATE
);

-- INDICES
CREATE INDEX idx_turno_fecha ON registro_turno(fecha);
CREATE INDEX idx_turno_empleado ON registro_turno(id_empleado);
CREATE INDEX idx_atencion_fecha ON atencion_cliente(fecha);
CREATE INDEX idx_atencion_empleado ON atencion_cliente(id_empleado);
CREATE INDEX idx_atencion_tienda ON atencion_cliente(tienda_origen);
CREATE INDEX idx_preparacion_fecha ON preparacion_producto(fecha);
CREATE INDEX idx_preparacion_empleado ON preparacion_producto(id_empleado);
CREATE INDEX idx_inventario_tienda ON inventario_insumo(tienda_origen);