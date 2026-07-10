-- 03_postgresql_cafeteria_historial.sql
-- CARGA HISTÓRICA PARA POSTGRESQL - ENFOQUE OPERATIVO
-- Clientes corporativos, metas operativas y encuestas de calidad (2024-2026)

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
-- 2. METAS OPERATIVAS (Julio 2024 - Julio 2026)
-- =====================================================
WITH meses AS (
    SELECT generate_series(DATE '2024-07-01', DATE '2026-07-01', INTERVAL '1 month')::date AS periodo
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
        CASE t.codigo_tienda
            WHEN 'CENTRO' THEN 150 + (EXTRACT(YEAR FROM m.periodo)::int - 2024) * 10
            WHEN 'NORTE' THEN 180 + (EXTRACT(YEAR FROM m.periodo)::int - 2024) * 10
            WHEN 'SUR' THEN 220 + (EXTRACT(YEAR FROM m.periodo)::int - 2024) * 15
            ELSE 180 + (EXTRACT(YEAR FROM m.periodo)::int - 2024) * 10
        END - CASE EXTRACT(MONTH FROM m.periodo)::int
            WHEN 7 THEN 10 WHEN 8 THEN 5 WHEN 12 THEN 15 ELSE 0
        END AS meta_tiempo_espera_seg,
        ROUND((
            CASE t.codigo_tienda
                WHEN 'CENTRO' THEN 70
                WHEN 'NORTE' THEN 65
                WHEN 'SUR' THEN 55
                ELSE 60
            END
            + (EXTRACT(YEAR FROM m.periodo)::int - 2024) * 3
            - CASE EXTRACT(MONTH FROM m.periodo)::int
                WHEN 1 THEN 5 WHEN 12 THEN 10 ELSE 0
            END
        )::numeric, 2) AS meta_productividad_min,
        ROUND((
            CASE t.codigo_tienda
                WHEN 'CENTRO' THEN 7
                WHEN 'NORTE' THEN 8
                WHEN 'SUR' THEN 10
                ELSE 8
            END
            - (EXTRACT(YEAR FROM m.periodo)::int - 2024) * 0.5
            + CASE EXTRACT(MONTH FROM m.periodo)::int
                WHEN 6 THEN 2 WHEN 7 THEN 3 WHEN 12 THEN 4 ELSE 0
            END
        )::numeric, 2) AS meta_merma_max
    FROM meses m
    CROSS JOIN tiendas t
)
INSERT INTO meta_operativa (codigo_tienda, periodo, meta_tiempo_espera_seg, meta_productividad_min, meta_merma_max)
SELECT codigo_tienda, periodo, meta_tiempo_espera_seg, meta_productividad_min, meta_merma_max
FROM metas
ON CONFLICT (codigo_tienda, periodo) DO NOTHING;

-- =====================================================
-- 3. ENCUESTAS DE CALIDAD HISTÓRICAS (Julio 2024 - Julio 2026)
-- =====================================================
DELETE FROM encuesta_calidad
WHERE comentario LIKE 'Historico BI Operativo%';

INSERT INTO encuesta_calidad
    (fecha, codigo_tienda, documento_cliente, puntuacion_calidad_cafe, puntuacion_rapidez, puntuacion_amabilidad, comentario)
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
    END AS puntuacion_calidad_cafe,
    CASE
        WHEN MOD(n + EXTRACT(MONTH FROM m.periodo)::int, 5) = 0 THEN 2
        WHEN MOD(n + EXTRACT(MONTH FROM m.periodo)::int, 7) = 0 THEN 5
        ELSE 3 + MOD(n + EXTRACT(MONTH FROM m.periodo)::int, 3)
    END AS puntuacion_rapidez,
    CASE
        WHEN MOD(n + EXTRACT(MONTH FROM m.periodo)::int, 4) = 0 THEN 3
        ELSE 4 + MOD(n + EXTRACT(MONTH FROM m.periodo)::int, 2)
    END AS puntuacion_amabilidad,
    CASE
        WHEN t.codigo_tienda = 'SUR' THEN 'Historico BI Operativo - oportunidad de mejora en atencion'
        WHEN t.codigo_tienda = 'CENTRO' THEN 'Historico BI Operativo - atencion rapida'
        WHEN t.codigo_tienda = 'NORTE' THEN 'Historico BI Operativo - buena atencion'
        ELSE 'Historico BI Operativo - local comodo'
    END AS comentario
FROM generate_series(DATE '2024-07-01', DATE '2026-07-01', INTERVAL '1 month') AS m(periodo)
CROSS JOIN (VALUES ('NORTE'), ('CENTRO'), ('SUR'), ('VALLE')) AS t(codigo_tienda)
CROSS JOIN generate_series(1, 4) AS n;

-- =====================================================
-- 4. REGISTROS PROBLEMÁTICOS ADICIONALES
-- =====================================================
INSERT INTO encuesta_calidad
    (fecha, codigo_tienda, documento_cliente, puntuacion_calidad_cafe, puntuacion_rapidez, puntuacion_amabilidad, comentario)
