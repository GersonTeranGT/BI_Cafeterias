-- 03_clientes_cafeteriamysql.sql

USE cafeteria_db;

DROP TABLE IF EXISTS cliente;

CREATE TABLE cliente (
    codigo_cliente INT NOT NULL,
    cedula_ruc VARCHAR(20),
    apellido1 VARCHAR(40),
    apellido2 VARCHAR(40),
    nombres VARCHAR(70) NOT NULL,
    direccion VARCHAR(180),
    telefono_principal VARCHAR(20),
    telefono_alterno VARCHAR(20),
    email_contacto VARCHAR(120),
    fecha_alta DATETIME,
    tipo_cliente CHAR(1) NOT NULL DEFAULT 'N',
    permite_credito CHAR(1) NOT NULL DEFAULT 'N',
    estado_registro CHAR(1) NOT NULL DEFAULT 'A',
    observaciones VARCHAR(250),
    PRIMARY KEY (codigo_cliente)
);

CREATE INDEX idx_cliente_cedula_ruc ON cliente(cedula_ruc);
CREATE INDEX idx_cliente_apellidos ON cliente(apellido1, apellido2);

-- =====================================================
-- 1. CLIENTES ESTÁNDAR (1001-1100) - SIN CAMBIOS
-- =====================================================
INSERT INTO cliente
(codigo_cliente, cedula_ruc, apellido1, apellido2, nombres, direccion,
 telefono_principal, telefono_alterno, email_contacto, fecha_alta,
 tipo_cliente, permite_credito, estado_registro, observaciones)
