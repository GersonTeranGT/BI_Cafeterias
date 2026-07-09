-- 03_historial_cafeteriamysql.sql
-- GENERACIÓN DE DATOS HISTÓRICOS CON PROCEDIMIENTO ALMACENADO

USE cafeteria_db;

-- =====================================================
-- 1. AUMENTAR TIMEOUTS PARA EVITAR DESCONEXIONES
-- =====================================================
SET SESSION wait_timeout = 600;
SET SESSION interactive_timeout = 600;

-- =====================================================
-- 2. ELIMINAR DATOS HISTÓRICOS PREVIOS
-- =====================================================
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM detalle_venta WHERE numero_venta LIKE 'VH-CAFE%';
DELETE FROM venta WHERE numero_venta LIKE 'VH-CAFE%';
SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- 3. CREAR EL PROCEDIMIENTO
-- =====================================================
DROP PROCEDURE IF EXISTS sp_cargar_historial_cafe_mysql;

DELIMITER $$

CREATE PROCEDURE sp_cargar_historial_cafe_mysql()
BEGIN
    DECLARE v_mes DATE DEFAULT '2024-07-01';
    DECLARE v_fin DATE DEFAULT '2026-07-01';
    DECLARE i INT DEFAULT 1;
    DECLARE linea SMALLINT DEFAULT 1;
    DECLARE ventas_mes INT DEFAULT 0;
    DECLARE dias_mes INT DEFAULT 0;
    DECLARE v_numero VARCHAR(25);
    DECLARE v_fecha DATE;
    DECLARE v_fecha_hora DATETIME;
    DECLARE v_tienda VARCHAR(60);
    DECLARE v_documento VARCHAR(25);
    DECLARE v_forma_pago VARCHAR(30);
    DECLARE v_descuento DECIMAL(10,2);
    DECLARE v_estado VARCHAR(20);
    DECLARE v_es_para_llevar CHAR(1);
    DECLARE v_observacion VARCHAR(200);
    DECLARE v_codigo_prod VARCHAR(15);
    DECLARE v_cantidad INT;
    DECLARE v_precio DECIMAL(10,2);

    -- Bucle WHILE (VÁLIDO dentro de un procedimiento)
    WHILE v_mes <= v_fin DO
        SET ventas_mes = CASE 
            WHEN v_mes = '2026-07-01' THEN 20 
            ELSE 35 
        END;
        SET dias_mes = DAY(LAST_DAY(v_mes));
        SET i = 1;

        WHILE i <= ventas_mes DO
            SET v_numero = CONCAT('VH-CAFE', DATE_FORMAT(v_mes, '%Y%m'), LPAD(i, 3, '0'));
            SET v_fecha = DATE_ADD(v_mes, INTERVAL MOD(i * 7 + MONTH(v_mes), dias_mes) DAY);
            SET v_fecha_hora = TIMESTAMP(v_fecha, MAKETIME(8 + MOD(i * 3, 12), MOD(i * 11, 60), 0));

            -- Nombres de tiendas inconsistentes
            SET v_tienda = CASE MOD(i + MONTH(v_mes), 14)
                WHEN 0 THEN 'CAFE CENTRO'
                WHEN 1 THEN 'CENTRO CAFE'
                WHEN 2 THEN 'Cafeteria Centro'
                WHEN 3 THEN 'EL CAFETAL CENTRO'
                WHEN 4 THEN 'NORTE CAFE'
                WHEN 5 THEN 'CAFE NORTE'
                WHEN 6 THEN 'EL CAFETAL NORTE'
                WHEN 7 THEN 'NORTE '
                WHEN 8 THEN 'SUR CAFE'
                WHEN 9 THEN 'CAFE SUR'
                WHEN 10 THEN 'EL CAFETAL SUR'
                WHEN 11 THEN 'SUR '
                WHEN 12 THEN 'VALLE'
                ELSE 'Sucursal Valle'
            END;

            -- Documentos inconsistentes
            SET v_documento = CASE MOD(i * 5 + MONTH(v_mes), 42)
                WHEN 0 THEN NULL
                WHEN 1 THEN ''
                WHEN 2 THEN ' 1712345603'
                WHEN 3 THEN '1712345601 '
                WHEN 4 THEN '171-234-5701'
                WHEN 5 THEN '171-234-5702'
                WHEN 6 THEN '171.234.5716'
                WHEN 7 THEN '9999999999'
                WHEN 8 THEN '0000000000'
                WHEN 9 THEN '1725000001'
                WHEN 10 THEN '1725000005'
                ELSE CONCAT('171234', LPAD(1 + MOD(i + MONTH(v_mes) + YEAR(v_mes), 60), 4, '0'))
            END;

            -- Formas de pago inconsistentes
            SET v_forma_pago = CASE MOD(i + MONTH(v_mes), 5)
                WHEN 0 THEN 'EFECTIVO'
                WHEN 1 THEN 'tarjeta'
                WHEN 2 THEN 'TARJETA'
                WHEN 3 THEN 'TRANSFERENCIA'
                ELSE 'efectivo'
            END;

            SET v_descuento = CASE MOD(i, 10)
                WHEN 0 THEN 2.00
                WHEN 1 THEN 0.50
                WHEN 2 THEN 1.00
                WHEN 3 THEN 1.50
                ELSE 0.00
            END;

            SET v_estado = CASE WHEN MOD(i * MONTH(v_mes), 23) = 0 THEN 'ANULADA' ELSE 'COMPLETADA' END;
            SET v_es_para_llevar = CASE WHEN MOD(i, 3) = 0 THEN 'S' ELSE 'N' END;
            
            SET v_observacion = CASE
                WHEN v_mes = '2026-07-01' THEN 'Carga historica BI - mes en curso'
                WHEN v_estado = 'ANULADA' THEN 'Carga historica BI - venta anulada'
                WHEN v_descuento > 0 THEN 'Carga historica BI - con descuento'
                ELSE 'Carga historica BI'
            END;

            INSERT INTO venta
                (numero_venta, fecha_hora, tienda_origen, documento_cliente, forma_pago, descuento, es_para_llevar, estado, observacion)
            VALUES
                (v_numero, v_fecha_hora, v_tienda, v_documento, v_forma_pago, v_descuento, v_es_para_llevar, v_estado, v_observacion);

            -- Detalle de venta (1-4 productos)
            SET linea = 1;
            WHILE linea <= 1 + MOD(i, 4) DO
                SET v_codigo_prod = CONCAT('PRD', LPAD(1 + MOD(i + linea + MONTH(v_mes) + YEAR(v_mes), 22), 3, '0'));
                
                SET v_cantidad = CASE
                    WHEN MOD(i + linea + MONTH(v_mes), 97) = 0 THEN 25
                    WHEN MOD(i + linea + MONTH(v_mes), 53) = 0 THEN 15
                    ELSE 1 + MOD(i + linea, 4)
                END;

                -- Obtener precio del producto
                SELECT precio_venta INTO v_precio
                FROM producto
                WHERE codigo_producto = v_codigo_prod
                LIMIT 1;

                IF v_precio IS NULL THEN
                    SET v_precio = 2.50 + MOD(i + linea, 10) * 0.50;
                    SET v_codigo_prod = 'PRD001';
                END IF;

                -- Precio unitario cero ocasional
                IF MOD(i + linea + MONTH(v_mes), 43) = 0 THEN
                    SET v_precio = 0.00;
                END IF;

                INSERT INTO detalle_venta
                    (numero_venta, linea, codigo_producto, cantidad, precio_unitario, descuento_aplicado)
                VALUES
                    (v_numero, linea, v_codigo_prod, v_cantidad, v_precio, 0.00);

                SET linea = linea + 1;
            END WHILE;

            SET i = i + 1;
        END WHILE;

        SET v_mes = DATE_ADD(v_mes, INTERVAL 1 MONTH);
    END WHILE;
