-- 05_dw_cafe.sql
-- SCRIPT PARA CREAR EL ESQUEMA DATA WAREHOUSE (dw)
-- CUBO DE CLIENTES ATENDIDOS - EFICIENCIA OPERATIVA
-- DIMENSIONES: TIEMPO, TIENDA, BARISTA

-- ============================================================
-- 1. CREAR ESQUEMA DW
-- ============================================================

CREATE SCHEMA IF NOT EXISTS dw;

-- ============================================================
-- 2. DIMENSIÓN TIEMPO (Calendario)
-- ============================================================

CREATE TABLE IF NOT EXISTS dw.dim_tiempo (
    fecha_key INTEGER PRIMARY KEY,
    fecha DATE NOT NULL UNIQUE,
    anio INTEGER NOT NULL,
    semestre SMALLINT NOT NULL,
    trimestre SMALLINT NOT NULL,
    numero_mes SMALLINT NOT NULL,
    nombre_mes VARCHAR(15) NOT NULL,
    anio_mes VARCHAR(7) NOT NULL,
    numero_semana SMALLINT NOT NULL,
    dia_mes SMALLINT NOT NULL,
    numero_dia_semana SMALLINT NOT NULL,
    nombre_dia VARCHAR(15) NOT NULL,
    es_fin_semana BOOLEAN NOT NULL,
    
    CONSTRAINT ck_dim_tiempo_semestre CHECK (semestre BETWEEN 1 AND 2),
    CONSTRAINT ck_dim_tiempo_trimestre CHECK (trimestre BETWEEN 1 AND 4),
    CONSTRAINT ck_dim_tiempo_mes CHECK (numero_mes BETWEEN 1 AND 12),
    CONSTRAINT ck_dim_tiempo_dia_semana CHECK (numero_dia_semana BETWEEN 1 AND 7)
);

-- ============================================================
-- 3. DIMENSIÓN TIENDA (Sucursales)
-- ============================================================

CREATE TABLE IF NOT EXISTS dw.dim_tienda (
    tienda_key BIGSERIAL PRIMARY KEY,
    codigo_tienda VARCHAR(20) NOT NULL,
    nombre_tienda VARCHAR(150) NOT NULL,
    zona VARCHAR(50),
    ciudad VARCHAR(100),
    direccion VARCHAR(250),
    capacidad_maxima INTEGER,
    maquinas_cafe INTEGER,
    fecha_apertura DATE,
    activa BOOLEAN,
    fecha_carga_dw TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uq_dim_tienda_codigo UNIQUE (codigo_tienda)
);

-- ============================================================
-- 4. DIMENSIÓN BARISTA (Empleados)
-- ============================================================

CREATE TABLE IF NOT EXISTS dw.dim_barista (
    barista_key BIGSERIAL PRIMARY KEY,
    codigo_barista VARCHAR(20) NOT NULL,
    nombre_barista VARCHAR(150) NOT NULL,
    certificacion VARCHAR(50),
    salario_mensual DECIMAL(10,2),
    fecha_contratacion DATE,
    tienda_codigo VARCHAR(20),
    activo BOOLEAN,
    fecha_carga_dw TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uq_dim_barista_codigo UNIQUE (codigo_barista)
);

-- ============================================================
-- 5. DIMENSIÓN HORA (Para análisis por hora del día)
-- ============================================================

CREATE TABLE IF NOT EXISTS dw.dim_hora (
    hora_key INTEGER PRIMARY KEY,
    hora TIME NOT NULL,
    hora_numero SMALLINT NOT NULL,
    minuto SMALLINT NOT NULL,
    rango_horario VARCHAR(20) NOT NULL, -- Mañana, Tarde, Noche, Madrugada
    es_hora_pico BOOLEAN DEFAULT FALSE,
    
    CONSTRAINT uq_dim_hora_time UNIQUE (hora),
    CONSTRAINT ck_dim_hora_hora CHECK (hora_numero BETWEEN 0 AND 23),
    CONSTRAINT ck_dim_hora_minuto CHECK (minuto BETWEEN 0 AND 59)
);

-- ============================================================
-- 6. TABLA DE HECHOS: ATENCIÓN AL CLIENTE
-- ============================================================

CREATE TABLE IF NOT EXISTS dw.fact_atencion (
    atencion_key BIGSERIAL PRIMARY KEY,
    
    -- Dimensiones
    fecha_key INTEGER NOT NULL,
    hora_key INTEGER NOT NULL,
    tienda_key BIGINT NOT NULL,
    barista_key BIGINT NOT NULL,
    
    -- Métricas
    cantidad_atendida INTEGER DEFAULT 1,
    tiempo_espera_seg INTEGER,
    tiempo_preparacion_seg INTEGER,
    tiempo_total_seg INTEGER,
    completada BOOLEAN DEFAULT TRUE,
    tipo_pedido VARCHAR(20),
    
    -- Fechas de carga
    fecha_carga_dw TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Restricciones
    CONSTRAINT fk_fact_atencion_tiempo 
        FOREIGN KEY (fecha_key) REFERENCES dw.dim_tiempo(fecha_key),
    CONSTRAINT fk_fact_atencion_hora 
        FOREIGN KEY (hora_key) REFERENCES dw.dim_hora(hora_key),
    CONSTRAINT fk_fact_atencion_tienda 
        FOREIGN KEY (tienda_key) REFERENCES dw.dim_tienda(tienda_key),
    CONSTRAINT fk_fact_atencion_barista 
        FOREIGN KEY (barista_key) REFERENCES dw.dim_barista(barista_key)
);

-- ============================================================
-- 7. ÍNDICES PARA MEJORAR RENDIMIENTO
-- ============================================================

