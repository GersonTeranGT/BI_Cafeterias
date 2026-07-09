-- 02_datos_cafeteriapostgres.sql

SET search_path TO gestion_cafe, public;

-- =====================================================
-- 1. ZONAS
-- =====================================================
INSERT INTO zona (codigo_zona, nombre, responsable) VALUES
('ZN', 'Zona Norte', 'Ana Torres'),
('ZC', 'Zona Centro', 'Luis Paredes'),
('ZS', 'Zona Sur', 'María Silva'),
('ZV', 'Zona Valle', 'Carlos Ruiz');

-- =====================================================
-- 2. TIENDAS (CON CIUDADES INCONSISTENTES)
-- =====================================================
INSERT INTO tienda (codigo_tienda, nombre_oficial, codigo_zona, ciudad, direccion, latitud, longitud, fecha_apertura, activa) VALUES
('NORTE', 'Cafetería Norte', 'ZN', 'Quito', 'Av. 10 de Agosto N45-20', -0.180653, -78.484321, '2022-02-01', TRUE),
('CENTRO', 'Cafetería Centro Histórico', 'ZC', 'QUITO', 'Guayaquil y Chile', -0.220164, -78.512327, '2020-08-15', TRUE),
('SUR', 'Cafetería del Sur', 'ZS', 'quito ', 'Av. Maldonado S25-10', -0.285110, -78.548900, '2023-01-10', TRUE),
('VALLE', 'Cafetería Valle de los Chillos', 'ZV', 'Sangolquí', 'Av. Calderón 101', -0.334120, -78.449800, '2024-04-20', TRUE);

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