END$$

DELIMITER ;

-- =====================================================
-- 4. EJECUTAR EL PROCEDIMIENTO
-- =====================================================
CALL sp_cargar_historial_cafe_mysql();

-- =====================================================
-- 5. ELIMINAR EL PROCEDIMIENTO (OPCIONAL)
-- =====================================================
DROP PROCEDURE IF EXISTS sp_cargar_historial_cafe_mysql;

-- =====================================================
-- 6. COMPROBACIONES
-- =====================================================
SELECT '=== VENTAS HISTORICAS GENERADAS ===' AS '';
SELECT
    DATE_FORMAT(fecha_hora, '%Y-%m') AS periodo,
    COUNT(*) AS ventas,
    SUM(CASE WHEN estado = 'COMPLETADA' THEN 1 ELSE 0 END) AS completadas,
    SUM(CASE WHEN estado = 'ANULADA' THEN 1 ELSE 0 END) AS anuladas
FROM venta
WHERE numero_venta LIKE 'VH-CAFE%'
GROUP BY DATE_FORMAT(fecha_hora, '%Y-%m')
ORDER BY periodo;

SELECT '=== TOTAL DE REGISTROS ===' AS '';
SELECT 'venta' AS tabla, COUNT(*) AS registros FROM venta
UNION ALL
SELECT 'detalle_venta', COUNT(*) FROM detalle_venta;