VALUES
(1001, '1712345601', 'Rodriguez', NULL, 'Paola', 'Quito - La Magdalena', '0991000001', NULL, 'paola.rodriguez@gmail.com', '2024-04-25 09:10:00', 'F', 'N', 'A', NULL),
(1002, '1712345602', 'Mena', NULL, 'Elena', 'Quito, sector Centro', '0991000002', NULL, 'elena.mena@gmail.com', '2025-06-15 15:22:00', 'N', 'N', 'A', NULL),
(1003, '1712345603', 'Gomez', NULL, 'Camila', 'Sangolqui / San Rafael', '0991000003', NULL, 'camila.gomez@gmail.com', '2025-04-04 11:08:00', 'F', 'N', 'A', NULL),
(1004, '1712345604', 'Rodriguez', NULL, 'Andrea', 'Quito', '0991000004', NULL, 'andrea.rodriguez@gmail.com', '2025-12-15 13:42:00', 'N', 'N', 'A', NULL),
(1005, '1712345605', 'Ortiz', NULL, 'Jose', 'Quito Norte', '0991000005', NULL, 'jose.ortiz@gmail.com', '2025-03-23 10:15:00', 'F', 'S', 'A', 'Cliente frecuente zona norte'),
(1006, '1712345606', 'Gomez', NULL, 'Jorge', 'Quito - Cotocollao', NULL, NULL, 'jorge.gomez@gmail.com', '2025-05-28 17:31:00', 'N', 'N', 'A', NULL),
(1007, '1712345607', 'Rodriguez', NULL, 'Daniela', 'Quito', '0991000007', NULL, NULL, '2024-04-26 08:55:00', 'N', 'N', 'I', 'Registro inactivo'),
(1008, '1712345608', 'Perez', NULL, 'Jorge', 'Quito Centro', '0991000008', NULL, 'jperez@cafeteria.local', '2026-03-20 12:18:00', 'E', 'S', 'A', 'Cuenta empresarial'),
(1009, '1712345609', 'Gomez', NULL, 'Valeria', 'Quito', '0991000009', NULL, 'valeria.gomez@gmail.com', '2025-10-03 14:29:00', 'N', 'N', 'A', NULL),
(1010, '1712345610', 'Mena', NULL, 'Daniela', 'Cumbaya', '0991000010', NULL, 'daniela.mena@gmail.com', '2026-01-19 09:45:00', 'N', 'N', 'A', NULL),
(1011, '1712345611', 'Rodriguez', NULL, 'Daniela', 'Quito', '0991000011', NULL, 'daniela.r@gmail.com', '2025-03-06 16:02:00', 'F', 'N', 'A', NULL),
(1012, '1712345612', 'Torres', NULL, 'Luis', 'Quito Sur', '0991000012', NULL, 'luis.torres@gmail.com', '2026-01-09 10:27:00', 'N', 'N', 'A', NULL),
(1013, '1712345613', 'Vega', NULL, 'Daniela', 'Sangolqui', '0991000013', NULL, 'daniela.vega@gmail.com', '2026-03-06 11:11:00', 'N', 'N', 'A', NULL),
(1014, '1712345614', 'Ortiz', NULL, 'Elena', 'Cumbaya', '0991000014', NULL, 'elena.ortiz@gmail.com', '2024-02-02 08:35:00', 'F', 'N', 'A', NULL),
(1015, '1712345615', 'Ortiz', NULL, 'Elena', 'Quito', '0991000015', NULL, 'elena.ortiz2@gmail.com', '2026-01-10 18:06:00', 'N', 'N', 'A', 'No confundir con 1014'),
(1016, '1712345616', 'Vega', NULL, 'Elena', 'Quito', '0991000016', NULL, 'elena.vega@gmail.com', '2026-01-06 09:38:00', 'N', 'N', 'A', NULL),
(1017, '1712345617', 'Cevallos', NULL, 'Jorge', 'Quito', '0991000017', NULL, 'jorge.cevallos@gmail.com', '2026-06-24 15:54:00', 'N', 'N', 'A', NULL),
(1018, '1712345618', 'Mena', NULL, 'Fernando', 'Quito', '0991000018', NULL, 'fernando.mena@gmail.com', '2025-02-09 13:21:00', 'F', 'S', 'A', NULL),
(1019, '1712345619', 'Torres', NULL, 'Jorge', 'Quito', '0991000019', NULL, 'jorge.torres@gmail.com', '2025-04-28 10:05:00', 'N', 'N', 'A', NULL),
(1020, '1712345620', 'Rodriguez', NULL, 'Valeria', 'Quito', '0991000020', NULL, 'valeria.rodriguez@gmail.com', '2024-08-17 14:17:00', 'F', 'N', 'A', NULL),
(1021, '1712345621', 'Ruiz', NULL, 'Jorge', 'Quito', '0991000021', NULL, 'jorge.ruiz@gmail.com', '2024-04-19 11:48:00', 'N', 'N', 'A', NULL),
(1022, '1712345622', 'Perez', NULL, 'Luis', 'Quito', '0991000022', NULL, 'luis.perez@gmail.com', '2024-02-14 09:03:00', 'F', 'N', 'A', NULL),
(1023, '1712345623', 'Vega', NULL, 'Daniela', 'Cumbaya', '0991000023', NULL, 'daniela.vega2@gmail.com', '2026-01-07 12:33:00', 'N', 'N', 'A', NULL),
(1024, '1712345624', 'Castro', NULL, 'Luis', 'Quito', '0991000024', NULL, 'luis.castro@gmail.com', '2025-10-22 17:19:00', 'N', 'N', 'A', NULL),
(1025, '1712345625', 'Gomez', NULL, 'Miguel', 'Quito', '0991000025', NULL, 'miguel.gomez@gmail.com', '2025-03-07 10:52:00', 'F', 'N', 'A', NULL),
(1026, '1712345626', 'Castro', NULL, 'Miguel', 'Quito', '0991000026', NULL, 'miguel.castro@gmail.com', '2025-08-17 15:09:00', 'N', 'N', 'A', NULL),
(1027, '1712345627', 'Rodriguez', NULL, 'Jorge', 'Sangolqui', '0991000027', NULL, 'jorge.rodriguez@gmail.com', '2026-01-27 13:14:00', 'N', 'N', 'A', NULL),
(1028, '1712345628', 'Ortiz', NULL, 'Maria', 'Quito', '0991000028', NULL, 'maria.ortiz@gmail.com', '2025-08-27 09:49:00', 'F', 'N', 'A', NULL),
(1029, '1712345629', 'Mena', NULL, 'Andrea', 'Quito', '0991000029', NULL, 'andrea.mena@gmail.com', '2026-01-21 16:44:00', 'N', 'N', 'A', NULL),
(1030, '1712345630', 'Ortiz', NULL, 'Andrea', 'Quito', '0991000030', NULL, 'andrea.ortiz@gmail.com', '2026-01-06 08:26:00', 'N', 'N', 'A', NULL),
(1031, '1712345631', 'Almeida', NULL, 'Roberto', 'Machachi', '0991000031', NULL, 'roberto.almeida@gmail.com', '2025-05-10 10:00:00', 'N', 'N', 'A', NULL),
(1032, '1712345632', 'Salazar', NULL, 'Teresa', 'Quito', '0991000032', NULL, 'teresa.salazar@gmail.com', '2025-11-03 15:30:00', 'N', 'N', 'A', NULL),
(1033, '1712345633', 'Maldonado', NULL, 'Carlos', 'Cumbaya', '0991000033', NULL, 'carlos.maldonado@gmail.com', '2024-09-12 08:45:00', 'F', 'N', 'A', NULL),
(1034, '1712345634', 'Narvaez', NULL, 'Sofia', 'Quito', '0991000034', NULL, 'sofia.narvaez@gmail.com', '2025-07-18 14:20:00', 'N', 'N', 'A', NULL),
(1035, '1712345635', 'Aguirre', NULL, 'Diego', 'Sangolqui', '0991000035', NULL, 'diego.aguirre@gmail.com', '2026-02-14 11:30:00', 'N', 'N', 'A', NULL),
(1036, '1712345636', 'Benitez', NULL, 'Gabriela', 'Quito', '0991000036', NULL, 'gabriela.benitez@gmail.com', '2025-01-25 16:45:00', 'F', 'S', 'A', NULL),
(1037, '1712345637', 'Calderon', NULL, 'Andres', 'Quito', '0991000037', NULL, 'andres.calderon@gmail.com', '2024-12-01 09:15:00', 'N', 'N', 'A', NULL),
(1038, '1712345638', 'Dominguez', NULL, 'Carmen', 'Cumbaya', '0991000038', NULL, 'carmen.dominguez@gmail.com', '2026-03-10 13:40:00', 'N', 'N', 'A', NULL),
(1039, '1712345639', 'Espinoza', NULL, 'Felipe', 'Quito', '0991000039', NULL, 'felipe.espinoza@gmail.com', '2025-08-05 10:20:00', 'F', 'N', 'A', NULL),
(1040, '1712345640', 'Fernandez', NULL, 'Laura', 'Sangolqui', '0991000040', NULL, 'laura.fernandez@gmail.com', '2024-11-19 15:50:00', 'N', 'N', 'A', NULL),
(1041, '1712345641', 'Garcia', NULL, 'Miguel', 'Quito', '0991000041', NULL, 'miguel.garcia@gmail.com', '2025-04-28 11:25:00', 'F', 'N', 'A', NULL),
(1042, '1712345642', 'Hernandez', NULL, 'Ana', 'Cumbaya', '0991000042', NULL, 'ana.hernandez@gmail.com', '2026-01-15 16:10:00', 'N', 'N', 'A', NULL),
(1043, '1712345643', 'Iglesias', NULL, 'Pablo', 'Quito', '0991000043', NULL, 'pablo.iglesias@gmail.com', '2025-06-20 09:35:00', 'N', 'N', 'A', NULL),
(1044, '1712345644', 'Jimenez', NULL, 'Rosa', 'Sangolqui', '0991000044', NULL, 'rosa.jimenez@gmail.com', '2024-10-03 14:55:00', 'F', 'S', 'A', NULL),
(1045, '1712345645', 'Lopez', NULL, 'Javier', 'Quito', '0991000045', NULL, 'javier.lopez@gmail.com', '2025-09-12 08:40:00', 'N', 'N', 'A', NULL),
(1046, '1712345646', 'Martinez', NULL, 'Patricia', 'Cumbaya', '0991000046', NULL, 'patricia.martinez@gmail.com', '2026-02-08 12:50:00', 'N', 'N', 'A', NULL),
(1047, '1712345647', 'Moreno', NULL, 'Cristian', 'Quito', '0991000047', NULL, 'cristian.moreno@gmail.com', '2025-11-22 17:30:00', 'F', 'N', 'A', NULL),
(1048, '1712345648', 'Muñoz', NULL, 'Isabel', 'Sangolqui', '0991000048', NULL, 'isabel.munoz@gmail.com', '2024-07-14 10:15:00', 'N', 'N', 'A', NULL),
(1049, '1712345649', 'Navarro', NULL, 'Eduardo', 'Quito', '0991000049', NULL, 'eduardo.navarro@gmail.com', '2025-03-29 15:20:00', 'N', 'N', 'A', NULL),
(1050, '1712345650', 'Nuñez', NULL, 'Claudia', 'Cumbaya', '0991000050', NULL, 'claudia.nunez@gmail.com', '2026-04-02 11:45:00', 'F', 'N', 'A', NULL),
(1051, '1712345651', 'Ortega', NULL, 'Manuel', 'Quito', '0991000051', NULL, 'manuel.ortega@gmail.com', '2025-01-18 09:10:00', 'N', 'N', 'A', NULL),
(1052, '1712345652', 'Paredes', NULL, 'Marta', 'Sangolqui', '0991000052', NULL, 'marta.paredes@gmail.com', '2024-08-25 16:35:00', 'F', 'N', 'A', NULL),
(1053, '1712345653', 'Ramirez', NULL, 'Hector', 'Quito', '0991000053', NULL, 'hector.ramirez@gmail.com', '2025-12-10 14:00:00', 'N', 'N', 'A', NULL),
(1054, '1712345654', 'Reyes', NULL, 'Alicia', 'Cumbaya', '0991000054', NULL, 'alicia.reyes@gmail.com', '2026-05-05 08:50:00', 'N', 'N', 'A', NULL),
(1055, '1712345655', 'Rivas', NULL, 'Pedro', 'Quito', '0991000055', NULL, 'pedro.rivas@gmail.com', '2025-07-30 13:25:00', 'F', 'S', 'A', NULL),
(1056, '1712345656', 'Romero', NULL, 'Lorena', 'Sangolqui', '0991000056', NULL, 'lorena.romero@gmail.com', '2024-09-15 10:55:00', 'N', 'N', 'A', NULL),
(1057, '1712345657', 'Sanchez', NULL, 'Raul', 'Quito', '0991000057', NULL, 'raul.sanchez@gmail.com', '2025-10-20 15:40:00', 'N', 'N', 'A', NULL),
(1058, '1712345658', 'Silva', NULL, 'Monica', 'Cumbaya', '0991000058', NULL, 'monica.silva@gmail.com', '2026-02-28 12:05:00', 'F', 'N', 'A', NULL),
(1059, '1712345659', 'Suarez', NULL, 'Oscar', 'Quito', '0991000059', NULL, 'oscar.suarez@gmail.com', '2025-04-15 17:50:00', 'N', 'N', 'A', NULL),
(1060, '1712345660', 'Torres', NULL, 'Natalia', 'Sangolqui', '0991000060', NULL, 'natalia.torres@gmail.com', '2024-06-03 09:30:00', 'N', 'N', 'A', NULL),
(1061, '1712345661', 'Valencia', NULL, 'David', 'Quito', '0991000061', NULL, 'david.valencia@gmail.com', '2025-08-14 16:20:00', 'F', 'N', 'A', NULL),
(1062, '1712345662', 'Vargas', NULL, 'Diana', 'Cumbaya', '0991000062', NULL, 'diana.vargas@gmail.com', '2026-01-10 11:15:00', 'N', 'N', 'A', NULL),
(1063, '1712345663', 'Vega', NULL, 'Ricardo', 'Quito', '0991000063', NULL, 'ricardo.vega@gmail.com', '2025-06-28 14:45:00', 'N', 'N', 'A', NULL),
(1064, '1712345664', 'Vera', NULL, 'Gloria', 'Sangolqui', '0991000064', NULL, 'gloria.vera@gmail.com', '2024-11-01 08:25:00', 'F', 'S', 'A', NULL),
(1065, '1712345665', 'Zambrano', NULL, 'Rafael', 'Quito', '0991000065', NULL, 'rafael.zambrano@gmail.com', '2025-09-25 17:15:00', 'N', 'N', 'A', NULL),
(1066, '1712345666', 'Alvarado', NULL, 'Sandra', 'Cumbaya', '0991000066', NULL, 'sandra.alvarado@gmail.com', '2026-03-18 10:40:00', 'N', 'N', 'A', NULL),
(1067, '1712345667', 'Andrade', NULL, 'Mario', 'Quito', '0991000067', NULL, 'mario.andrade@gmail.com', '2025-05-12 15:55:00', 'F', 'N', 'A', NULL),
(1068, '1712345668', 'Avila', NULL, 'Marcia', 'Sangolqui', '0991000068', NULL, 'marcia.avila@gmail.com', '2024-07-20 12:30:00', 'N', 'N', 'A', NULL),
(1069, '1712345669', 'Bautista', NULL, 'Ernesto', 'Quito', '0991000069', NULL, 'ernesto.bautista@gmail.com', '2025-11-08 09:50:00', 'N', 'N', 'A', NULL),
(1070, '1712345670', 'Bermeo', NULL, 'Ruth', 'Cumbaya', '0991000070', NULL, 'ruth.bermeo@gmail.com', '2026-02-22 14:10:00', 'F', 'N', 'A', NULL),
(1071, '1712345671', 'Cabrera', NULL, 'Jose', 'Quito', '0991000071', NULL, 'jose.cabrera@gmail.com', '2025-03-04 10:35:00', 'N', 'N', 'A', NULL),
(1072, '1712345672', 'Camacho', NULL, 'Patricia', 'Sangolqui', '0991000072', NULL, 'patricia.camacho@gmail.com', '2024-10-15 16:45:00', 'F', 'N', 'A', NULL),
(1073, '1712345673', 'Campuzano', NULL, 'Luis', 'Quito', '0991000073', NULL, 'luis.campuzano@gmail.com', '2025-12-20 11:20:00', 'N', 'N', 'A', NULL),
(1074, '1712345674', 'Cañizares', NULL, 'Maria', 'Cumbaya', '0991000074', NULL, 'maria.canizares@gmail.com', '2026-06-08 09:15:00', 'N', 'N', 'A', NULL),
(1075, '1712345675', 'Cardenas', NULL, 'Juan', 'Quito', '0991000075', NULL, 'juan.cardenas@gmail.com', '2025-07-15 13:50:00', 'F', 'S', 'A', NULL),
(1076, '1712345676', 'Carrasco', NULL, 'Olga', 'Sangolqui', '0991000076', NULL, 'olga.carrasco@gmail.com', '2024-08-30 17:30:00', 'N', 'N', 'A', NULL),
(1077, '1712345677', 'Carvajal', NULL, 'Miguel', 'Quito', '0991000077', NULL, 'miguel.carvajal@gmail.com', '2025-09-18 10:05:00', 'N', 'N', 'A', NULL),
(1078, '1712345678', 'Castillo', NULL, 'Ana', 'Cumbaya', '0991000078', NULL, 'ana.castillo@gmail.com', '2026-03-28 15:20:00', 'F', 'N', 'A', NULL),
(1079, '1712345679', 'Cedeño', NULL, 'Carlos', 'Quito', '0991000079', NULL, 'carlos.cedeno@gmail.com', '2025-01-20 12:15:00', 'N', 'N', 'A', NULL),
(1080, '1712345680', 'Cevallos', NULL, 'Dora', 'Sangolqui', '0991000080', NULL, 'dora.cevallos@gmail.com', '2024-05-22 14:40:00', 'N', 'N', 'A', NULL),
(1081, '1712345681', 'Chavez', NULL, 'Sergio', 'Quito', '0991000081', NULL, 'sergio.chavez@gmail.com', '2025-08-08 09:25:00', 'F', 'N', 'A', NULL),
(1082, '1712345682', 'Cordero', NULL, 'Elena', 'Cumbaya', '0991000082', NULL, 'elena.cordero@gmail.com', '2026-02-12 16:10:00', 'N', 'N', 'A', NULL),
(1083, '1712345683', 'Costa', NULL, 'Andres', 'Quito', '0991000083', NULL, 'andres.costa@gmail.com', '2025-10-30 11:45:00', 'N', 'N', 'A', NULL),
(1084, '1712345684', 'Cruz', NULL, 'Beatriz', 'Sangolqui', '0991000084', NULL, 'beatriz.cruz@gmail.com', '2024-12-12 13:35:00', 'F', 'S', 'A', NULL),
(1085, '1712345685', 'Dávila', NULL, 'Alberto', 'Quito', '0991000085', NULL, 'alberto.davila@gmail.com', '2025-06-05 17:55:00', 'N', 'N', 'A', NULL),
(1086, '1712345686', 'Delgado', NULL, 'Carmen', 'Cumbaya', '0991000086', NULL, 'carmen.delgado@gmail.com', '2026-04-18 10:30:00', 'N', 'N', 'A', NULL),
(1087, '1712345687', 'Echeverria', NULL, 'Francisco', 'Quito', '0991000087', NULL, 'francisco.echeverria@gmail.com', '2025-03-12 14:50:00', 'F', 'N', 'A', NULL),
(1088, '1712345688', 'Escobar', NULL, 'Gloria', 'Sangolqui', '0991000088', NULL, 'gloria.escobar@gmail.com', '2024-09-25 09:40:00', 'N', 'N', 'A', NULL),
(1089, '1712345689', 'Estrada', NULL, 'Henry', 'Quito', '0991000089', NULL, 'henry.estrada@gmail.com', '2025-11-14 12:55:00', 'N', 'N', 'A', NULL),
(1090, '1712345690', 'Fajardo', NULL, 'Irene', 'Cumbaya', '0991000090', NULL, 'irene.fajardo@gmail.com', '2026-05-20 16:15:00', 'F', 'N', 'A', NULL),
(1091, '1712345691', 'Figueroa', NULL, 'Jorge', 'Quito', '0991000091', NULL, 'jorge.figueroa@gmail.com', '2025-02-08 08:35:00', 'N', 'N', 'A', NULL),
(1092, '1712345692', 'Flores', NULL, 'Lourdes', 'Sangolqui', '0991000092', NULL, 'lourdes.flores@gmail.com', '2024-07-16 13:10:00', 'F', 'N', 'A', NULL),
(1093, '1712345693', 'Franco', NULL, 'Marcelo', 'Quito', '0991000093', NULL, 'marcelo.franco@gmail.com', '2025-09-28 11:40:00', 'N', 'N', 'A', NULL),
(1094, '1712345694', 'Freire', NULL, 'Nora', 'Cumbaya', '0991000094', NULL, 'nora.freire@gmail.com', '2026-01-25 15:00:00', 'N', 'N', 'A', NULL),
(1095, '1712345695', 'Fuentes', NULL, 'Omar', 'Quito', '0991000095', NULL, 'omar.fuentes@gmail.com', '2025-05-09 10:20:00', 'F', 'S', 'A', NULL),
(1096, '1712345696', 'Galarza', NULL, 'Pilar', 'Sangolqui', '0991000096', NULL, 'pilar.galarza@gmail.com', '2024-10-28 17:00:00', 'N', 'N', 'A', NULL),
(1097, '1712345697', 'Galeas', NULL, 'Ramiro', 'Quito', '0991000097', NULL, 'ramiro.galeas@gmail.com', '2025-12-05 09:55:00', 'N', 'N', 'A', NULL),
(1098, '1712345698', 'Gallo', NULL, 'Sofia', 'Cumbaya', '0991000098', NULL, 'sofia.gallo@gmail.com', '2026-03-05 14:30:00', 'F', 'N', 'A', NULL),
(1099, '1712345699', 'Garzon', NULL, 'Tomas', 'Quito', '0991000099', NULL, 'tomas.garzon@gmail.com', '2025-07-22 12:40:00', 'N', 'N', 'A', NULL),
(1100, '1712345700', 'Gavilanes', NULL, 'Ursula', 'Sangolqui', '0991000100', NULL, 'ursula.gavilanes@gmail.com', '2024-11-15 16:25:00', 'N', 'N', 'A', NULL);