-- Clientes estándar
('1712345601', 'Paola Rodríguez', 'Quito', '1974-10-22', 'F', 'NUEVO', '2024-04-25', 'paola_rodriguez@correo.com', TRUE),
('1712345602', 'Elena Mena', 'quito', '1989-10-02', 'M', 'FREC', '2025-06-15', 'elena_mena@correo.com', TRUE),
('1712345603', 'Camila Gómez', 'Sangolquí', '1973-09-12', 'F', 'FREC', '2025-04-04', 'camila_gomez@correo.com', TRUE),
('1712345604', 'Andrea Rodríguez', 'Quito ', '1998-07-18', 'M', 'FREC', '2025-12-15', 'andrea_rodriguez@correo.com', TRUE),
('1712345605', 'José Ortiz', 'quito', '1996-04-04', 'M', 'VIP', '2025-03-23', 'jose_ortiz@correo.com', TRUE),
('1712345606', 'Jorge Gómez', NULL, '1985-11-12', 'M', 'FREC', '2025-05-28', 'jorge_gomez@correo.com', TRUE),
('1712345607', 'Daniela Rodríguez', NULL, '1988-09-08', 'M', 'INACT', '2024-04-26', 'daniela_rodriguez@correo.com', TRUE),
('1712345608', 'Jorge Pérez', 'quito', '2000-10-12', 'F', 'VIP', '2026-03-20', 'jorge_perez@correo.com', TRUE),
('1712345609', 'Valeria Gómez', 'Quito', '1984-07-23', 'F', 'FREC', '2025-10-03', 'valeria_gomez@correo.com', TRUE),
('1712345610', 'Daniela Mena', 'Cumbayá', '1969-08-15', 'F', 'NUEVO', '2026-11-19', 'daniela_mena@correo.com', TRUE),
('1712345611', 'Daniela Rodríguez', 'Quito ', '1997-01-27', 'M', 'FREC', '2025-03-06', 'daniela_rodriguez@correo.com', TRUE),
('1712345612', 'Luis Torres', 'quito', '1998-05-28', 'M', 'FREC', '2026-09-09', 'luis_torres@correo.com', TRUE),
('1712345613', 'Daniela Vega', 'Sangolquí', '1999-02-17', 'M', 'FREC', '2026-03-06', 'daniela_vega@correo.com', TRUE),
('1712345614', 'Elena Ortiz', 'Cumbayá', '2003-06-27', 'M', 'VIP', '2024-02-02', 'elena_ortiz@correo.com', TRUE),
('1712345615', 'Elena Ortiz', 'quito', '1978-10-14', 'M', 'FREC', '2026-09-10', 'elena_ortiz@correo.com', TRUE),
('1712345616', 'Elena Vega', 'Quito ', '1980-11-13', 'F', 'FREC', '2026-01-06', 'elena_vega@correo.com', TRUE),
('1712345617', 'Jorge Cevallos', 'Quito ', '1994-04-11', 'M', 'FREC', '2026-06-24', 'jorge_cevallos@correo.com', TRUE),
('1712345618', 'Fernando Mena', 'Quito ', '1973-06-17', 'M', 'FREC', '2025-02-09', 'fernando_mena@correo.com', TRUE),
('1712345619', 'Jorge Torres', 'QUITO', '1971-01-10', 'F', 'VIP', '2025-04-28', 'jorge_torres@correo.com', TRUE),
('1712345620', 'Valeria Rodríguez', NULL, '1985-10-24', 'F', 'NUEVO', '2024-08-17', 'valeria_rodriguez@correo.com', TRUE),
('1712345621', 'Jorge Ruiz', 'quito', '1996-01-03', 'F', 'FREC', '2024-04-19', 'jorge_ruiz@correo.com', TRUE),
('1712345622', 'Luis Pérez', 'Quito', '1983-08-20', 'F', 'FREC', '2024-02-14', 'luis_perez@correo.com', TRUE),
('1712345623', 'Daniela Vega', 'Cumbayá', '1988-07-12', 'M', 'FREC', '2026-09-07', 'daniela_vega@correo.com', TRUE),
('1712345624', 'Luis Castro', 'quito', '1969-07-17', 'F', 'VIP', '2025-10-22', 'luis_castro@correo.com', TRUE),
('1712345625', 'Miguel Gómez', 'QUITO', '1971-07-12', 'F', 'FREC', '2025-03-07', 'miguel_gomez@correo.com', TRUE),
('1712345626', 'Miguel Castro', 'Quito ', '1997-01-02', 'M', 'NUEVO', '2025-08-17', 'miguel_castro@correo.com', TRUE),
('1712345627', 'Jorge Rodríguez', 'Sangolquí', '1997-03-11', 'F', 'NUEVO', '2026-12-27', 'jorge_rodriguez@correo.com', TRUE),
('1712345628', 'María Ortiz', 'quito', '1997-09-18', 'F', 'VIP', '2025-08-27', 'maria_ortiz@correo.com', TRUE),
('1712345629', 'Andrea Mena', 'quito', '1972-07-19', 'F', 'VIP', '2026-12-21', 'andrea_mena@correo.com', TRUE),
('1712345630', 'Andrea Ortiz', 'Quito ', '1981-11-26', 'M', 'VIP', '2026-08-06', 'andrea_ortiz@correo.com', TRUE),

-- DUPLICADOS
('1712345605', 'MARIA PEREZ', 'QUITO', '1984-05-14', 'F', 'FREC', '2025-06-01', 'maria.perez@correo.com', TRUE),
('1712345610 ', 'Luis Gómez', 'Quito', '1979-02-03', 'M', 'VIP', '2024-11-20', NULL, TRUE),

-- Documentos con guiones
('171-234-5615', 'Sofía Torres', 'quito', '1992-09-09', 'F', 'NUEVO', '2026-01-03', 'sofia@correo.com', TRUE),

-- Cliente de prueba
('0000000000', 'Cliente de prueba', NULL, NULL, NULL, 'INACT', '2025-01-01', NULL, FALSE);

-- =====================================================
-- 5. METAS MENSUALES (2 AÑOS)
-- =====================================================
INSERT INTO meta_mensual (codigo_tienda, periodo, meta_ventas, meta_clientes, meta_satisfaccion) VALUES

-- AÑO 2025
('CENTRO', '2025-01-01', 1800.00, 90, 4.20),
('NORTE', '2025-01-01', 2600.00, 120, 4.30),
('SUR', '2025-01-01', 1500.00, 80, 4.00),
('VALLE', '2025-01-01', 2200.00, 100, 4.10),

