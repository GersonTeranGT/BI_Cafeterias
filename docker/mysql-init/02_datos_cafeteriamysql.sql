-- 02_mysql_cafeteria_datos_base.sql
-- DATOS BASE CON INCONSISTENCIAS

USE cafeteria_db;

-- =====================================================
-- 1. PROVEEDORES
-- =====================================================
INSERT INTO proveedor (ruc, nombre, pais, telefono, email, activo) VALUES
('1790011111001', 'Cafe Grano Noble', 'Colombia', '022500001', 'ventas@cafe_noble.com', 1),
('1790011111002', 'Lecheros Unidos', 'Ecuador', '022500002', 'info@lecheros_unidos.com', 1),
('1790011111003', 'Dulce Reposteria', 'Ecuador', '022500003', 'ventas@dulce_reposteria.com', 1),
('1790011111004', 'Sabor y Aroma', 'Estados Unidos', '022500004', 'contacto@sabor_aroma.com', 1),
('1790011111005', 'Distribuidora El Cafe', 'Brasil', '022500005', 'ventas@dist_elcafe.com', 1),
('1790011111006', 'Panaderia El Trigal', 'Ecuador', '022500006', 'info@trigal_panaderia.com', 1);

-- =====================================================
-- 2. CATEGORIAS (CON DUPLICADOS)
-- =====================================================
INSERT INTO categoria_producto (codigo_categoria, nombre, descripcion) VALUES
('C01', 'Cafes Calientes', 'Bebidas calientes a base de cafe'),
('C02', 'Bebidas Heladas', 'Bebidas frias y frappes'),
('C03', 'Bebidas Caliente', 'Variante sin tilde introducida por otro sistema'),
('C04', 'Panaderia', 'Productos de panaderia y reposteria'),
('C05', 'Snacks', 'Bocadillos salados y dulces'),
('C06', 'Complementos', 'Salsas, cremas y extras');

-- =====================================================
-- 3. PRODUCTOS
-- =====================================================
INSERT INTO producto (codigo_producto, nombre, codigo_categoria, ruc_proveedor, presentacion, tamanio, costo, precio_venta, tiempo_preparacion_estandar_seg, activo) VALUES
('PRD001', 'Cafe Latte', 'C01', '1790011111001', 'Vaso 16 oz', 'Grande', 1.20, 4.50, 45, 1),
('PRD002', 'Capuchino', 'C01', '1790011111001', 'Vaso 12 oz', 'Mediano', 1.00, 3.80, 40, 1),
('PRD003', 'Espresso', 'C01', '1790011111001', 'Taza 2 oz', 'Pequeno', 0.60, 2.50, 25, 1),
('PRD004', 'Mocca', 'C01', '1790011111004', 'Vaso 16 oz', 'Grande', 1.40, 5.00, 50, 1),
('PRD005', 'Late', 'C03', '1790011111001', 'Vaso 12 oz', 'Mediano', 1.10, 4.20, 42, 1),
('PRD006', 'Te Chai', 'C01', '1790011111005', 'Vaso 12 oz', 'Mediano', 0.90, 3.50, 30, 1),
('PRD007', 'Chocolate Caliente', 'C01', '1790011111004', 'Vaso 12 oz', 'Mediano', 1.30, 4.00, 35, 1),
('PRD008', 'Americano', 'C01', '1790011111001', 'Taza 8 oz', 'Pequeno', 0.50, 2.00, 20, 1),
('PRD009', 'Frapper Vainilla', 'C02', '1790011111004', 'Vaso 16 oz', 'Grande', 1.80, 5.50, 60, 1),
('PRD010', 'Limonada Natural', 'C02', '1790011111002', 'Vaso 16 oz', 'Grande', 0.80, 3.00, 15, 1);

