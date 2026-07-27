-- ============================================================
-- CUBO DE CALIDAD Y SATISFACCIÓN DEL CLIENTE
-- ============================================================

-- DIMENSIÓN TIENDA (Enriquecida con zona)
CREATE TABLE IF NOT EXISTS dw.dim_tienda_calidad (
    tienda_key BIGSERIAL PRIMARY KEY,
    codigo_tienda VARCHAR(20) NOT NULL,
    nombre_tienda VARCHAR(150) NOT NULL,
    codigo_zona VARCHAR(20),
    nombre_zona VARCHAR(100),
    ciudad VARCHAR(100),
    direccion VARCHAR(250),
    capacidad_maxima INTEGER,
    maquinas_cafe INTEGER,
    fecha_apertura DATE,
    activa BOOLEAN,
    fecha_carga_dw TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_dim_tienda_calidad_codigo UNIQUE (codigo_tienda)
);

-- DIMENSIÓN CLIENTE
CREATE TABLE IF NOT EXISTS dw.dim_cliente (
    cliente_key BIGSERIAL PRIMARY KEY,
    documento VARCHAR(30) NOT NULL,
    nombres VARCHAR(150),
    ciudad VARCHAR(100),
    sexo VARCHAR(20),
    fecha_nacimiento DATE,
    codigo_segmento VARCHAR(20),
    nombre_segmento VARCHAR(100),
    fecha_registro DATE,
    correo VARCHAR(200),
    activo BOOLEAN,
    fecha_carga_dw TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_dim_cliente_documento UNIQUE (documento)
);

-- TABLA DE HECHOS: ENCUESTAS
CREATE TABLE IF NOT EXISTS dw.fact_encuesta (
    encuesta_key BIGSERIAL PRIMARY KEY,
    
    -- Dimensiones
    fecha_key INTEGER NOT NULL,
    tienda_key BIGINT NOT NULL,
    cliente_key BIGINT,
    
    -- Métricas
    puntuacion_calidad_cafe INTEGER,
    puntuacion_rapidez INTEGER,
    puntuacion_amabilidad INTEGER,
    puntuacion_total INTEGER,
    puntuacion_promedio DECIMAL(5,2),
    encuesta_valida BOOLEAN DEFAULT TRUE,
    
    -- Fechas de carga
    fecha_carga_dw TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Restricciones
    CONSTRAINT fk_fact_encuesta_tiempo 
        FOREIGN KEY (fecha_key) REFERENCES dw.dim_tiempo(fecha_key),
    CONSTRAINT fk_fact_encuesta_tienda 
        FOREIGN KEY (tienda_key) REFERENCES dw.dim_tienda_calidad(tienda_key),
    CONSTRAINT fk_fact_encuesta_cliente 
        FOREIGN KEY (cliente_key) REFERENCES dw.dim_cliente(cliente_key)
);

-- Índices
CREATE INDEX idx_fact_encuesta_fecha ON dw.fact_encuesta(fecha_key);
CREATE INDEX idx_fact_encuesta_tienda ON dw.fact_encuesta(tienda_key);
CREATE INDEX idx_fact_encuesta_cliente ON dw.fact_encuesta(cliente_key);
CREATE INDEX idx_fact_encuesta_valida ON dw.fact_encuesta(encuesta_valida);
CREATE INDEX idx_dim_cliente_documento ON dw.dim_cliente(documento);
CREATE INDEX idx_dim_tienda_calidad_codigo ON dw.dim_tienda_calidad(codigo_tienda);