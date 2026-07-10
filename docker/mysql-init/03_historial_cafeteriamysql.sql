-- 03_mysql_cafeteria_historial.sql
-- PROCEDIMIENTO PARA GENERAR DATOS HISTÓRICOS (2024-2026)
-- CON ENFOQUE EN EFICIENCIA OPERATIVA

USE cafeteria_db;

-- =====================================================
-- 0. CORREGIR TAMAÑO DE COLUMNAS (SI ES NECESARIO)
-- =====================================================
ALTER TABLE atencion_cliente MODIFY COLUMN tienda_origen VARCHAR(60) NOT NULL;

-- =====================================================
-- 1. ELIMINAR DATOS HISTÓRICOS PREVIOS
-- =====================================================
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM preparacion_producto WHERE id_preparacion > 100;
DELETE FROM atencion_cliente WHERE id_atencion > 100;
DELETE FROM registro_turno WHERE id_turno > 100;
SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- 2. CREAR PROCEDIMIENTO PARA GENERAR DATOS HISTÓRICOS
-- =====================================================
DROP PROCEDURE IF EXISTS sp_cargar_historial_operativo_mysql;

DELIMITER $$

CREATE PROCEDURE sp_cargar_historial_operativo_mysql()
BEGIN
    DECLARE v_fecha DATE DEFAULT '2024-07-01';
    DECLARE v_fin DATE DEFAULT '2026-07-01';
    DECLARE i INT DEFAULT 1;
    DECLARE v_id_empleado INT;
    DECLARE v_hora_inicio TIME;
    DECLARE v_hora_fin TIME;
    DECLARE v_pausa_inicio TIME;
    DECLARE v_pausa_fin TIME;
    DECLARE v_horas_trabajadas DECIMAL(4,2);
    DECLARE v_num_clientes INT;
    DECLARE j INT DEFAULT 1;
    DECLARE v_hora_llegada TIME;
    DECLARE v_hora_atencion TIME;
    DECLARE v_hora_entrega TIME;
    DECLARE v_tiempo_espera INT;
    DECLARE v_tiempo_preparacion INT;
    DECLARE v_codigo_producto VARCHAR(15);
    DECLARE v_tienda VARCHAR(60);
    DECLARE v_cafe_premium DECIMAL(6,2);
    DECLARE v_cafe_regular DECIMAL(6,2);
    DECLARE v_leche_ml DECIMAL(6,2);
    DECLARE v_total_cafe DECIMAL(6,2);

    WHILE v_fecha <= v_fin DO
        SET i = 1;
        
        -- Generar turnos para cada empleado (3-5 días por semana)
        WHILE i <= 10 DO
            SET v_id_empleado = 100 + i;
            
            -- Solo generar turnos ciertos días (simula días libres)
            IF MOD(i + DAY(v_fecha), 7) > 1 THEN
                SET v_hora_inicio = MAKETIME(8 + MOD(i, 3) * 2, 0, 0);
                SET v_hora_fin = ADDTIME(v_hora_inicio, '06:00:00');
                SET v_pausa_inicio = ADDTIME(v_hora_inicio, '02:00:00');
                SET v_pausa_fin = ADDTIME(v_pausa_inicio, '00:15:00');
                
                -- Horas trabajadas con inconsistencia ocasional
                SET v_horas_trabajadas = CASE 
                    WHEN MOD(i * DAY(v_fecha), 13) = 0 THEN 4.50
                    WHEN MOD(i * DAY(v_fecha), 11) = 0 THEN 7.00
                    ELSE 5.75
                END;

                INSERT INTO registro_turno
                    (id_empleado, fecha, hora_inicio, hora_fin, pausa_inicio, pausa_fin, horas_trabajadas, observacion)
                VALUES
                    (v_id_empleado, v_fecha, v_hora_inicio, v_hora_fin, v_pausa_inicio, v_pausa_fin, v_horas_trabajadas, NULL);
            END IF;
            
            SET i = i + 1;
        END WHILE;

        -- Generar atenciones (15-35 clientes por día)
        SET v_num_clientes = 15 + MOD(DAY(v_fecha) + MONTH(v_fecha), 20);
        SET j = 1;
        
        WHILE j <= v_num_clientes DO
            SET v_id_empleado = 100 + MOD(j + DAY(v_fecha), 10) + 1;
            SET v_hora_llegada = MAKETIME(8 + MOD(j, 11), MOD(j * 7, 60), 0);
            SET v_tiempo_espera = 30 + MOD(j * 13 + DAY(v_fecha), 180);
            SET v_hora_atencion = ADDTIME(v_hora_llegada, SEC_TO_TIME(v_tiempo_espera));
            SET v_tiempo_preparacion = 60 + MOD(j * 11 + DAY(v_fecha), 300);
            SET v_hora_entrega = ADDTIME(v_hora_atencion, SEC_TO_TIME(v_tiempo_preparacion));
            SET v_codigo_producto = CONCAT('PRD', LPAD(1 + MOD(j + DAY(v_fecha), 8), 3, '0'));
            
            SET v_tienda = CASE MOD(j + MONTH(v_fecha), 8)
                WHEN 0 THEN 'CAFE CENTRO'
                WHEN 1 THEN 'CENTRO CAFE'
                WHEN 2 THEN 'Cafeteria Centro'
                WHEN 3 THEN 'EL CAFETAL CENTRO'
                WHEN 4 THEN 'NORTE CAFE'
                WHEN 5 THEN 'CAFE NORTE'
                WHEN 6 THEN 'SUR CAFE'
                ELSE 'VALLE'
            END;

            -- INCONSISTENCIA: Tiempos de espera atípicos
            IF MOD(j + DAY(v_fecha), 23) = 0 THEN
                SET v_tiempo_espera = 1800;
                SET v_hora_atencion = ADDTIME(v_hora_llegada, SEC_TO_TIME(v_tiempo_espera));
            END IF;

            -- INCONSISTENCIA: Cliente sin atender
            IF MOD(j + DAY(v_fecha), 17) = 0 THEN
                SET v_hora_atencion = NULL;
                SET v_hora_entrega = NULL;
                SET v_tiempo_espera = NULL;
                SET v_tiempo_preparacion = NULL;
            END IF;

            INSERT INTO atencion_cliente
                (id_empleado, fecha, hora_llegada, hora_atencion, hora_entrega, tiempo_espera_seg, tiempo_preparacion_seg, tipo_pedido, codigo_producto, tienda_origen)
            VALUES
                (v_id_empleado, v_fecha, v_hora_llegada, v_hora_atencion, v_hora_entrega, v_tiempo_espera, v_tiempo_preparacion, 
                 CASE WHEN MOD(j, 3) = 0 THEN 'Para llevar' ELSE 'En local' END,
                 v_codigo_producto, v_tienda);

            -- Generar preparación (70% de los productos)
            IF MOD(j + DAY(v_fecha), 10) > 2 THEN
                SET v_cafe_premium = 8 + MOD(j + DAY(v_fecha), 15);
                SET v_cafe_regular = 6 + MOD(j * 3 + DAY(v_fecha), 12);
                
                -- INCONSISTENCIA: Pedro (105) usa más regular
                IF v_id_empleado = 105 THEN
                    SET v_cafe_premium = 5 + MOD(j + DAY(v_fecha), 8);
                    SET v_cafe_regular = 8 + MOD(j * 3 + DAY(v_fecha), 10);
                END IF;

                -- INCONSISTENCIA: Diego (108) usa poco café
                IF v_id_empleado = 108 THEN
                    SET v_cafe_premium = 2 + MOD(j + DAY(v_fecha), 5);
                    SET v_cafe_regular = 2 + MOD(j * 3 + DAY(v_fecha), 5);
                END IF;

                SET v_leche_ml = 100 + MOD(j * 7 + DAY(v_fecha), 150);
                SET v_total_cafe = v_cafe_premium + v_cafe_regular;

                INSERT INTO preparacion_producto
                    (id_empleado, codigo_producto, fecha, cantidad, tiempo_preparacion_seg, cafe_premium_gramos, cafe_regular_gramos, leche_ml)
                VALUES
                    (v_id_empleado, v_codigo_producto, 
                     CONCAT(v_fecha, ' ', v_hora_entrega),
                     1 + MOD(j, 3),
                     v_tiempo_preparacion,
                     v_cafe_premium,
                     v_cafe_regular,
                     v_leche_ml);
            END IF;

            SET j = j + 1;
        END WHILE;

        SET v_fecha = DATE_ADD(v_fecha, INTERVAL 1 DAY);
    END WHILE;
END$$

DELIMITER ;

-- =====================================================
-- 3. EJECUTAR EL PROCEDIMIENTO
-- =====================================================
CALL sp_cargar_historial_operativo_mysql();

-- =====================================================
-- 4. ELIMINAR EL PROCEDIMIENTO
-- =====================================================
DROP PROCEDURE IF EXISTS sp_cargar_historial_operativo_mysql;

-- =====================================================
-- 5. COMPROBACIONES
-- =====================================================
SELECT '=== DATOS GENERADOS ===' AS '';
SELECT 'registro_turno' AS tabla, COUNT(*) AS registros FROM registro_turno
UNION ALL
SELECT 'atencion_cliente', COUNT(*) FROM atencion_cliente
UNION ALL
SELECT 'preparacion_producto', COUNT(*) FROM preparacion_producto;