('CENTRO', '2025-02-01', 1800.00, 90, 4.20),
('NORTE', '2025-02-01', 2600.00, 120, 4.30),
('SUR', '2025-02-01', 1500.00, 80, 4.00),
('VALLE', '2025-02-01', 2200.00, 100, 4.10),

('CENTRO', '2025-03-01', 1800.00, 90, 4.20),
('NORTE', '2025-03-01', 2600.00, 120, 4.30),
('SUR', '2025-03-01', 1500.00, 80, 4.00),
('VALLE', '2025-03-01', 2200.00, 100, 4.10),

('CENTRO', '2025-04-01', 1800.00, 90, 4.20),
('NORTE', '2025-04-01', 2600.00, 120, 4.30),
('SUR', '2025-04-01', 1500.00, 80, 4.00),
('VALLE', '2025-04-01', 2200.00, 100, 4.10),

('CENTRO', '2025-05-01', 1800.00, 90, 4.20),
('NORTE', '2025-05-01', 2600.00, 120, 4.30),
('SUR', '2025-05-01', 1500.00, 80, 4.00),
('VALLE', '2025-05-01', 2200.00, 100, 4.10),

('CENTRO', '2025-06-01', 1800.00, 90, 4.20),
('NORTE', '2025-06-01', 2600.00, 120, 4.30),
('SUR', '2025-06-01', 1500.00, 80, 4.00),
('VALLE', '2025-06-01', 2200.00, 100, 4.10),

('CENTRO', '2025-07-01', 1800.00, 90, 4.20),
('NORTE', '2025-07-01', 2600.00, 120, 4.30),
('SUR', '2025-07-01', 1500.00, 80, 4.00),
('VALLE', '2025-07-01', 2200.00, 100, 4.10),

('CENTRO', '2025-08-01', 1800.00, 90, 4.20),
('NORTE', '2025-08-01', 2600.00, 120, 4.30),
('SUR', '2025-08-01', 1500.00, 80, 4.00),
('VALLE', '2025-08-01', 2200.00, 100, 4.10),

('CENTRO', '2025-09-01', 1800.00, 90, 4.20),
('NORTE', '2025-09-01', 2600.00, 120, 4.30),
('SUR', '2025-09-01', 1500.00, 80, 4.00),
('VALLE', '2025-09-01', 2200.00, 100, 4.10),

('CENTRO', '2025-10-01', 1800.00, 90, 4.20),
('NORTE', '2025-10-01', 2600.00, 120, 4.30),
('SUR', '2025-10-01', 1500.00, 80, 4.00),
('VALLE', '2025-10-01', 2200.00, 100, 4.10),

('CENTRO', '2025-11-01', 1800.00, 90, 4.20),
('NORTE', '2025-11-01', 2600.00, 120, 4.30),
('SUR', '2025-11-01', 1500.00, 80, 4.00),
('VALLE', '2025-11-01', 2200.00, 100, 4.10),

('CENTRO', '2025-12-01', 1800.00, 90, 4.20),
('NORTE', '2025-12-01', 2600.00, 120, 4.30),
('SUR', '2025-12-01', 1500.00, 80, 4.00),
('VALLE', '2025-12-01', 2200.00, 100, 4.10),

-- AÑO 2026
('CENTRO', '2026-01-01', 2000.00, 100, 4.30),
('NORTE', '2026-01-01', 2800.00, 130, 4.40),
('SUR', '2026-01-01', 1600.00, 85, 4.10),
('VALLE', '2026-01-01', 2400.00, 110, 4.20),

('CENTRO', '2026-02-01', 2000.00, 100, 4.30),
('NORTE', '2026-02-01', 2800.00, 130, 4.40),
('SUR', '2026-02-01', 1600.00, 85, 4.10),
('VALLE', '2026-02-01', 2400.00, 110, 4.20),

('CENTRO', '2026-03-01', 2000.00, 100, 4.30),
('NORTE', '2026-03-01', 2800.00, 130, 4.40),
('SUR', '2026-03-01', 1600.00, 85, 4.10),
('VALLE', '2026-03-01', 2400.00, 110, 4.20),

