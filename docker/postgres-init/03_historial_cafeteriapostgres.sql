-- 03_historial_cafeteriapostgres.sql
-- CARGA HISTÓRICA PARA POSTGRESQL
-- VERSIÓN CORREGIDA: SIN '' EN ALIAS

SET search_path TO gestion_cafe, public;

-- =====================================================
-- 1. CLIENTES CORPORATIVOS ADICIONALES (25 registros)
-- =====================================================
INSERT INTO cliente
    (documento, nombres, ciudad, fecha_nacimiento, sexo, codigo_segmento, fecha_registro, correo, activo)
SELECT
    '17250000' || LPAD(g::text, 2, '0') AS documento,
    CASE MOD(g, 8)
        WHEN 0 THEN 'Roberto Almeida'
        WHEN 1 THEN 'Teresa Salazar'
        WHEN 2 THEN 'Sofia Torres'
        WHEN 3 THEN 'Carlos Benitez'
        WHEN 4 THEN 'Lucia Andrade'
        WHEN 5 THEN 'Mateo Zambrano'
        WHEN 6 THEN 'Andrea Flores'
        ELSE 'Jorge Merino'
    END AS nombres,
    CASE MOD(g, 5)
        WHEN 0 THEN 'Quito'
        WHEN 1 THEN 'Sangolqui'
        WHEN 2 THEN 'Cumbaya'
        WHEN 3 THEN 'quito '
        ELSE 'QUITO'
    END AS ciudad,
    DATE '1975-01-01' + (g * 313) AS fecha_nacimiento,
    CASE MOD(g, 2) WHEN 0 THEN 'M' ELSE 'F' END AS sexo,
    CASE MOD(g, 4)
        WHEN 0 THEN 'NUEVO'
        WHEN 1 THEN 'FREC'
        WHEN 2 THEN 'VIP'
        ELSE 'INACT'
    END AS codigo_segmento,
    DATE '2024-07-01' + (g * 23) AS fecha_registro,
    'cliente_hist_' || g || '@correo.com' AS correo,
    TRUE AS activo
FROM generate_series(1, 25) AS g
WHERE NOT EXISTS (
    SELECT 1
    FROM cliente c
    WHERE c.documento = '17250000' || LPAD(g::text, 2, '0')
);

-- =====================================================
-- 2. METAS MENSUALES (Julio 2024 - Diciembre 2024)
-- =====================================================
WITH meses AS (
    SELECT generate_series(DATE '2024-07-01', DATE '2024-12-01', INTERVAL '1 month')::date AS periodo
),
tiendas AS (
    SELECT codigo_tienda
    FROM tienda
    WHERE codigo_tienda IN ('NORTE', 'CENTRO', 'SUR', 'VALLE')
),
metas AS (
    SELECT
        t.codigo_tienda,
        m.periodo,
        ROUND((
            CASE t.codigo_tienda
                WHEN 'NORTE' THEN 2600
                WHEN 'CENTRO' THEN 1800
                WHEN 'SUR' THEN 1500
                WHEN 'VALLE' THEN 2200
            END
            * CASE EXTRACT(MONTH FROM m.periodo)::int
                WHEN 7 THEN 0.85
                WHEN 8 THEN 0.90
                WHEN 9 THEN 0.95
                WHEN 10 THEN 1.00
                WHEN 11 THEN 1.05
                WHEN 12 THEN 1.10
            END
        )::numeric, 2) AS meta_ventas,
        ROUND((
            CASE t.codigo_tienda
                WHEN 'NORTE' THEN 120
                WHEN 'CENTRO' THEN 90
                WHEN 'SUR' THEN 80
                WHEN 'VALLE' THEN 100
            END
            * 0.90
        )::numeric, 0)::integer AS meta_clientes,
        ROUND((
            CASE t.codigo_tienda
                WHEN 'NORTE' THEN 4.30
                WHEN 'CENTRO' THEN 4.20
                WHEN 'SUR' THEN 4.00
                WHEN 'VALLE' THEN 4.10
            END
            * 0.95
        )::numeric, 2) AS meta_satisfaccion
    FROM meses m
    CROSS JOIN tiendas t
)
INSERT INTO meta_mensual (codigo_tienda, periodo, meta_ventas, meta_clientes, meta_satisfaccion)
SELECT codigo_tienda, periodo, meta_ventas, meta_clientes, meta_satisfaccion
FROM metas
ON CONFLICT (codigo_tienda, periodo)
DO NOTHING;

-- =====================================================
-- 3. ENCUESTAS HISTÓRICAS (Julio 2024 - Julio 2026)
-- =====================================================
DELETE FROM encuesta_satisfaccion
WHERE comentario LIKE 'Historico BI Cafe%';

INSERT INTO encuesta_satisfaccion
    (fecha, codigo_tienda, documento_cliente, puntuacion, tiempo_espera_minutos, comentario)