VALUES
    (DATE '2025-06-15', 'SUR', '1712345608', 7, 8, 6, 'Historico BI Operativo - puntuacion invalida (7 > 5)'),
    (DATE '2025-09-20', 'SUR', '171-234-5701', 0, 1, 2, 'Historico BI Operativo - puntuacion cero'),
    (DATE '2026-02-10', 'VALLE', '1712345601 ', 6, 4, 5, 'Historico BI Operativo - puntuacion fuera de rango'),
    (DATE '2026-05-25', 'NORTE', '171.234.5716', 8, 7, 6, 'Historico BI Operativo - doble problema');

-- =====================================================
-- 5. HORARIO IDEAL PARA TODAS LAS TIENDAS (COMPLETAR)
-- =====================================================
INSERT INTO horario_ideal (codigo_tienda, dia_semana, hora_inicio, hora_fin, baristas_requeridos)
SELECT
    t.codigo_tienda,
    d.dia_semana,
    h.hora_inicio,
    h.hora_fin,
    CASE t.codigo_tienda
        WHEN 'CENTRO' THEN h.baristas_requeridos + 1
        WHEN 'NORTE' THEN h.baristas_requeridos
        WHEN 'VALLE' THEN h.baristas_requeridos
        ELSE GREATEST(1, h.baristas_requeridos - 1)
    END AS baristas_requeridos
FROM (VALUES ('NORTE'), ('CENTRO'), ('SUR'), ('VALLE')) AS t(codigo_tienda)
CROSS JOIN (VALUES ('Lunes'), ('Martes'), ('Miercoles'), ('Jueves'), ('Viernes'), ('Sabado'), ('Domingo')) AS d(dia_semana)
CROSS JOIN (
    VALUES ('08:00:00'::time, '10:00:00'::time, 2),
           ('10:00:00'::time, '14:00:00'::time, 3),
           ('14:00:00'::time, '18:00:00'::time, 2),
           ('18:00:00'::time, '20:00:00'::time, 1)
) AS h(hora_inicio, hora_fin, baristas_requeridos)
ON CONFLICT DO NOTHING;

-- =====================================================
-- 6. COMPROBACIONES
-- =====================================================
SELECT '=== CLIENTES CORPORATIVOS AGREGADOS ===' AS mensaje;
SELECT COUNT(*) AS nuevos_clientes
FROM cliente
WHERE documento LIKE '17250000%';

SELECT '=== METAS OPERATIVAS GENERADAS ===' AS mensaje;
SELECT
    TO_CHAR(periodo, 'YYYY-MM') AS periodo,
    COUNT(*) AS metas_cargadas,
    ROUND(AVG(meta_tiempo_espera_seg)::numeric, 0) AS espera_promedio_meta,
    ROUND(AVG(meta_productividad_min)::numeric, 2) AS productividad_promedio_meta
FROM meta_operativa
GROUP BY TO_CHAR(periodo, 'YYYY-MM')
ORDER BY periodo;

SELECT '=== ENCUESTAS DE CALIDAD GENERADAS ===' AS mensaje;
SELECT
    TO_CHAR(fecha, 'YYYY-MM') AS periodo,
    codigo_tienda,
    COUNT(*) AS encuestas,
    ROUND(AVG(puntuacion_calidad_cafe)::numeric, 2) AS calidad_cafe_promedio,
    ROUND(AVG(puntuacion_rapidez)::numeric, 2) AS rapidez_promedio
FROM encuesta_calidad
WHERE comentario LIKE 'Historico BI Operativo%'
GROUP BY TO_CHAR(fecha, 'YYYY-MM'), codigo_tienda
ORDER BY periodo, codigo_tienda;

SELECT '=== TOTAL DE REGISTROS POR TABLA ===' AS mensaje;
SELECT 'zona' AS tabla, COUNT(*) AS registros FROM zona
UNION ALL
SELECT 'tienda', COUNT(*) FROM tienda
UNION ALL
SELECT 'segmento_cliente', COUNT(*) FROM segmento_cliente
UNION ALL
SELECT 'cliente', COUNT(*) FROM cliente
UNION ALL
SELECT 'empleado_gestion', COUNT(*) FROM empleado_gestion
UNION ALL
SELECT 'horario_ideal', COUNT(*) FROM horario_ideal
UNION ALL
SELECT 'meta_operativa', COUNT(*) FROM meta_operativa
UNION ALL
SELECT 'encuesta_calidad', COUNT(*) FROM encuesta_calidad;

SELECT '=== PROBLEMAS DE CALIDAD EN ENCUESTAS ===' AS mensaje;
SELECT 
    'Puntuacion fuera de rango (0,6,7,8)' AS descripcion,
    COUNT(*) AS cantidad
FROM encuesta_calidad
WHERE puntuacion_calidad_cafe NOT BETWEEN 1 AND 5
   OR puntuacion_rapidez NOT BETWEEN 1 AND 5
   OR puntuacion_amabilidad NOT BETWEEN 1 AND 5
UNION ALL
SELECT 
    'Documentos con guiones, puntos o espacios',
    COUNT(*)
FROM encuesta_calidad
WHERE documento_cliente LIKE '%-%' 
   OR documento_cliente LIKE '%.%' 
   OR documento_cliente LIKE '% %';