-- =====================================================
-- 2. CLIENTES 1101-1400 CON VARIABLE (CORREGIDO)
-- =====================================================
SET @row_num = 0;

INSERT INTO cliente
(codigo_cliente, cedula_ruc, apellido1, apellido2, nombres, direccion,
 telefono_principal, telefono_alterno, email_contacto, fecha_alta,
 tipo_cliente, permite_credito, estado_registro, observaciones)
SELECT
    @row_num := @row_num + 1 + 1100 AS codigo_cliente,
    CONCAT('171234', LPAD(FLOOR(RAND() * 10000), 4, '0')),
    ELT(FLOOR(RAND() * 20) + 1,
        'Acosta','Alcivar','Altamirano','Arcos','Arias','Armijos','Arroyo','Astorga','Aviles','Baque',
        'Bastidas','Bayas','Becerra','Beltran','Benavides','Bolanos','Bonilla','Borrero','Bravo','Burgos'),
    NULL,
    ELT(FLOOR(RAND() * 20) + 1,
        'Maria','Jose','Luis','Ana','Carlos','Carmen','Pedro','Elena','Juan','Lucia',
        'Miguel','Sofia','Jorge','Isabel','Rafael','Patricia','Andres','Rosa','David','Teresa'),
    CONCAT('Quito - ', ELT(FLOOR(RAND() * 10) + 1,
        'Centro','Norte','Sur','Este','Oeste','La Mariscal','El Batán','Cumbaya','Tumbaco','Puembo')),
    CONCAT('099', LPAD(FLOOR(RAND() * 100000), 6, '0')),
    NULL,
    CONCAT(LOWER(ELT(FLOOR(RAND() * 10) + 1,
        'cliente1','cliente2','cliente3','cliente4','cliente5','cliente6','cliente7','cliente8','cliente9','cliente0')),
        '@gmail.com'),
    DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 730) DAY),
    ELT(FLOOR(RAND() * 3) + 1, 'N', 'F', 'E'),
    ELT(FLOOR(RAND() * 2) + 1, 'N', 'S'),
    ELT(FLOOR(RAND() * 3) + 1, 'A', 'I', 'A'),
    'Cliente generado automáticamente'