-- =====================================================
-- 4. RECETA ESTANDAR (Proporciones de mezcla)
-- =====================================================
INSERT INTO receta_estandar (codigo_producto, cafe_premium_gramos, cafe_regular_gramos, leche_ml, otros_ingredientes) VALUES
('PRD001', 18.00, 12.00, 200.00, 'Espuma de leche'),
('PRD002', 16.00, 10.00, 150.00, 'Espuma de leche'),
('PRD003', 10.00, 6.00, 0.00, 'Agua caliente'),
('PRD004', 18.00, 12.00, 200.00, 'Chocolate en polvo'),
('PRD005', 16.00, 10.00, 180.00, 'Espuma de leche'),
('PRD006', 0.00, 0.00, 0.00, 'Bolsa de te'),
('PRD007', 0.00, 0.00, 200.00, 'Chocolate en polvo'),
('PRD008', 10.00, 6.00, 0.00, 'Agua caliente');

-- =====================================================
-- 5. EMPLEADOS (CON INCONSISTENCIAS)
-- =====================================================
INSERT INTO empleado (id_empleado, nombre, documento, fecha_contratacion, salario_mensual, certificacion, tienda_origen, activo) VALUES
(101, 'Carlos Garcia', '1712345601', '2024-01-15', 800.00, 'Avanzado', 'CAFE CENTRO', 1),
(102, 'Maria Lopez', '1712345602', '2024-02-01', 750.00, 'Intermedio', 'CENTRO CAFE', 1),
(103, 'Ana Torres', '1712345603', '2024-03-10', 700.00, 'Intermedio', 'NORTE CAFE', 1),
(104, 'Luis Martinez', '1712345604', '2024-04-20', 700.00, 'Basico', 'CAFE NORTE', 1),
(105, 'Pedro Jimenez', '171-234-5605', '2024-05-15', 700.00, 'Basico', 'SUR CAFE', 1),
(106, 'Juan Perez', '1712345606', '2024-06-01', 750.00, 'Intermedio', 'CAFE SUR', 1),
(107, 'Sofia Reyes', '1712345607', '2024-07-10', 800.00, 'Avanzado', 'VALLE', 1),
(108, 'Diego Flores', '1712345608', '2024-08-20', 650.00, 'Basico', 'Sucursal Valle', 1),
(109, 'Laura Castro', '171-234-5609', '2024-09-15', 700.00, 'Intermedio', 'CAFE CENTRO', 1),
(110, 'Pablo Ortiz', '1712345610 ', '2024-10-01', 800.00, 'Avanzado', 'CENTRO CAFE', 1);

-- =====================================================
-- 6. REGISTRO DE TURNOS (2024-2026)
-- =====================================================
INSERT INTO registro_turno (id_empleado, fecha, hora_inicio, hora_fin, pausa_inicio, pausa_fin, horas_trabajadas, observacion) VALUES

-- 2024
(101, '2024-07-01', '08:00:00', '14:00:00', '10:00:00', '10:15:00', 5.75, NULL),
(101, '2024-07-02', '08:00:00', '14:00:00', '10:00:00', '10:15:00', 5.75, NULL),
(101, '2024-07-03', '08:00:00', '14:00:00', '10:00:00', '10:15:00', 5.75, NULL),
(102, '2024-07-01', '14:00:00', '20:00:00', '16:00:00', '16:15:00', 5.75, NULL),
(102, '2024-07-02', '14:00:00', '20:00:00', '16:00:00', '16:15:00', 5.75, NULL),
(103, '2024-07-01', '08:00:00', '14:00:00', '10:00:00', '10:30:00', 5.50, 'Pausa larga'),
(103, '2024-07-02', '08:00:00', '14:00:00', '10:00:00', '10:15:00', 5.75, NULL),
(104, '2024-07-01', '14:00:00', '20:00:00', '16:00:00', '16:15:00', 5.75, NULL),
(105, '2024-07-01', '08:00:00', '14:00:00', '10:00:00', '10:15:00', 5.75, NULL),
(105, '2024-07-02', '08:00:00', '14:00:00', NULL, NULL, 6.00, 'No registro pausa'),
(106, '2024-07-01', '14:00:00', '20:00:00', '16:00:00', '16:15:00', 5.75, NULL),
(107, '2024-07-01', '08:00:00', '14:00:00', '10:00:00', '10:15:00', 5.75, NULL),
(108, '2024-07-01', '14:00:00', '20:00:00', '16:00:00', '16:15:00', 5.75, NULL),
(109, '2024-07-01', '08:00:00', '14:00:00', '10:00:00', '10:15:00', 5.75, NULL),
(110, '2024-07-01', '14:00:00', '20:00:00', '16:00:00', '16:15:00', 5.75, NULL);

