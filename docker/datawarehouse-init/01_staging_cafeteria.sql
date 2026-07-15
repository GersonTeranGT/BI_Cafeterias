-- 01_staging_cafeteria.sql
-- SCRIPT DE STAGING - VERSIÓN COMPLETA CON TODAS LAS TABLAS

SET client_encoding = 'UTF8';

DROP SCHEMA IF EXISTS stg CASCADE;
CREATE SCHEMA stg;

-- ============================================================
-- 1. STAGING - EXCEL
-- ============================================================

-- 1.1. Evaluaciones de Baristas
CREATE TABLE IF NOT EXISTS stg.excel_evaluaciones (
    codigo_barista VARCHAR(30),
    fecha_evaluacion DATE,
    tienda VARCHAR(150),
    calidad_cafe DECIMAL(3,1),
    rapidez DECIMAL(3,1),
    atencion_cliente DECIMAL(3,1),
    limpieza DECIMAL(3,1),
    trabajo_equipo DECIMAL(3,1),
    recomendacion VARCHAR(50),
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 1.2. Maestro de Baristas
CREATE TABLE IF NOT EXISTS stg.excel_baristas (
    codigo_barista VARCHAR(30) PRIMARY KEY,
    nombre_barista VARCHAR(150),
    fecha_contratacion DATE,
    salario DECIMAL(14,2),
    certificacion VARCHAR(50),
    tienda VARCHAR(50),
    activo VARCHAR(10),
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 1.3. Maestro de Sucursales (Tabla de Mapeo)
CREATE TABLE IF NOT EXISTS stg.excel_sucursales (
    codigo_sucursal VARCHAR(20) PRIMARY KEY,
    nombre_oficial VARCHAR(150),
    nombre_inconsistente_1 VARCHAR(150),
    nombre_inconsistente_2 VARCHAR(150),
    nombre_inconsistente_3 VARCHAR(150),
    nombre_inconsistente_4 VARCHAR(150),
    zona VARCHAR(50),
    ciudad VARCHAR(100),
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 2. STAGING - MYSQL (BASE DE OPERACIONES)
-- ============================================================

-- 2.1. Proveedores ✅ NUEVA
CREATE TABLE IF NOT EXISTS stg.mysql_proveedor (
    ruc VARCHAR(20) PRIMARY KEY,
    nombre_proveedor VARCHAR(150),
    pais VARCHAR(100),
    telefono VARCHAR(50),
    email VARCHAR(200),
    activo BOOLEAN,
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2.2. Categorías de Productos ✅ NUEVA
CREATE TABLE IF NOT EXISTS stg.mysql_categoria_producto (
    codigo_categoria VARCHAR(20) PRIMARY KEY,
    nombre_categoria VARCHAR(150),
    descripcion TEXT,
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2.3. Productos
CREATE TABLE IF NOT EXISTS stg.mysql_producto (
    codigo_producto VARCHAR(30) PRIMARY KEY,
    nombre_producto VARCHAR(200),
    codigo_categoria VARCHAR(20),
    ruc_proveedor VARCHAR(20),
    tamanio VARCHAR(30),
    precio_venta DECIMAL(14,2),
    costo DECIMAL(14,2),
    tiempo_preparacion_estandar_seg INTEGER,
    activo BOOLEAN,
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2.4. Receta Estándar
CREATE TABLE IF NOT EXISTS stg.mysql_receta_estandar (
    codigo_producto VARCHAR(30) PRIMARY KEY,
    cafe_premium_gramos DECIMAL(8,2),
    cafe_regular_gramos DECIMAL(8,2),
    leche_ml DECIMAL(8,2),
    otros_ingredientes TEXT,
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2.5. Empleados
CREATE TABLE IF NOT EXISTS stg.mysql_empleado (
    id_empleado VARCHAR(30) PRIMARY KEY,
    nombre_empleado VARCHAR(150),
    documento VARCHAR(30),
    fecha_contratacion DATE,
    certificacion VARCHAR(50),
    tienda_origen VARCHAR(150),
    activo BOOLEAN,
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2.6. Registro de Turnos
CREATE TABLE IF NOT EXISTS stg.mysql_registro_turno (
    id_turno VARCHAR(30) PRIMARY KEY,
    id_empleado VARCHAR(30),
    fecha DATE,
    hora_inicio TIME,
    hora_fin TIME,
    pausa_inicio TIME,
    pausa_fin TIME,
    horas_trabajadas DECIMAL(5,2),
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2.7. Atención al Cliente
CREATE TABLE IF NOT EXISTS stg.mysql_atencion_cliente (
    id_atencion VARCHAR(30) PRIMARY KEY,
    id_empleado VARCHAR(30),
    fecha DATE,
    hora_llegada TIME,
    hora_atencion TIME,
    hora_entrega TIME,
    tiempo_espera_seg INTEGER,
    tiempo_preparacion_seg INTEGER,
    tipo_pedido VARCHAR(30),
    codigo_producto VARCHAR(30),
    tienda_origen VARCHAR(150),
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2.8. Preparación de Productos
CREATE TABLE IF NOT EXISTS stg.mysql_preparacion_producto (
    id_preparacion VARCHAR(30) PRIMARY KEY,
    id_empleado VARCHAR(30),
    codigo_producto VARCHAR(30),
    fecha TIMESTAMP,
    cantidad INTEGER,
    tiempo_preparacion_seg INTEGER,
    cafe_premium_gramos DECIMAL(8,2),
    cafe_regular_gramos DECIMAL(8,2),
    leche_ml DECIMAL(8,2),
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2.9. Inventario de Insumos
CREATE TABLE IF NOT EXISTS stg.mysql_inventario_insumo (
    id_insumo VARCHAR(30) PRIMARY KEY,
    tienda_origen VARCHAR(150),
    nombre_insumo VARCHAR(100),
    stock_actual DECIMAL(10,2),
    stock_minimo DECIMAL(10,2),
    unidad_medida VARCHAR(30),
    fecha_caducidad DATE,
    fecha_ultima_compra DATE,
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 3. STAGING - POSTGRESQL (BASE DE GESTIÓN)
-- ============================================================

-- 3.1. Zonas ✅ NUEVA
CREATE TABLE IF NOT EXISTS stg.pg_zona (
    codigo_zona VARCHAR(20) PRIMARY KEY,
    nombre_zona VARCHAR(100),
    responsable VARCHAR(150),
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3.2. Tiendas
CREATE TABLE IF NOT EXISTS stg.pg_tienda (
    codigo_tienda VARCHAR(20) PRIMARY KEY,
    nombre_tienda VARCHAR(150),
    codigo_zona VARCHAR(20),
    ciudad VARCHAR(100),
    direccion VARCHAR(250),
    capacidad_maxima INTEGER,
    maquinas_cafe INTEGER,
    fecha_apertura DATE,
    activa BOOLEAN,
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3.3. Segmentos de Clientes ✅ NUEVA
CREATE TABLE IF NOT EXISTS stg.pg_segmento_cliente (
    codigo_segmento VARCHAR(20) PRIMARY KEY,
    nombre_segmento VARCHAR(100),
    descripcion TEXT,
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3.4. Clientes
CREATE TABLE IF NOT EXISTS stg.pg_cliente (
    documento VARCHAR(30) PRIMARY KEY,
    nombres VARCHAR(150),
    ciudad VARCHAR(100),
    sexo VARCHAR(20),
    fecha_nacimiento DATE,
    codigo_segmento VARCHAR(20),
    fecha_registro DATE,
    correo VARCHAR(200),
    activo BOOLEAN,
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3.5. Empleados Gestión
CREATE TABLE IF NOT EXISTS stg.pg_empleado_gestion (
    id_empleado VARCHAR(30) PRIMARY KEY,
    documento VARCHAR(30),
    nombres VARCHAR(150),
    cargo VARCHAR(50),
    salario_mensual DECIMAL(14,2),
    fecha_contratacion DATE,
    codigo_tienda VARCHAR(20),
    certificacion VARCHAR(50),
    activo BOOLEAN,
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3.6. Horario Ideal ✅ NUEVA
CREATE TABLE IF NOT EXISTS stg.pg_horario_ideal (
    id_horario VARCHAR(30) PRIMARY KEY,
    codigo_tienda VARCHAR(20),
    dia_semana VARCHAR(20),
    hora_inicio TIME,
    hora_fin TIME,
    baristas_requeridos INTEGER,
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3.7. Metas Operativas
CREATE TABLE IF NOT EXISTS stg.pg_meta_operativa (
    id_meta VARCHAR(30) PRIMARY KEY,
    codigo_tienda VARCHAR(20),
    periodo DATE,
    meta_tiempo_espera_seg INTEGER,
    meta_productividad_min DECIMAL(5,2),
    meta_merma_max DECIMAL(5,2),
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3.8. Encuestas de Calidad
CREATE TABLE IF NOT EXISTS stg.pg_encuesta_calidad (
    id_encuesta_origen BIGINT PRIMARY KEY,
    fecha DATE,
    codigo_tienda VARCHAR(20),
    documento_cliente VARCHAR(30),
    puntuacion_calidad_cafe INTEGER,
    puntuacion_rapidez INTEGER,
    puntuacion_amabilidad INTEGER,
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 4. VERIFICACIÓN FINAL
-- ============================================================
SELECT '✅ Esquema STG completado con todas las tablas' AS mensaje;
SELECT '📊 Tablas de staging:' AS mensaje;
SELECT table_name FROM information_schema.tables WHERE table_schema = 'stg' ORDER BY table_name;