('CENTRO', '2026-04-01', 2000.00, 100, 4.30),
('NORTE', '2026-04-01', 2800.00, 130, 4.40),
('SUR', '2026-04-01', 1600.00, 85, 4.10),
('VALLE', '2026-04-01', 2400.00, 110, 4.20),

('CENTRO', '2026-05-01', 2000.00, 100, 4.30),
('NORTE', '2026-05-01', 2800.00, 130, 4.40),
('SUR', '2026-05-01', 1600.00, 85, 4.10),
('VALLE', '2026-05-01', 2400.00, 110, 4.20),

('CENTRO', '2026-06-01', 2000.00, 100, 4.30),
('NORTE', '2026-06-01', 2800.00, 130, 4.40),
('SUR', '2026-06-01', 1600.00, 85, 4.10),
('VALLE', '2026-06-01', 2400.00, 110, 4.20),

('CENTRO', '2026-07-01', 2000.00, 100, 4.30),
('NORTE', '2026-07-01', 2800.00, 130, 4.40),
('SUR', '2026-07-01', 1600.00, 85, 4.10),
('VALLE', '2026-07-01', 2400.00, 110, 4.20),

('CENTRO', '2026-08-01', 2000.00, 100, 4.30),
('NORTE', '2026-08-01', 2800.00, 130, 4.40),
('SUR', '2026-08-01', 1600.00, 85, 4.10),
('VALLE', '2026-08-01', 2400.00, 110, 4.20),

('CENTRO', '2026-09-01', 2000.00, 100, 4.30),
('NORTE', '2026-09-01', 2800.00, 130, 4.40),
('SUR', '2026-09-01', 1600.00, 85, 4.10),
('VALLE', '2026-09-01', 2400.00, 110, 4.20),

('CENTRO', '2026-10-01', 2000.00, 100, 4.30),
('NORTE', '2026-10-01', 2800.00, 130, 4.40),
('SUR', '2026-10-01', 1600.00, 85, 4.10),
('VALLE', '2026-10-01', 2400.00, 110, 4.20),

('CENTRO', '2026-11-01', 2000.00, 100, 4.30),
('NORTE', '2026-11-01', 2800.00, 130, 4.40),
('SUR', '2026-11-01', 1600.00, 85, 4.10),
('VALLE', '2026-11-01', 2400.00, 110, 4.20),

('CENTRO', '2026-12-01', 2000.00, 100, 4.30),
('NORTE', '2026-12-01', 2800.00, 130, 4.40),
('SUR', '2026-12-01', 1600.00, 85, 4.10),
('VALLE', '2026-12-01', 2400.00, 110, 4.20);

-- =====================================================
-- 6. ENCUESTAS DE SATISFACCIÓN (CON INCONSISTENCIAS)
-- =====================================================
INSERT INTO encuesta_satisfaccion (fecha, codigo_tienda, documento_cliente, puntuacion, tiempo_espera_minutos, comentario) VALUES

-- ============================================
-- 2025 - ENCUESTAS NORMALES
-- ============================================
('2025-01-15', 'CENTRO', '1712345601', 4, 8, 'Excelente servicio'),
('2025-01-20', 'NORTE', '1712345602', 5, 5, 'Muy buena atención'),
('2025-02-10', 'SUR', '1712345603', 3, 15, 'No había stock'),
('2025-02-15', 'VALLE', '1712345604', 4, 10, 'Local cómodo'),
('2025-03-01', 'CENTRO', '1712345605', 5, 3, 'Proceso ágil'),
('2025-03-10', 'NORTE', '1712345606', 4, 12, 'Buena atención'),
('2025-04-01', 'SUR', '1712345607', 3, 20, 'Poca información al cliente'),
('2025-04-15', 'VALLE', '1712345608', 4, 8, 'Atención aceptable'),
('2025-05-01', 'CENTRO', '1712345609', 5, 6, 'Muy buena atención'),
('2025-05-15', 'NORTE', '1712345610', 4, 9, 'Faltó el producto'),