CREATE INDEX idx_fact_atencion_fecha ON dw.fact_atencion(fecha_key);
CREATE INDEX idx_fact_atencion_hora ON dw.fact_atencion(hora_key);
CREATE INDEX idx_fact_atencion_tienda ON dw.fact_atencion(tienda_key);
CREATE INDEX idx_fact_atencion_barista ON dw.fact_atencion(barista_key);
CREATE INDEX idx_fact_atencion_completada ON dw.fact_atencion(completada);
CREATE INDEX idx_dim_tienda_codigo ON dw.dim_tienda(codigo_tienda);
CREATE INDEX idx_dim_barista_codigo ON dw.dim_barista(codigo_barista);

-- ============================================================
-- 8. VISTA AUXILIAR PARA GENERAR CALENDARIO
-- ============================================================

CREATE OR REPLACE VIEW dw.view_aux_calendario AS
WITH rangos AS (
    SELECT
        MIN(fecha) AS fecha_inicio,
        MAX(fecha) AS fecha_fin
    FROM stg.mysql_atencion_cliente
)
SELECT
    TO_CHAR(f.fecha, 'YYYYMMDD')::INTEGER AS fecha_key,
    f.fecha::DATE AS fecha,
    EXTRACT(YEAR FROM f.fecha)::INTEGER AS anio,
    CASE
        WHEN EXTRACT(MONTH FROM f.fecha) BETWEEN 1 AND 6 THEN 1
        ELSE 2
    END AS semestre,
    EXTRACT(QUARTER FROM f.fecha)::SMALLINT AS trimestre,
    EXTRACT(MONTH FROM f.fecha)::SMALLINT AS numero_mes,
    CASE EXTRACT(MONTH FROM f.fecha)
        WHEN 1 THEN 'Enero'
        WHEN 2 THEN 'Febrero'
        WHEN 3 THEN 'Marzo'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Mayo'
        WHEN 6 THEN 'Junio'
        WHEN 7 THEN 'Julio'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Septiembre'
        WHEN 10 THEN 'Octubre'
        WHEN 11 THEN 'Noviembre'
        WHEN 12 THEN 'Diciembre'
    END AS nombre_mes,
    TO_CHAR(f.fecha, 'YYYY-MM') AS anio_mes,
    EXTRACT(WEEK FROM f.fecha)::SMALLINT AS numero_semana,
    EXTRACT(DAY FROM f.fecha)::SMALLINT AS dia_mes,
    EXTRACT(ISODOW FROM f.fecha)::SMALLINT AS numero_dia_semana,
    CASE EXTRACT(ISODOW FROM f.fecha)
        WHEN 1 THEN 'Lunes'
        WHEN 2 THEN 'Martes'
        WHEN 3 THEN 'Miércoles'
        WHEN 4 THEN 'Jueves'
        WHEN 5 THEN 'Viernes'
        WHEN 6 THEN 'Sábado'
        WHEN 7 THEN 'Domingo'
    END AS nombre_dia,
    CASE
        WHEN EXTRACT(ISODOW FROM f.fecha) IN (6, 7) THEN TRUE
        ELSE FALSE
    END AS es_fin_semana
FROM rangos r
CROSS JOIN LATERAL generate_series(
    r.fecha_inicio,
    r.fecha_fin,
    INTERVAL '1 day'
) AS f(fecha)
ORDER BY f.fecha;

-- ============================================================
-- 9. VISTA AUXILIAR PARA GENERAR HORAS
-- ============================================================

CREATE OR REPLACE VIEW dw.view_aux_horas AS
SELECT
    TO_CHAR(h.hora, 'HH24MI')::INTEGER AS hora_key,
    h.hora::TIME AS hora,
    EXTRACT(HOUR FROM h.hora)::SMALLINT AS hora_numero,
    EXTRACT(MINUTE FROM h.hora)::SMALLINT AS minuto,
    CASE
        WHEN EXTRACT(HOUR FROM h.hora) BETWEEN 6 AND 11 THEN 'Mañana'
        WHEN EXTRACT(HOUR FROM h.hora) BETWEEN 12 AND 17 THEN 'Tarde'
        WHEN EXTRACT(HOUR FROM h.hora) BETWEEN 18 AND 23 THEN 'Noche'
        ELSE 'Madrugada'
    END AS rango_horario,
    CASE
        WHEN EXTRACT(HOUR FROM h.hora) BETWEEN 8 AND 10 THEN TRUE
        WHEN EXTRACT(HOUR FROM h.hora) BETWEEN 17 AND 19 THEN TRUE
        ELSE FALSE
    END AS es_hora_pico
FROM generate_series('00:00:00'::time, '23:59:00'::time, '1 minute'::interval) AS h(hora);

-- ============================================================
-- 10. VERIFICACIÓN
-- ============================================================

DO $$
BEGIN
    RAISE NOTICE '✅ Esquema DW creado correctamente';
    RAISE NOTICE '📊 Tablas creadas:';
    RAISE NOTICE '   - dw.dim_tiempo (Calendario)';
    RAISE NOTICE '   - dw.dim_tienda (Sucursales)';
    RAISE NOTICE '   - dw.dim_barista (Empleados)';
    RAISE NOTICE '   - dw.dim_hora (Horas del día)';
    RAISE NOTICE '   - dw.fact_atencion (Hechos)';
    RAISE NOTICE '📊 Vistas auxiliares:';
    RAISE NOTICE '   - dw.view_aux_calendario (Genera fechas desde atenciones)';
    RAISE NOTICE '   - dw.view_aux_horas (Genera todas las horas del día)';
END $$;