FROM
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
     SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t1,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
     SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t2,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3) t3
LIMIT 300;

-- =====================================================
-- 3. CLIENTES CON DOCUMENTOS PROBLEMÁTICOS (1401-1450) - SIN CAMBIOS
-- =====================================================
INSERT INTO cliente
(codigo_cliente, cedula_ruc, apellido1, apellido2, nombres, direccion,
 telefono_principal, telefono_alterno, email_contacto, fecha_alta,
 tipo_cliente, permite_credito, estado_registro, observaciones)
VALUES
(1401, '171-234-5701', 'Maldonado', NULL, 'Rosa', 'Quito', '0991014001', NULL, 'rosa.maldonado@gmail.com', '2025-01-10 09:00:00', 'N', 'N', 'A', 'Documento con guiones'),
(1402, '171-234-5702', 'Aguilar', NULL, 'Pedro', 'Cumbaya', '0991014002', NULL, 'pedro.aguilar@gmail.com', '2025-02-15 10:30:00', 'F', 'N', 'A', 'Documento con guiones'),
(1403, '171-234-5703', 'Mora', NULL, 'Luis', 'Quito', '0991014003', NULL, 'luis.mora@gmail.com', '2025-03-20 11:45:00', 'N', 'N', 'A', 'Documento con guiones'),
(1404, '171-234-5704', 'Santos', NULL, 'Ana', 'Sangolqui', '0991014004', NULL, 'ana.santos@gmail.com', '2025-04-25 14:15:00', 'N', 'N', 'A', 'Documento con guiones'),
(1405, '171-234-5705', 'Palacios', NULL, 'Carlos', 'Quito', '0991014005', NULL, 'carlos.palacios@gmail.com', '2025-05-30 16:30:00', 'F', 'S', 'A', 'Documento con guiones'),
(1406, ' 1712345706', 'Gutierrez', NULL, 'Sofia', 'Quito', '0991014006', NULL, 'sofia.gutierrez@gmail.com', '2025-06-05 08:20:00', 'N', 'N', 'A', 'Documento con espacio inicial'),
(1407, ' 1712345707', 'Criollo', NULL, 'Jorge', 'Cumbaya', '0991014007', NULL, 'jorge.criollo@gmail.com', '2025-07-10 09:40:00', 'N', 'N', 'A', 'Documento con espacio inicial'),
(1408, ' 1712345708', 'Larrea', NULL, 'Maria', 'Quito', '0991014008', NULL, 'maria.larrea@gmail.com', '2025-08-15 12:30:00', 'F', 'N', 'A', 'Documento con espacio inicial'),
(1409, ' 1712345709', 'Ochoa', NULL, 'Diego', 'Sangolqui', '0991014009', NULL, 'diego.ochoa@gmail.com', '2025-09-20 15:00:00', 'N', 'N', 'A', 'Documento con espacio inicial'),
(1410, ' 1712345710', 'Ponce', NULL, 'Elena', 'Quito', '0991014010', NULL, 'elena.ponce@gmail.com', '2025-10-25 17:45:00', 'N', 'N', 'A', 'Documento con espacio inicial'),
(1411, '1712345711 ', 'Salcedo', NULL, 'Carlos', 'Quito', '0991014011', NULL, 'carlos.salcedo@gmail.com', '2025-11-01 09:10:00', 'F', 'N', 'A', 'Documento con espacio final'),
(1412, '1712345712 ', 'Teran', NULL, 'Ana', 'Cumbaya', '0991014012', NULL, 'ana.teran@gmail.com', '2025-12-05 10:50:00', 'N', 'N', 'A', 'Documento con espacio final'),
(1413, '1712345713 ', 'Uribe', NULL, 'Luis', 'Quito', '0991014013', NULL, 'luis.uribe@gmail.com', '2026-01-10 13:20:00', 'N', 'N', 'A', 'Documento con espacio final'),
(1414, '1712345714 ', 'Valdivieso', NULL, 'Maria', 'Sangolqui', '0991014014', NULL, 'maria.valdivieso@gmail.com', '2026-02-15 16:40:00', 'F', 'S', 'A', 'Documento con espacio final'),
(1415, '1712345715 ', 'Zapata', NULL, 'Jose', 'Quito', '0991014015', NULL, 'jose.zapata@gmail.com', '2026-03-20 11:30:00', 'N', 'N', 'A', 'Documento con espacio final'),
(1416, '171.234.5716', 'Astudillo', NULL, 'Patricia', 'Quito', '0991014016', NULL, 'patricia.astudillo@gmail.com', '2025-04-01 08:15:00', 'N', 'N', 'A', 'Documento con puntos'),
(1417, '171.234.5717', 'Bustos', NULL, 'Rafael', 'Cumbaya', '0991014017', NULL, 'rafael.bustos@gmail.com', '2025-05-10 09:45:00', 'F', 'N', 'A', 'Documento con puntos'),
(1418, '171.234.5718', 'Cordova', NULL, 'Gloria', 'Quito', '0991014018', NULL, 'gloria.cordova@gmail.com', '2025-06-15 12:10:00', 'N', 'N', 'A', 'Documento con puntos'),
(1419, '171.234.5719', 'Paz', NULL, 'Manuel', 'Sangolqui', '0991014019', NULL, 'manuel.paz@gmail.com', '2025-07-20 14:35:00', 'N', 'N', 'A', 'Documento con puntos'),
(1420, '171.234.5720', 'Quispe', NULL, 'Teresa', 'Quito', '0991014020', NULL, 'teresa.quispe@gmail.com', '2025-08-25 16:55:00', 'F', 'N', 'A', 'Documento con puntos'),
(1421, '171-234-5721', 'Roldan', NULL, 'Sergio', 'Quito', '0991014021', NULL, 'sergio.roldan@gmail.com', '2025-09-30 09:00:00', 'N', 'N', 'A', 'Documento con guiones y espacios'),
(1422, '171.234.5722 ', 'Sanchez', NULL, 'Carmen', 'Cumbaya', '0991014022', NULL, 'carmen.sanchez@gmail.com', '2025-10-05 10:30:00', 'N', 'N', 'A', 'Documento con puntos y espacio final'),
(1423, ' 171-234-5723', 'Vaca', NULL, 'Eduardo', 'Quito', '0991014023', NULL, 'eduardo.vaca@gmail.com', '2025-11-10 13:45:00', 'F', 'S', 'A', 'Documento con espacio inicial y guiones'),
(1424, '171-234-5724 ', 'Peralta', NULL, 'Ana', 'Sangolqui', '0991014024', NULL, 'ana.peralta@gmail.com', '2025-12-15 15:20:00', 'N', 'N', 'A', 'Documento con guiones y espacio final'),
(1425, ' 171.234.5725', 'Moreira', NULL, 'Luis', 'Quito', '0991014025', NULL, 'luis.moreira@gmail.com', '2026-01-20 11:40:00', 'N', 'N', 'A', 'Documento con espacio inicial y puntos'),
(1426, NULL, 'Anonimo1', NULL, 'Cliente Generico', 'Quito', NULL, NULL, NULL, '2026-01-01 00:00:00', 'N', 'N', 'A', 'Cliente sin documento'),
(1427, NULL, 'Anonimo2', NULL, 'Consumidor Final', 'Cumbaya', NULL, NULL, NULL, '2026-02-01 00:00:00', 'N', 'N', 'A', 'Cliente sin documento'),
(1428, NULL, 'Anonimo3', NULL, 'Cliente X', 'Sangolqui', NULL, NULL, NULL, '2026-03-01 00:00:00', 'N', 'N', 'A', 'Cliente sin documento'),
(1429, NULL, 'Desconocido', NULL, 'Cliente Desconocido', 'Quito', NULL, NULL, NULL, '2026-04-01 00:00:00', 'F', 'N', 'A', 'Cliente sin documento'),
(1430, NULL, 'No Identificado', NULL, 'Cliente No Identificado', 'Quito', NULL, NULL, NULL, '2026-05-01 00:00:00', 'N', 'N', 'A', 'Cliente sin documento'),
(1431, '', 'Vacio1', NULL, 'Cliente Sin Documento', 'Quito', NULL, NULL, NULL, '2026-01-15 00:00:00', 'N', 'N', 'A', 'Documento vacío'),
(1432, '', 'Vacio2', NULL, 'Sin Cedula', 'Cumbaya', NULL, NULL, NULL, '2026-02-15 00:00:00', 'N', 'N', 'A', 'Documento vacío'),
(1433, '', 'Vacio3', NULL, 'Sin Identificacion', 'Sangolqui', NULL, NULL, NULL, '2026-03-15 00:00:00', 'F', 'S', 'A', 'Documento vacío'),
(1434, '', 'Vacio4', NULL, 'Cliente Sin Ruc', 'Quito', NULL, NULL, NULL, '2026-04-15 00:00:00', 'N', 'N', 'A', 'Documento vacío'),
(1435, '', 'Vacio5', NULL, 'No Registra Cedula', 'Cumbaya', NULL, NULL, NULL, '2026-05-15 00:00:00', 'N', 'N', 'A', 'Documento vacío'),