-- ============================================
-- 2025 - ENCUESTAS CON PROBLEMAS
-- ============================================
('2025-06-01', 'SUR', '1712345611', 7, 120, 'Muy buena atención'), -- FUERA DE RANGO
('2025-06-15', 'VALLE', '1712345612', 0, 25, 'Mala atención'), -- FUERA DE RANGO
('2025-07-01', 'CENTRO', '1712345613', 2, 90, 'Tiempo de espera muy alto'),
('2025-07-15', 'NORTE', '1712345614', 3, 85, 'Espera excesiva'),
('2025-08-01', 'SUR', NULL, 3, 15, 'Cliente sin documento'),
('2025-08-15', 'VALLE', '1712345615', 4, 7, 'Buena atención'),
('2025-09-01', 'CENTRO', '1712345616', 5, 4, 'Excelente'),
('2025-09-15', 'NORTE', '1712345617', 2, 35, 'Tiempo de espera alto'),
('2025-10-01', 'SUR', '1712345618', 4, 12, 'Buen servicio'),
('2025-10-15', 'VALLE', '1712345619', 5, 5, 'Muy buena atención'),
('2025-11-01', 'CENTRO', '1712345620', 3, 18, 'Faltó el producto'),
('2025-11-15', 'NORTE', '1712345621', 1, 45, 'Mala experiencia'),
('2025-12-01', 'SUR', '1712345622', 4, 8, 'Local agradable'),
('2025-12-15', 'VALLE', '1712345623', 5, 3, 'Excelente servicio'),

-- ============================================
-- 2026 - ENCUESTAS
-- ============================================
('2026-01-05', 'CENTRO', '1712345624', 4, 7, 'Buena atención'),
('2026-01-10', 'NORTE', '1712345625', 5, 4, 'Excelente'),
('2026-01-15', 'SUR', '1712345626', 2, 35, 'Tiempo de espera alto'),
('2026-01-20', 'VALLE', '1712345627', 4, 12, 'Buen servicio'),
('2026-02-01', 'CENTRO', '1712345628', 5, 5, 'Muy buena atención'),
('2026-02-05', 'NORTE', '1712345629', 3, 18, 'Faltó el producto'),
('2026-02-10', 'SUR', '1712345630', 1, 45, 'Mala experiencia'),
('2026-02-15', 'VALLE', '1712345601', 4, 8, 'Local agradable'),
('2026-03-01', 'CENTRO', '1712345602', 5, 3, 'Excelente servicio'),
('2026-03-05', 'NORTE', '1712345603', 4, 10, 'Buena atención'),
('2026-03-10', 'SUR', '1712345604', 6, 15, 'Me gusto la atención'), -- FUERA DE RANGO
('2026-03-15', 'VALLE', '1712345605', 2, 60, 'Tiempo de espera muy alto'),

-- ============================================
-- DUPLICADOS DE DOCUMENTOS
-- ============================================
('2026-03-20', 'NORTE', '1712345605', 4, 8, 'Buen servicio'),
('2026-03-25', 'CENTRO', '1712345605', 5, 5, 'Excelente servicio'),

-- ============================================
-- DOCUMENTOS CON GUIONES
-- ============================================
('2026-03-28', 'SUR', '171-234-5615', 3, 20, 'Servicio regular'),

-- ============================================
-- PUNTUACIÓN CERO EN 2026
-- ============================================
('2026-03-30', 'VALLE', '1712345607', 0, 30, 'Mala atención');

-- =====================================================
-- CONSULTAS DE VALIDACIÓN
-- =====================================================
-- SELECT documento, COUNT(*) FROM cliente GROUP BY documento HAVING COUNT(*) > 1;
-- SELECT ciudad, COUNT(*) FROM cliente GROUP BY ciudad ORDER BY ciudad;
-- SELECT * FROM encuesta_satisfaccion WHERE puntuacion NOT BETWEEN 1 AND 5 OR tiempo_espera_minutos > 60;
-- SELECT codigo_tienda, AVG(puntuacion), AVG(tiempo_espera_minutos) FROM encuesta_satisfaccion GROUP BY codigo_tienda;
-- SELECT periodo, AVG(meta_ventas) FROM meta_mensual GROUP BY periodo ORDER BY periodo;