-- =====================================================
-- 7. ATENCION AL CLIENTE (CON INCONSISTENCIAS)
-- =====================================================
INSERT INTO atencion_cliente (id_empleado, fecha, hora_llegada, hora_atencion, hora_entrega, tiempo_espera_seg, tiempo_preparacion_seg, tipo_pedido, codigo_producto, tienda_origen, observacion) VALUES

-- Ejemplos con diferentes tiempos e inconsistencias
(101, '2024-07-01', '08:10:00', '08:12:00', '08:15:00', 120, 180, 'En local', 'PRD001', 'CAFE CENTRO', NULL),
(101, '2024-07-01', '08:20:00', '08:22:00', '08:26:00', 120, 240, 'Para llevar', 'PRD002', 'CAFE CENTRO', NULL),
(101, '2024-07-01', '08:35:00', '08:40:00', '08:48:00', 300, 480, 'En local', 'PRD003', 'CENTRO CAFE', 'Tiempo de espera alto'),
(102, '2024-07-01', '14:10:00', '14:12:00', '14:16:00', 120, 240, 'En local', 'PRD001', 'CENTRO CAFE', NULL),
(102, '2024-07-01', '14:25:00', '14:28:00', '14:32:00', 180, 240, 'Para llevar', 'PRD004', 'CAFE CENTRO', NULL),
(103, '2024-07-01', '08:15:00', '08:18:00', '08:22:00', 180, 240, 'En local', 'PRD001', 'NORTE CAFE', NULL),
(103, '2024-07-01', '08:30:00', '08:33:00', '08:38:00', 180, 300, 'Para llevar', 'PRD002', 'CAFE NORTE', NULL),
(104, '2024-07-01', '14:05:00', '14:08:00', '14:15:00', 180, 420, 'En local', 'PRD003', 'NORTE CAFE', 'Preparacion lenta'),
(105, '2024-07-01', '08:10:00', '08:15:00', '08:25:00', 300, 600, 'En local', 'PRD001', 'SUR CAFE', 'Tiempo de espera muy alto'),
(105, '2024-07-01', '08:30:00', NULL, NULL, NULL, NULL, 'En local', 'PRD002', 'CAFE SUR', 'Cliente se retiro'),
(106, '2024-07-01', '14:10:00', '14:12:00', '14:15:00', 120, 180, 'Para llevar', 'PRD005', 'CAFE SUR', NULL),
(107, '2024-07-01', '08:05:00', '08:07:00', '08:10:00', 120, 180, 'En local', 'PRD001', 'VALLE', NULL),
(108, '2024-07-01', '14:10:00', '14:15:00', '14:25:00', 300, 600, 'En local', 'PRD004', 'Sucursal Valle', 'Baja productividad'),
(109, '2024-07-01', '08:10:00', '08:12:00', '08:15:00', 120, 180, 'En local', 'PRD001', 'CAFE CENTRO', NULL),
(110, '2024-07-01', '14:10:00', '14:12:00', '14:15:00', 120, 180, 'Para llevar', 'PRD002', 'CENTRO CAFE', NULL);

-- =====================================================
-- 8. PREPARACION DE PRODUCTOS (Control de mezcla)
-- =====================================================
INSERT INTO preparacion_producto (id_empleado, codigo_producto, fecha, cantidad, tiempo_preparacion_seg, cafe_premium_gramos, cafe_regular_gramos, leche_ml, observacion) VALUES

