-- 02_postgresql_cafeteria_datos_base.sql
-- DATOS BASE PARA POSTGRESQL - ENFOQUE OPERATIVO

SET search_path TO gestion_cafe, public;

-- =====================================================
-- 1. ZONAS
-- =====================================================
INSERT INTO zona (codigo_zona, nombre, responsable) VALUES
('ZN', 'Zona Norte', 'Ana Torres'),
('ZC', 'Zona Centro', 'Luis Paredes'),
('ZS', 'Zona Sur', 'Maria Silva'),
('ZV', 'Zona Valle', 'Carlos Ruiz');

-- =====================================================
-- 2. TIENDAS (CON CIUDADES INCONSISTENTES)
-- =====================================================
INSERT INTO tienda (codigo_tienda, nombre_oficial, codigo_zona, ciudad, direccion, capacidad_maxima, maquinas_cafe, fecha_apertura, activa) VALUES
('NORTE', 'Cafeteria Norte', 'ZN', 'Quito', 'Av. 10 de Agosto N45-20', 40, 3, '2022-02-01', TRUE),
('CENTRO', 'Cafeteria Centro Historico', 'ZC', 'QUITO', 'Guayaquil y Chile', 50, 4, '2020-08-15', TRUE),
('SUR', 'Cafeteria del Sur', 'ZS', 'quito ', 'Av. Maldonado S25-10', 35, 2, '2023-01-10', TRUE),
('VALLE', 'Cafeteria Valle de los Chillos', 'ZV', 'Sangolqui', 'Av. Calderon 101', 45, 3, '2024-04-20', TRUE);

-- =====================================================
-- 3. SEGMENTOS DE CLIENTES
-- =====================================================
INSERT INTO segmento_cliente (codigo_segmento, nombre, descripcion) VALUES
('NUEVO', 'Cliente nuevo', 'Registrado hace menos de seis meses'),
('FREC', 'Frecuente', 'Compra regularmente'),
('VIP', 'Cliente VIP', 'Alto valor y frecuencia'),
('INACT', 'Inactivo', 'Sin compras recientes');

-- =====================================================
-- 4. CLIENTES (CON INCONSISTENCIAS)
-- =====================================================
INSERT INTO cliente (documento, nombres, ciudad, fecha_nacimiento, sexo, codigo_segmento, fecha_registro, correo, activo) VALUES
('1712345601', 'Paola Rodriguez', 'Quito', '1974-10-22', 'F', 'NUEVO', '2024-04-25', 'paola_rodriguez@correo.com', TRUE),
('1712345602', 'Elena Mena', 'quito', '1989-10-02', 'M', 'FREC', '2025-06-15', 'elena_mena@correo.com', TRUE),
('1712345603', 'Camila Gomez', 'Sangolqui', '1973-09-12', 'F', 'FREC', '2025-04-04', 'camila_gomez@correo.com', TRUE),
('1712345604', 'Andrea Rodriguez', 'Quito ', '1998-07-18', 'M', 'FREC', '2025-12-15', 'andrea_rodriguez@correo.com', TRUE),
('1712345605', 'Jose Ortiz', 'quito', '1996-04-04', 'M', 'VIP', '2025-03-23', 'jose_ortiz@correo.com', TRUE),
('1712345511', 'MARIA PEREZ', 'QUITO', '1984-05-14', 'F', 'FREC', '2025-06-01', 'maria.perez@correo.com', TRUE),
('1712345615', 'Sofia Torres', 'quito', '1992-09-09', 'F', 'NUEVO', '2026-01-03', 'sofia@correo.com', TRUE),
('0000000000', 'Cliente de prueba', NULL, NULL, NULL, 'INACT', '2025-01-01', NULL, FALSE);