SELECT
    (m.periodo + ((n * 5 + EXTRACT(MONTH FROM m.periodo)::int) % 28) * INTERVAL '1 day')::date AS fecha,
    t.codigo_tienda,
    CASE MOD(n + EXTRACT(MONTH FROM m.periodo)::int, 15)
        WHEN 0 THEN '1712345601'
        WHEN 1 THEN '1712345602'
        WHEN 2 THEN '1712345603'
        WHEN 3 THEN '1712345610 '
        WHEN 4 THEN '171-234-5615'
        WHEN 5 THEN '171.234.5716'
        WHEN 6 THEN '9999999999'
        WHEN 7 THEN '1725000001'
        WHEN 8 THEN '1725000005'
        ELSE '17123456' || LPAD((1 + MOD(n + EXTRACT(MONTH FROM m.periodo)::int + EXTRACT(YEAR FROM m.periodo)::int, 30))::text, 2, '0')
    END AS documento_cliente,
    CASE
        WHEN t.codigo_tienda = 'SUR' AND MOD(n + EXTRACT(MONTH FROM m.periodo)::int, 6) = 0 THEN 2
        WHEN t.codigo_tienda = 'CENTRO' AND MOD(n + EXTRACT(MONTH FROM m.periodo)::int, 8) = 0 THEN 5
        WHEN MOD(n + EXTRACT(YEAR FROM m.periodo)::int, 9) = 0 THEN 1
        WHEN MOD(n + EXTRACT(YEAR FROM m.periodo)::int, 7) = 0 THEN 6
        ELSE 4
    END AS puntuacion,
    CASE t.codigo_tienda
        WHEN 'CENTRO' THEN 4 + MOD(n * 2 + EXTRACT(MONTH FROM m.periodo)::int, 10)
        WHEN 'NORTE' THEN 8 + MOD(n * 3 + EXTRACT(MONTH FROM m.periodo)::int, 16)
        WHEN 'VALLE' THEN 9 + MOD(n * 4 + EXTRACT(MONTH FROM m.periodo)::int, 20)
        ELSE 18 + MOD(n * 5 + EXTRACT(MONTH FROM m.periodo)::int, 35)
    END AS tiempo_espera_minutos,
    CASE
        WHEN t.codigo_tienda = 'SUR' THEN 'Historico BI Cafe - oportunidad de mejora en atencion'
        WHEN t.codigo_tienda = 'CENTRO' THEN 'Historico BI Cafe - atencion rapida'
        WHEN t.codigo_tienda = 'NORTE' THEN 'Historico BI Cafe - buena atencion'
        ELSE 'Historico BI Cafe - local comodo'
    END AS comentario
FROM generate_series(DATE '2024-07-01', DATE '2026-07-01', INTERVAL '1 month') AS m(periodo)
CROSS JOIN (VALUES ('NORTE'), ('CENTRO'), ('SUR'), ('VALLE')) AS t(codigo_tienda)
CROSS JOIN generate_series(1, 4) AS n;

-- =====================================================
-- 4. REGISTROS PROBLEMÁTICOS ADICIONALES
-- =====================================================
INSERT INTO encuesta_satisfaccion
    (fecha, codigo_tienda, documento_cliente, puntuacion, tiempo_espera_minutos, comentario)
VALUES
    (DATE '2025-06-15', 'SUR', '1712345608', 7, 120, 'Historico BI Cafe - puntuacion invalida (7 > 5)'),
    (DATE '2025-09-20', 'SUR', '171-234-5701', 0, 90, 'Historico BI Cafe - puntuacion cero'),
    (DATE '2026-02-10', 'VALLE', '1712345601 ', 6, 75, 'Historico BI Cafe - puntuacion fuera de rango'),
    (DATE '2026-05-25', 'NORTE', '171.234.5716', 8, 110, 'Historico BI Cafe - doble problema');

-- =====================================================
-- 5. COMPROBACIONES (CORREGIDAS - SIN '' EN ALIAS)
-- =====================================================
SELECT '=== CLIENTES CORPORATIVOS AGREGADOS ===' AS mensaje;
SELECT COUNT(*) AS nuevos_clientes
FROM cliente
WHERE documento LIKE '17250000%';

SELECT '=== METAS MENSUALES AGREGADAS ===' AS mensaje;
SELECT
    TO_CHAR(periodo, 'YYYY-MM') AS periodo,
    COUNT(*) AS metas_cargadas,
    SUM(meta_ventas) AS meta_total
FROM meta_mensual
GROUP BY TO_CHAR(periodo, 'YYYY-MM')
ORDER BY periodo;

SELECT '=== TOTAL DE REGISTROS POR TABLA ===' AS mensaje;
SELECT 'zona' AS tabla, COUNT(*) AS registros FROM zona
UNION ALL
SELECT 'tienda', COUNT(*) FROM tienda
UNION ALL
SELECT 'segmento_cliente', COUNT(*) FROM segmento_cliente
UNION ALL
SELECT 'cliente', COUNT(*) FROM cliente
UNION ALL
SELECT 'meta_mensual', COUNT(*) FROM meta_mensual
UNION ALL
SELECT 'encuesta_satisfaccion', COUNT(*) FROM encuesta_satisfaccion;

SELECT '=== PROBLEMAS DE CALIDAD EN ENCUESTAS ===' AS mensaje;
SELECT 
    'Puntuacion fuera de rango (0,6,7,8)' AS descripcion,
    COUNT(*) AS cantidad
FROM encuesta_satisfaccion
WHERE puntuacion NOT BETWEEN 1 AND 5
UNION ALL
SELECT 
    'Tiempo de espera > 60 minutos',
    COUNT(*)
FROM encuesta_satisfaccion
WHERE tiempo_espera_minutos > 60
UNION ALL
SELECT 
    'Documentos con guiones, puntos o espacios',
    COUNT(*)
FROM encuesta_satisfaccion
WHERE documento_cliente LIKE '%-%' 
   OR documento_cliente LIKE '%.%' 
   OR documento_cliente LIKE '% %';