-- Baristas con mezcla estándar (60% Premium / 40% Regular)
(101, 'PRD001', '2024-07-01 08:15:00', 2, 180, 20.00, 12.00, 200.00, NULL),
(101, 'PRD001', '2024-07-01 08:26:00', 1, 240, 18.00, 12.00, 200.00, NULL),
(101, 'PRD002', '2024-07-01 08:48:00', 1, 480, 16.00, 10.00, 150.00, 'Tiempo de preparacion alto'),
(102, 'PRD001', '2024-07-01 14:16:00', 1, 240, 18.00, 12.00, 200.00, NULL),
(102, 'PRD004', '2024-07-01 14:32:00', 1, 240, 18.00, 12.00, 200.00, 'Receta con chocolate'),
(103, 'PRD001', '2024-07-01 08:22:00', 1, 240, 18.00, 12.00, 200.00, NULL),
(103, 'PRD002', '2024-07-01 08:38:00', 1, 300, 16.00, 10.00, 150.00, NULL),

-- Pedro (105) - PROBLEMA: Usa MÁS café regular del permitido (50% Premium / 50% Regular)
(105, 'PRD001', '2024-07-01 08:25:00', 1, 600, 15.00, 15.00, 200.00, 'Mezcla con mayor regular'),
(105, 'PRD001', '2024-07-01 09:00:00', 2, 540, 14.00, 16.00, 200.00, 'Exceso de cafe regular'),
(105, 'PRD002', '2024-07-01 09:30:00', 1, 480, 13.00, 13.00, 150.00, 'Mezcla incorrecta'),

-- Luis (104) - PROBLEMA: Usa MÁS café premium (70% Premium / 30% Regular)
(104, 'PRD003', '2024-07-01 14:15:00', 1, 420, 14.00, 6.00, 0.00, 'Exceso de cafe premium'),
(104, 'PRD001', '2024-07-01 14:30:00', 2, 480, 21.00, 9.00, 200.00, 'Mezcla con mas premium'),

-- Ana (103) - Buena mezcla
(103, 'PRD001', '2024-07-02 08:15:00', 2, 220, 18.50, 11.50, 200.00, NULL),

-- Diego (108) - Problema: Poco café premium, poco regular (bajo rendimiento)
(108, 'PRD004', '2024-07-01 14:25:00', 1, 600, 10.00, 8.00, 200.00, 'Poco cafe en general');

-- =====================================================
-- 9. INVENTARIO DE INSUMOS
-- =====================================================
INSERT INTO inventario_insumo (tienda_origen, nombre_insumo, stock_actual, stock_minimo, unidad_medida, fecha_caducidad, fecha_ultima_compra) VALUES
('CAFE CENTRO', 'Cafe Premium', 15.50, 10.00, 'kg', '2026-12-31', '2026-06-15'),
('CAFE CENTRO', 'Cafe Regular', 8.00, 10.00, 'kg', '2026-12-31', '2026-06-15'),
('CAFE CENTRO', 'Leche Entera', 20.00, 15.00, 'litros', '2026-07-20', '2026-07-01'),
('CAFE CENTRO', 'Chocolate en Polvo', 5.00, 3.00, 'kg', '2026-08-15', '2026-06-20'),
('NORTE CAFE', 'Cafe Premium', 12.00, 10.00, 'kg', '2026-12-31', '2026-06-20'),
('NORTE CAFE', 'Cafe Regular', 9.00, 10.00, 'kg', '2026-12-31', '2026-06-20'),
('NORTE CAFE', 'Leche Entera', 18.00, 15.00, 'litros', '2026-07-25', '2026-07-02'),
('SUR CAFE', 'Cafe Premium', 5.00, 10.00, 'kg', '2026-12-31', '2026-06-10'),
('SUR CAFE', 'Cafe Regular', 2.00, 10.00, 'kg', '2026-12-31', '2026-06-10'),
('SUR CAFE', 'Leche Entera', 8.00, 15.00, 'litros', '2026-07-18', '2026-07-01'),
('SUR CAFE', 'Chocolate en Polvo', 1.00, 3.00, 'kg', '2026-08-10', '2026-06-15'),
('VALLE', 'Cafe Premium', 10.00, 10.00, 'kg', '2026-12-31', '2026-06-25'),
('VALLE', 'Cafe Regular', 12.00, 10.00, 'kg', '2026-12-31', '2026-06-25'),
('VALLE', 'Leche Entera', 25.00, 15.00, 'litros', '2026-07-30', '2026-07-05');