-- =====================================================
-- 5. EMPLEADOS GESTION
-- =====================================================
INSERT INTO empleado_gestion (documento, nombres, cargo, salario_mensual, fecha_contratacion, codigo_tienda, certificacion, activo) VALUES
('1712345601', 'Carlos Garcia', 'Barista Senior', 800.00, '2024-01-15', 'CENTRO', 'Avanzado', TRUE),
('1712345602', 'Maria Lopez', 'Barista', 750.00, '2024-02-01', 'CENTRO', 'Intermedio', TRUE),
('1712345603', 'Ana Torres', 'Barista', 700.00, '2024-03-10', 'NORTE', 'Intermedio', TRUE),
('1712345604', 'Luis Martinez', 'Barista', 700.00, '2024-04-20', 'NORTE', 'Basico', TRUE),
('1712345605', 'Pedro Jimenez', 'Barista', 700.00, '2024-05-15', 'SUR', 'Basico', TRUE),
('1712345606', 'Juan Perez', 'Barista', 750.00, '2024-06-01', 'SUR', 'Intermedio', TRUE),
('1712345607', 'Sofia Reyes', 'Barista Senior', 800.00, '2024-07-10', 'VALLE', 'Avanzado', TRUE),
('1712345608', 'Diego Flores', 'Barista', 650.00, '2024-08-20', 'VALLE', 'Basico', TRUE),
('1712345609', 'Laura Castro', 'Barista', 700.00, '2024-09-15', 'CENTRO', 'Intermedio', TRUE),
('1712345610 ', 'Pablo Ortiz', 'Barista Senior', 800.00, '2024-10-01', 'CENTRO', 'Avanzado', TRUE);

-- =====================================================
-- 6. HORARIO IDEAL
-- =====================================================
INSERT INTO horario_ideal (codigo_tienda, dia_semana, hora_inicio, hora_fin, baristas_requeridos) VALUES
('CENTRO', 'Lunes', '08:00:00', '10:00:00', 3),
('CENTRO', 'Lunes', '10:00:00', '14:00:00', 4),
('CENTRO', 'Lunes', '14:00:00', '18:00:00', 3),
('CENTRO', 'Lunes', '18:00:00', '20:00:00', 2),
('NORTE', 'Lunes', '08:00:00', '10:00:00', 2),
('NORTE', 'Lunes', '10:00:00', '14:00:00', 3),
('NORTE', 'Lunes', '14:00:00', '18:00:00', 2),
('NORTE', 'Lunes', '18:00:00', '20:00:00', 1),
('SUR', 'Lunes', '08:00:00', '10:00:00', 2),
('SUR', 'Lunes', '10:00:00', '14:00:00', 2),
('SUR', 'Lunes', '14:00:00', '18:00:00', 1),
('SUR', 'Lunes', '18:00:00', '20:00:00', 1);

-- =====================================================
-- 7. META OPERATIVA
-- =====================================================
INSERT INTO meta_operativa (codigo_tienda, periodo, meta_tiempo_espera_seg, meta_productividad_min, meta_merma_max) VALUES
('CENTRO', '2024-07-01', 180, 65.00, 8.00),
('NORTE', '2024-07-01', 240, 60.00, 10.00),
('SUR', '2024-07-01', 300, 55.00, 12.00),
('VALLE', '2024-07-01', 240, 60.00, 10.00),
('CENTRO', '2025-01-01', 150, 70.00, 7.00),
('NORTE', '2025-01-01', 200, 65.00, 8.00),
('SUR', '2025-01-01', 250, 60.00, 10.00),
('VALLE', '2025-01-01', 200, 65.00, 8.00),
('CENTRO', '2026-01-01', 120, 75.00, 6.00),
('NORTE', '2026-01-01', 180, 70.00, 7.00),
('SUR', '2026-01-01', 220, 65.00, 9.00),
('VALLE', '2026-01-01', 180, 70.00, 7.00);

-- =====================================================
-- 8. ENCUESTA CALIDAD (CON INCONSISTENCIAS)
-- =====================================================
INSERT INTO encuesta_calidad (fecha, codigo_tienda, documento_cliente, puntuacion_calidad_cafe, puntuacion_rapidez, puntuacion_amabilidad, comentario) VALUES
('2025-01-15', 'CENTRO', '1712345601', 4, 5, 4, 'Excelente servicio'),
('2025-01-20', 'NORTE', '1712345602', 5, 4, 5, 'Muy buena atencion'),
('2025-02-10', 'SUR', '1712345603', 3, 2, 4, 'No habia stock'),
('2025-02-15', 'VALLE', '1712345604', 4, 3, 4, 'Local comodo'),
('2025-03-01', 'CENTRO', '1712345605', 5, 5, 5, 'Proceso agil'),
('2025-06-01', 'SUR', '1712345611', 7, 8, 7, 'Muy buena atencion'),
('2025-06-15', 'VALLE', '1712345612', 0, 1, 2, 'Mala atencion'),
('2026-03-10', 'SUR', '1712345604', 6, 4, 5, 'Me gusto la atencion');