-- =====================================================
-- 4. CLIENTES DUPLICADOS (1436-1450)
-- =====================================================
(1436, '1712345601', 'Rodriguez', NULL, 'Paola', 'Quito - La Magdalena', '0991000001', NULL, 'paola.rodriguez@gmail.com', '2024-04-25 09:10:00', 'F', 'N', 'A', 'DUPLICADO de 1001'),
(1437, '1712345605', 'Ortiz', NULL, 'Jose', 'Quito Norte', '0991000005', NULL, 'jose.ortiz@gmail.com', '2025-03-23 10:15:00', 'F', 'S', 'A', 'DUPLICADO de 1005'),
(1438, '1712345608', 'Perez', NULL, 'Jorge', 'Quito Centro', '0991000008', NULL, 'jperez@cafeteria.local', '2026-03-20 12:18:00', 'E', 'S', 'A', 'DUPLICADO de 1008'),
(1439, '1712345615', 'Ortiz', NULL, 'Elena', 'Quito', '0991000015', NULL, 'elena.ortiz2@gmail.com', '2026-01-10 18:06:00', 'N', 'N', 'A', 'DUPLICADO de 1015'),
(1440, '1712345620', 'Rodriguez', NULL, 'Valeria', 'Quito', '0991000020', NULL, 'valeria.rodriguez@gmail.com', '2024-08-17 14:17:00', 'F', 'N', 'A', 'DUPLICADO de 1020'),
(1441, '1712345625', 'Gomez', NULL, 'Miguel', 'Quito', '0991000025', NULL, 'miguel.gomez@gmail.com', '2025-03-07 10:52:00', 'F', 'N', 'A', 'DUPLICADO de 1025'),
(1442, '1712345630', 'Ortiz', NULL, 'Andrea', 'Quito', '0991000030', NULL, 'andrea.ortiz@gmail.com', '2026-01-06 08:26:00', 'N', 'N', 'A', 'DUPLICADO de 1030'),
(1443, '1712345636', 'Benitez', NULL, 'Gabriela', 'Quito', '0991000036', NULL, 'gabriela.benitez@gmail.com', '2025-01-25 16:45:00', 'F', 'S', 'A', 'DUPLICADO de 1036'),
(1444, '1712345644', 'Jimenez', NULL, 'Rosa', 'Sangolqui', '0991000044', NULL, 'rosa.jimenez@gmail.com', '2024-10-03 14:55:00', 'F', 'S', 'A', 'DUPLICADO de 1044'),
(1445, '1712345655', 'Rivas', NULL, 'Pedro', 'Quito', '0991000055', NULL, 'pedro.rivas@gmail.com', '2025-07-30 13:25:00', 'F', 'S', 'A', 'DUPLICADO de 1055'),
(1446, '1712345664', 'Vera', NULL, 'Gloria', 'Sangolqui', '0991000064', NULL, 'gloria.vera@gmail.com', '2024-11-01 08:25:00', 'F', 'S', 'A', 'DUPLICADO de 1064'),
(1447, '1712345675', 'Cardenas', NULL, 'Juan', 'Quito', '0991000075', NULL, 'juan.cardenas@gmail.com', '2025-07-15 13:50:00', 'F', 'S', 'A', 'DUPLICADO de 1075'),
(1448, '1712345684', 'Cruz', NULL, 'Beatriz', 'Sangolqui', '0991000084', NULL, 'beatriz.cruz@gmail.com', '2024-12-12 13:35:00', 'F', 'S', 'A', 'DUPLICADO de 1084'),
(1449, '1712345695', 'Fuentes', NULL, 'Omar', 'Quito', '0991000095', NULL, 'omar.fuentes@gmail.com', '2025-05-09 10:20:00', 'F', 'S', 'A', 'DUPLICADO de 1095'),
(1450, '1712345700', 'Gavilanes', NULL, 'Ursula', 'Sangolqui', '0991000100', NULL, 'ursula.gavilanes@gmail.com', '2024-11-15 16:25:00', 'N', 'N', 'A', 'DUPLICADO de 1100');

