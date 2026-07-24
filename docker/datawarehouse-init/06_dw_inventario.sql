--06_dw_inventario
-- ============================================================
-- CUBO DE INVENTARIO Y ABASTECIMIENTO
-- ESQUEMA: dw
-- ============================================================

-- DIMENSIÓN PRODUCTO (Enriquecida con categoría, proveedor y receta)
CREATE TABLE IF NOT EXISTS dw.dim_producto_inventario (
    producto_key BIGSERIAL PRIMARY KEY,
    codigo_producto VARCHAR(30) NOT NULL,
    nombre_producto VARCHAR(200) NOT NULL,
    codigo_categoria VARCHAR(20),
    nombre_categoria VARCHAR(150),
    ruc_proveedor VARCHAR(20),
    nombre_proveedor VARCHAR(150),
    pais_proveedor VARCHAR(100),
    tamanio VARCHAR(30),
    precio_venta DECIMAL(14,2),
    costo DECIMAL(14,2),
    tiempo_preparacion_estandar_seg INTEGER,
    activo BOOLEAN,
    
    -- Campos de receta estándar (pueden ser NULL)
    cafe_premium_gramos DECIMAL(8,2),
    cafe_regular_gramos DECIMAL(8,2),
    leche_ml DECIMAL(8,2),
    otros_ingredientes TEXT,
    tiene_receta BOOLEAN DEFAULT FALSE,
    
    fecha_carga_dw TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_dim_producto_inventario_codigo UNIQUE (codigo_producto)
);

-- DIMENSIÓN TIENDA (Desde empleados)
CREATE TABLE IF NOT EXISTS dw.dim_tienda_inventario (
    tienda_key BIGSERIAL PRIMARY KEY,
    nombre_tienda VARCHAR(150) NOT NULL,
    -- Datos enriquecidos (se pueden completar manualmente o desde PostgreSQL)
    zona VARCHAR(50),
    ciudad VARCHAR(100),
    fecha_carga_dw TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_dim_tienda_inventario_nombre UNIQUE (nombre_tienda)
);

-- TABLA DE HECHOS: INVENTARIO
CREATE TABLE IF NOT EXISTS dw.fact_inventario (
    inventario_key BIGSERIAL PRIMARY KEY,
    
    -- Dimensiones
    fecha_key INTEGER NOT NULL,
    producto_key BIGINT NOT NULL,
    tienda_key BIGINT NOT NULL,
    
    -- Métricas del inventario
    stock_actual DECIMAL(10,2),
    stock_minimo DECIMAL(10,2),
    diferencia_stock DECIMAL(10,2), -- stock_actual - stock_minimo
    porcentaje_abastecimiento DECIMAL(8,2), -- (stock_actual / stock_minimo) * 100
    dias_para_caducar INTEGER, -- días hasta fecha_caducidad
    esta_critico BOOLEAN, -- stock_actual < stock_minimo
    esta_caducando BOOLEAN, -- dias_para_caducar < 30
    nivel_abastecimiento VARCHAR(20), -- 'CRITICO', 'BAJO', 'OK', 'EXCESO'
    
    -- Fechas de la transacción
    fecha_caducidad DATE,
    fecha_ultima_compra DATE,
    fecha_carga_dw TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Restricciones
    CONSTRAINT fk_fact_inventario_tiempo 
        FOREIGN KEY (fecha_key) REFERENCES dw.dim_tiempo(fecha_key),
    CONSTRAINT fk_fact_inventario_producto 
        FOREIGN KEY (producto_key) REFERENCES dw.dim_producto_inventario(producto_key),
    CONSTRAINT fk_fact_inventario_tienda 
        FOREIGN KEY (tienda_key) REFERENCES dw.dim_tienda_inventario(tienda_key)
);

-- Índices
CREATE INDEX idx_fact_inventario_fecha ON dw.fact_inventario(fecha_key);
CREATE INDEX idx_fact_inventario_producto ON dw.fact_inventario(producto_key);
CREATE INDEX idx_fact_inventario_tienda ON dw.fact_inventario(tienda_key);
CREATE INDEX idx_fact_inventario_critico ON dw.fact_inventario(esta_critico);
CREATE INDEX idx_fact_inventario_caducando ON dw.fact_inventario(esta_caducando);