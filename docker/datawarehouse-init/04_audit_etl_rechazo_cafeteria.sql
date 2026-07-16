-- 04_audit_etl_rechazo_cafeteria.sql
-- SOLO ESTRUCTURA DE AUDITORÍA Y RECHAZO
-- Las validaciones se realizan en Pentaho

-- ============================================================
-- 1. CREAR ESQUEMA AUDIT
-- ============================================================
CREATE SCHEMA IF NOT EXISTS audit;

-- ============================================================
-- 2. TABLA PRINCIPAL DE RECHAZOS (SOLO ESTRUCTURA BÁSICA)
-- ============================================================
CREATE TABLE IF NOT EXISTS audit.etl_rechazo (
    id_rechazo BIGSERIAL PRIMARY KEY,
    fuente VARCHAR(80),           -- 'MySQL', 'PostgreSQL', 'Excel'
    entidad VARCHAR(80),          -- 'atencion_cliente', 'preparacion_producto', 'excel_evaluaciones'
    clave_origen VARCHAR(150),    -- Identificador del registro rechazado
    tipo_error VARCHAR(80),       -- 'TIENDA_NO_ENCONTRADA', 'PUNTUACION_FUERA_RANGO', 'FECHA_INVALIDA'
    descripcion_error TEXT,       -- Descripción detallada
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 3. ÍNDICES OPCIONALES (MEJORAN RENDIMIENTO)
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_etl_rechazo_fuente ON audit.etl_rechazo(fuente);
CREATE INDEX IF NOT EXISTS idx_etl_rechazo_entidad ON audit.etl_rechazo(entidad);
CREATE INDEX IF NOT EXISTS idx_etl_rechazo_tipo_error ON audit.etl_rechazo(tipo_error);
CREATE INDEX IF NOT EXISTS idx_etl_rechazo_fecha ON audit.etl_rechazo(fecha_registro);

-- ============================================================
-- 4. VERIFICACIÓN
-- ============================================================
DO $$
BEGIN
    RAISE NOTICE '✅ Auditoría y rechazo configurado correctamente';
    RAISE NOTICE '📊 Tabla: audit.etl_rechazo';
    RAISE NOTICE '📊 Campos: id_rechazo, fuente, entidad, clave_origen, tipo_error, descripcion_error, fecha_registro';
    RAISE NOTICE '🔧 Las validaciones se realizarán en Pentaho';
END $$;