-- =====================================================
-- 5. CLIENTES 1451-1600 CON VARIABLE (CORREGIDO)
-- =====================================================
SET @row_num = 0;

INSERT INTO cliente
(codigo_cliente, cedula_ruc, apellido1, apellido2, nombres, direccion,
 telefono_principal, telefono_alterno, email_contacto, fecha_alta,
 tipo_cliente, permite_credito, estado_registro, observaciones)
SELECT
    @row_num := @row_num + 1 + 1450 AS codigo_cliente,
    CASE
        WHEN RAND() < 0.2 THEN CONCAT('171-234-', LPAD(FLOOR(RAND() * 10000), 4, '0'))
        WHEN RAND() < 0.4 THEN CONCAT(' ', '171234', LPAD(FLOOR(RAND() * 10000), 4, '0'))
        WHEN RAND() < 0.6 THEN CONCAT('171234', LPAD(FLOOR(RAND() * 10000), 4, '0'), ' ')
        WHEN RAND() < 0.8 THEN CONCAT('171.', LPAD(FLOOR(RAND() * 10000), 4, '0'))
        ELSE NULL
    END,
    ELT(FLOOR(RAND() * 30) + 1,
        'Arias','Bermeo','Cevallos','Delgado','Espinoza','Freire','Gavilanes','Herrera','Iza','Jara',
        'Lara','Moya','Naranjo','Ortega','Paredes','Quintero','Ramos','Santana','Tapia','Ulloa',
        'Valdivieso','Wong','Xavier','Yanez','Zambrano','Armas','Bustos','Cordova','Diaz','Enriquez'),
    NULL,
    ELT(FLOOR(RAND() * 30) + 1,
        'Alexander','Brenda','Cristian','Diana','Eduardo','Fabiola','Gustavo','Helen','Ivan','Jessica',
        'Kevin','Lorena','Michael','Nancy','Oscar','Paulina','Roberto','Silvia','Tony','Valeria',
        'William','Ximena','Yolanda','Zoe','Adrian','Blanca','Cesar','Dolores','Enrique','Felix'),
    CONCAT(ELT(FLOOR(RAND() * 5) + 1, 'Quito', 'Cumbaya', 'Sangolqui', 'Tumbaco', 'Puembo'),
           ' - ', ELT(FLOOR(RAND() * 10) + 1,
           'Centro','Norte','Sur','Este','Oeste','Av. Principal','Calle 1','Barrio A','Sector B','Urbanización C')),
    CONCAT('099', LPAD(FLOOR(RAND() * 1000000), 7, '0')),
    CONCAT('09', LPAD(FLOOR(RAND() * 1000000), 7, '0')),
    CONCAT(LOWER(ELT(FLOOR(RAND() * 20) + 1,
        'cliente1','cliente2','cliente3','cliente4','cliente5','cliente6','cliente7','cliente8','cliente9','cliente10',
        'usuario1','usuario2','usuario3','usuario4','usuario5','usuario6','usuario7','usuario8','usuario9','usuario10')),
        '@' , ELT(FLOOR(RAND() * 5) + 1, 'gmail.com', 'hotmail.com', 'outlook.com', 'yahoo.com', 'cafeteria.com')),
    DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 900) DAY),
    ELT(FLOOR(RAND() * 4) + 1, 'N', 'F', 'E', 'N'),
    ELT(FLOOR(RAND() * 3) + 1, 'N', 'S', 'N'),
    ELT(FLOOR(RAND() * 5) + 1, 'A', 'I', 'A', 'A', 'A'),
    CASE
        WHEN RAND() < 0.1 THEN 'Registro con formato inconsistente'
        WHEN RAND() < 0.2 THEN 'Documento con caracteres especiales'
        ELSE NULL
    END
FROM
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
     SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t1,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t2,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3) t3
LIMIT 150;

-- =====================================================
-- 6. CLIENTES 1601-1800 (CON DATOS INCOMPLETOS) - CORREGIDO
-- =====================================================
SET @row_num = 0;

INSERT INTO cliente
(codigo_cliente, cedula_ruc, apellido1, apellido2, nombres, direccion,
 telefono_principal, telefono_alterno, email_contacto, fecha_alta,
 tipo_cliente, permite_credito, estado_registro, observaciones)
SELECT
    @row_num := @row_num + 1 + 1600 AS codigo_cliente,
    CASE
        WHEN RAND() < 0.3 THEN NULL
        WHEN RAND() < 0.6 THEN ''
        ELSE CONCAT('171234', LPAD(FLOOR(RAND() * 10000), 4, '0'))
    END,
    CASE WHEN RAND() < 0.2 THEN NULL ELSE ELT(FLOOR(RAND() * 20) + 1,
        'Alvarez','Bermudez','Correa','Duran','Estrada','Ferrin','Guerrero','Hurtado','Iglesias','Jurado',
        'Ledesma','Mendez','Nieto','Ordonez','Pinto','Quezada','Rosero','Saavedra','Torres','Uvidia') END,
    NULL,
    CASE WHEN RAND() < 0.1 THEN 'Cliente' ELSE ELT(FLOOR(RAND() * 20) + 1,
        'Daniel','Gabriela','Alejandro','Catherine','Benjamin','Dolores','Cristopher','Andrea',
        'Jonathan','Katherine','Leonardo','Melissa','Nelson','Olga','Pablo','Raquel','Samuel','Tania',
        'Victor','Wendy') END,
    CASE WHEN RAND() < 0.3 THEN NULL ELSE CONCAT(ELT(FLOOR(RAND() * 3) + 1, 'Quito', 'Cumbaya', 'Sangolqui'),
        ' ', ELT(FLOOR(RAND() * 5) + 1, 'Centro', 'Norte', 'Sur', 'Este', 'Oeste')) END,
    CASE WHEN RAND() < 0.4 THEN NULL ELSE CONCAT('099', LPAD(FLOOR(RAND() * 1000000), 7, '0')) END,
    NULL,
    CASE WHEN RAND() < 0.5 THEN NULL ELSE CONCAT(ELT(FLOOR(RAND() * 10) + 1,
        'a','b','c','d','e','f','g','h','i','j'), '@gmail.com') END,
    CASE WHEN RAND() < 0.2 THEN NULL ELSE DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 900) DAY) END,
    ELT(FLOOR(RAND() * 4) + 1, 'N', 'F', 'E', 'N'),
    ELT(FLOOR(RAND() * 3) + 1, 'N', 'S', 'N'),
    ELT(FLOOR(RAND() * 4) + 1, 'A', 'I', 'A', 'A'),
    CASE
        WHEN RAND() < 0.15 THEN 'Registro incompleto - verificar datos'
        WHEN RAND() < 0.25 THEN 'Sin información de contacto'
        ELSE NULL
    END
FROM
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
     SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t1,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t2,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t3
LIMIT 200;

-- =====================================================
-- 7. CLIENTES 1801-2000 - CORREGIDO
-- =====================================================
SET @row_num = 0;

INSERT INTO cliente
(codigo_cliente, cedula_ruc, apellido1, apellido2, nombres, direccion,
 telefono_principal, telefono_alterno, email_contacto, fecha_alta,
 tipo_cliente, permite_credito, estado_registro, observaciones)
SELECT
    @row_num := @row_num + 1 + 1800 AS codigo_cliente,
    CASE FLOOR(RAND() * 6)
        WHEN 0 THEN CONCAT('171-234-', LPAD(FLOOR(RAND() * 10000), 4, '0'))
        WHEN 1 THEN CONCAT(' ', '171234', LPAD(FLOOR(RAND() * 10000), 4, '0'))
        WHEN 2 THEN CONCAT('171234', LPAD(FLOOR(RAND() * 10000), 4, '0'), ' ')
        WHEN 3 THEN CONCAT('171.', LPAD(FLOOR(RAND() * 10000), 4, '0'))
        WHEN 4 THEN NULL
        ELSE ''
    END,
    ELT(FLOOR(RAND() * 20) + 1,
        'Acuña','Barrera','Calderon','Chiriboga','Cordero','Chasi','Garcia','Hidalgo','Luna','Maldonado',
        'Navas','Orellana','Pazmiño','Quijia','Ruales','Sampedro','Tamayo','Uzho','Villalba','Yunga'),
    NULL,
    ELT(FLOOR(RAND() * 20) + 1,
        'Alberto','Beatriz','Cesar','Dolores','Enrique','Francisca','Guillermo','Hortencia','Ismael','Julia',
        'Leonardo','Matilde','Norberto','Ofelia','Patricio','Raquel','Salvador','Teresa','Ulises','Victoria'),
    CASE WHEN RAND() < 0.2 THEN NULL ELSE CONCAT(ELT(FLOOR(RAND() * 5) + 1, 'Quito', 'Cumbaya', 'Sangolqui', 'Tumbaco', 'Puembo'),
        ' - ', ELT(FLOOR(RAND() * 8) + 1,
        'Av. Principal','Calle Secundaria','Barrio Central','Sector A','Urbanización Los Pinos','Cdla. La Mariscal',
        'Parroquia San Juan','Comuna Santa Rosa')) END,
    CASE WHEN RAND() < 0.3 THEN NULL ELSE CONCAT('099', LPAD(FLOOR(RAND() * 1000000), 7, '0')) END,
    NULL,
    CASE WHEN RAND() < 0.4 THEN NULL ELSE CONCAT(ELT(FLOOR(RAND() * 15) + 1,
        'cliente','usuario','contacto','info','ventas','soporte','admin','guest','test','demo',
        'user','mail','correo','email','web'), FLOOR(RAND() * 999),
        '@', ELT(FLOOR(RAND() * 5) + 1, 'gmail.com', 'hotmail.com', 'outlook.com', 'yahoo.com', 'cafeteria.com')) END,
    CASE WHEN RAND() < 0.3 THEN NULL ELSE DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 1200) DAY) END,
    ELT(FLOOR(RAND() * 4) + 1, 'N', 'F', 'E', 'N'),
    ELT(FLOOR(RAND() * 3) + 1, 'N', 'S', 'N'),
    CASE WHEN RAND() < 0.1 THEN 'I' ELSE 'A' END,
    CASE
        WHEN RAND() < 0.1 THEN 'Cliente con formato de documento inconsistente'
        WHEN RAND() < 0.15 THEN 'Datos de contacto incompletos'
        WHEN RAND() < 0.2 THEN 'Registro con múltiples problemas de calidad'
        ELSE NULL
    END
FROM
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
     SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t1,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t2,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t3
LIMIT 200;

-- =====================================================
-- 8. CLIENTES PROBLEMÁTICOS ADICIONALES (2001-2010) - SIN CAMBIOS
-- =====================================================
INSERT INTO cliente
(codigo_cliente, cedula_ruc, apellido1, apellido2, nombres, direccion,
 telefono_principal, telefono_alterno, email_contacto, fecha_alta,
 tipo_cliente, permite_credito, estado_registro, observaciones)
VALUES
(2001, '9999999999', 'GENERICO', NULL, 'CLIENTE GENERICO', 'Quito', NULL, NULL, NULL, '2024-01-01 00:00:00', 'N', 'N', 'A', 'Cliente genérico para ventas sin identificación'),
(2002, '0000000000', 'TEST', NULL, 'CLIENTE PRUEBA', 'Quito', NULL, NULL, NULL, '2024-01-01 00:00:00', 'N', 'N', 'A', 'Cliente de prueba del sistema'),
(2003, '1111111111', 'DEMO', NULL, 'CLIENTE DEMO', 'Cumbaya', NULL, NULL, NULL, '2024-01-01 00:00:00', 'N', 'N', 'A', 'Cliente demo'),
(2004, '2222222222', 'SIN', NULL, 'CLIENTE SIN DATOS', NULL, NULL, NULL, NULL, '2024-01-01 00:00:00', 'N', 'N', 'A', 'Cliente sin datos de contacto'),
(2005, '3333333333', 'INACTIVO', NULL, 'CLIENTE INACTIVO', 'Quito', '0991999999', NULL, 'inactivo@demo.com', '2023-01-01 00:00:00', 'N', 'N', 'I', 'Cliente inactivo'),
(2006, '171-234-5999', 'ERROR', NULL, 'CLIENTE GUIONES', 'Quito', '0991988888', NULL, 'error@demo.com', '2024-06-01 12:00:00', 'N', 'N', 'A', 'Documento con guiones'),
(2007, ' 1712345998', 'ESPACIO', NULL, 'CLIENTE ESPACIO', 'Quito', '0991977777', NULL, 'espacio@demo.com', '2024-07-01 13:00:00', 'N', 'N', 'A', 'Documento con espacio inicial'),
(2008, '1712345997 ', 'ESPACIOF', NULL, 'CLIENTE ESPACIO FINAL', 'Quito', '0991966666', NULL, 'espaciof@demo.com', '2024-08-01 14:00:00', 'N', 'N', 'A', 'Documento con espacio final'),
(2009, '171.234.5996', 'PUNTO', NULL, 'CLIENTE PUNTOS', 'Quito', '0991955555', NULL, 'punto@demo.com', '2024-09-01 15:00:00', 'N', 'N', 'A', 'Documento con puntos'),
(2010, '171-234-5995 ', 'COMBINACION', NULL, 'CLIENTE COMBINADO', 'Quito', '0991944444', NULL, 'combinado@demo.com', '2024-10-01 16:00:00', 'N', 'N', 'A', 'Documento con guiones y espacio final');

-- =====================================================
-- CONSULTAS DE VALIDACIÓN
-- =====================================================
SELECT COUNT(*) AS total_clientes_mysql FROM cliente;
-- SELECT cedula_ruc, COUNT(*) FROM cliente GROUP BY cedula_ruc HAVING COUNT(*) > 1;
-- SELECT * FROM cliente WHERE cedula_ruc IS NULL OR TRIM(cedula_ruc) = '';
-- SELECT * FROM cliente WHERE telefono_principal IS NULL OR TRIM(telefono_principal) = '';
-- SELECT * FROM cliente WHERE email_contacto IS NULL OR TRIM(email_contacto) = '';
-- SELECT * FROM cliente WHERE fecha_alta IS NULL;
-- SELECT COUNT(*) FROM cliente WHERE estado_registro = 'I';
-- SELECT COUNT(*) FROM cliente WHERE tipo_cliente = 'N';
-- SELECT COUNT(*) FROM cliente WHERE permite_credito = 'S';