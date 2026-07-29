/*
    Estudiante:  (Actualizado / Enriquecido para Ejercicios de BDD)
    Fecha: 2026-07-20
    Descripcion: Script SQL para poblar con datos enriquecidos y diversos
    la base de datos INFOTECH de la empresa TechSolutions.
*/

USE INFOTECH;

-- Desactivar restricciones de clave foránea temporalmente para limpieza limpia
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE EQUIPO_COMPUTACIONAL;
TRUNCATE TABLE ES_PROPIETARIO;
TRUNCATE TABLE PROPIETARIO;
TRUNCATE TABLE EMPRESA;
TRUNCATE TABLE TRABAJO_EN;
TRUNCATE TABLE PROYECTO;
TRUNCATE TABLE ADMINISTRATIVO;
TRUNCATE TABLE INGENIERO;
TRUNCATE TABLE CLIENTE;
TRUNCATE TABLE EMPLEADO;
TRUNCATE TABLE TELEFONO;
TRUNCATE TABLE PERSONA;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. INSERTAR PERSONAS (30 Registros: Empleados, Clientes y Representantes)
INSERT INTO PERSONA (
    CI,
    Primer_Nombre,
    Segundo_Nombre,
    Primer_Apellido,
    Segundo_Apellido,
    Fecha_Nacimiento,
    Correo
) VALUES
('0000000001', 'Carlos', 'Andres', 'Mendoza', 'Lopez', '1988-03-15', 'carlos.mendoza@infotech.com'),
('0000000002', 'Maria', 'Fernanda', 'Garcia', 'Perez', '1990-07-22', 'maria.garcia@infotech.com'),
('0000000003', 'Luis', 'Alberto', 'Zambrano', 'Vera', '1985-11-10', 'luis.zambrano@infotech.com'),
('0000000004', 'Ana', 'Sofia', 'Castro', 'Reyes', '1992-01-30', 'ana.castro@infotech.com'),
('0000000005', 'Jose', 'Miguel', 'Moreira', 'Santos', '1987-09-05', 'jose.moreira@infotech.com'),
('0000000006', 'Daniela', 'Isabel', 'Romero', 'Cedeño', '1994-04-18', 'daniela.romero@infotech.com'),
('0000000007', 'Pedro', 'Antonio', 'Vargas', 'Mora', '1989-12-09', 'pedro.vargas@infotech.com'),
('0000000008', 'Camila', 'Alejandra', 'Navarro', 'Ruiz', '1996-06-25', 'camila.navarro@infotech.com'),
('0000000009', 'Jorge', 'Eduardo', 'Paredes', 'Solorzano', '1984-08-12', 'jorge.paredes@infotech.com'),
('0000000010', 'Valeria', 'Lucia', 'Ortega', 'Macias', '1993-10-03', 'valeria.ortega@infotech.com'),

('0000000011', 'Ricardo', 'Javier', 'Alvarado', 'Ponce', '1986-02-14', 'ricardo.alvarado@infotech.com'),
('0000000012', 'Gabriela', 'Patricia', 'Cevallos', 'Mera', '1991-05-20', 'gabriela.cevallos@infotech.com'),
('0000000013', 'Andres', 'Sebastian', 'Bravo', 'Chavez', '1995-09-17', 'andres.bravo@infotech.com'),
('0000000014', 'Paola', 'Beatriz', 'Delgado', 'Molina', '1983-01-08', 'paola.delgado@infotech.com'),
('0000000015', 'Fernando', 'Mateo', 'Quintero', 'Rivas', '1990-03-27', 'fernando.quintero@infotech.com'),
('0000000016', 'Lucia', 'Carolina', 'Herrera', 'Zapata', '1997-11-02', 'lucia.herrera@infotech.com'),
('0000000017', 'Esteban', 'Rafael', 'Flores', 'Cantos', '1982-12-19', 'esteban.flores@infotech.com'),
('0000000018', 'Natalia', 'Andrea', 'Bermudez', 'Loor', '1994-07-07', 'natalia.bermudez@infotech.com'),
('0000000019', 'Manuel', 'Ignacio', 'Torres', 'Velez', '1989-04-29', 'manuel.torres@infotech.com'),
('0000000020', 'Karla', 'Estefania', 'Salazar', 'Noboa', '1996-08-16', 'karla.salazar@infotech.com'),

('0000000021', 'Roberto', 'Enrique', 'Molina', 'Arias', '1979-06-11', 'roberto.molina@cliente.com'),
('0000000022', 'Silvia', 'Maribel', 'Rojas', 'Viteri', '1981-09-24', 'silvia.rojas@cliente.com'),
('0000000023', 'Hector', 'Daniel', 'Suarez', 'Paz', '1977-02-05', 'hector.suarez@cliente.com'),
('0000000024', 'Monica', 'Gabriela', 'Leon', 'Acosta', '1988-10-21', 'monica.leon@cliente.com'),
('0000000025', 'Ivan', 'Alejandro', 'Carrillo', 'Mejia', '1992-12-01', 'ivan.carrillo@cliente.com'),
('0000000026', 'Patricia', 'Elena', 'Guerrero', 'Tapia', '1986-05-13', 'patricia.guerrero@cliente.com'),
('0000000027', 'Diego', 'Francisco', 'Cordero', 'Palma', '1991-03-09', 'diego.cordero@cliente.com'),
('0000000028', 'Adriana', 'Victoria', 'Espinoza', 'Villacis', '1984-07-28', 'adriana.espinoza@cliente.com'),
('0000000029', 'Raul', 'Cristobal', 'Naranjo', 'Aguilar', '1980-11-30', 'raul.naranjo@cliente.com'),
('0000000030', 'Carmen', 'Rosa', 'Montes', 'Calderon', '1993-01-26', 'carmen.montes@cliente.com');

-- 2. INSERTAR TELEFONOS (Varios teléfonos por persona para permitir 1:N real)
INSERT INTO TELEFONO (Numero, CI) VALUES
('0991112233', '0000000001'),
('0991112244', '0000000001'), -- Segundo teléfono
('0982223344', '0000000002'),
('0973334455', '0000000003'),
('0973334466', '0000000003'), -- Segundo teléfono
('0964445566', '0000000004'),
('0955556677', '0000000005'),
('0946667788', '0000000006'),
('0937778899', '0000000007'),
('0937778800', '0000000007'), -- Segundo teléfono
('0928889900', '0000000008'),
('0919990011', '0000000009'),
('0901234567', '0000000010'),
('0992345678', '0000000021'),
('0983456789', '0000000022'),
('0974567890', '0000000023'),
('0965678901', '0000000024');

-- 3. INSERTAR EMPLEADOS (20 Empleados)
INSERT INTO EMPLEADO (CI, Salario_Base, Fecha_Contratacion) VALUES
('0000000001', 1850.00, '2018-03-01'),
('0000000002', 1350.00, '2019-06-15'),
('0000000003', 2100.00, '2017-09-10'),
('0000000004', 1250.00, '2020-01-20'),
('0000000005', 1600.00, '2016-11-05'),
('0000000006', 1400.00, '2021-04-12'),
('0000000007', 2300.00, '2015-08-25'),
('0000000008', 1300.00, '2022-02-14'),
('0000000009', 1950.00, '2018-12-03'),
('0000000010', 1450.00, '2020-07-09'),
('0000000011', 950.00,  '2019-05-11'),
('0000000012', 980.00,  '2021-10-18'),
('0000000013', 1050.00, '2018-01-23'),
('0000000014', 1100.00, '2017-04-04'),
('0000000015', 1020.00, '2022-09-07'),
('0000000016', 970.00,  '2023-03-16'),
('0000000017', 1150.00, '2016-06-22'),
('0000000018', 1080.00, '2020-11-30'),
('0000000019', 990.00,  '2024-01-10'),
('0000000020', 1120.00, '2019-12-19');

-- 4. INSERTAR CLIENTES (10 Clientes asignados a representantes empleados)
INSERT INTO CLIENTE (CI, Cupo_Credito, CI_Representante) VALUES
('0000000021', 2500.00, '0000000001'),
('0000000022', 3000.00, '0000000002'),
('0000000023', 1800.00, '0000000003'),
('0000000024', 4000.00, '0000000004'),
('0000000025', 3500.00, '0000000005'),
('0000000026', 2200.00, '0000000006'),
('0000000027', 5000.00, '0000000007'),
('0000000028', 2800.00, '0000000008'),
('0000000029', 3200.00, '0000000009'),
('0000000030', 4500.00, '0000000010');

-- 5. INSERTAR INGENIEROS (10 Empleados Especializados)
INSERT INTO INGENIERO (CI, Especialidad) VALUES
('0000000001', 'Software'),
('0000000002', 'Redes'),
('0000000003', 'Datos'),
('0000000004', 'Software'),
('0000000005', 'Redes'),
('0000000006', 'Datos'),
('0000000007', 'Software'),
('0000000008', 'Redes'),
('0000000009', 'Datos'),
('0000000010', 'Software');

-- 6. INSERTAR ADMINISTRATIVOS (10 Empleados Administrativos)
INSERT INTO ADMINISTRATIVO (CI, Area) VALUES
('0000000011', 'Finanzas'),
('0000000012', 'RRHH'),
('0000000013', 'Ventas'),
('0000000014', 'Finanzas'),
('0000000015', 'RRHH'),
('0000000016', 'Ventas'),
('0000000017', 'Finanzas'),
('0000000018', 'RRHH'),
('0000000019', 'Ventas'),
('0000000020', 'Finanzas');

-- 7. INSERTAR PROYECTOS (12 Proyectos con Presupuesto, Estado y Departamento)
INSERT INTO PROYECTO (Codigo, Nombre, Presupuesto, Estado, Departamento, Fecha_Inicio, Fecha_Termino) VALUES
('PRY001', 'Sistema de Inventario Web', 15000.00, 'Completado', 'Sistemas', '2023-01-10', '2023-06-30'),
('PRY002', 'Pagina Web Corporativa', 8500.00, 'Completado', 'Marketing', '2023-03-01', '2023-08-15'),
('PRY003', 'Aplicacion Movil Clientes', 25000.00, 'En Proceso', 'Desarrollo', '2023-05-20', NULL),
('PRY004', 'Red Interna Empresarial', 12000.00, 'Completado', 'Infraestructura', '2022-09-12', '2023-02-28'),
('PRY005', 'Sistema de Facturacion ERP', 30000.00, 'En Proceso', 'Finanzas', '2024-01-08', NULL),
('PRY006', 'Migracion de Servidores Cloud', 18000.00, 'Completado', 'Infraestructura', '2022-04-18', '2022-12-20'),
('PRY007', 'Portal de Soporte Tecnico', 9500.00, 'En Proceso', 'Sistemas', '2024-02-14', NULL),
('PRY008', 'Dashboard Administrativo', 14000.00, 'Completado', 'Gerencia', '2023-07-05', '2023-12-10'),
('PRY009', 'Seguridad y Ciberdefensa', 22000.00, 'En Proceso', 'Infraestructura', '2024-03-11', NULL),
('PRY010', 'Base de Datos Comercial', 16500.00, 'Completado', 'Desarrollo', '2023-10-02', '2024-01-30'),
('PRY011', 'Auditoria de Datos e Inteligencia', 7000.00, 'Planificado', 'Desarrollo', '2024-08-01', NULL),
('PRY012', 'Plataforma E-learning Corp', 35000.00, 'Suspendido', 'Desarrollo', '2023-11-15', NULL);

-- 8. INSERTAR TRABAJO_EN (Asignaciones N:M enriquecidas con Roles y Horas)
INSERT INTO TRABAJO_EN (CI_Empleado, Codigo_Proyecto, Horas_Semanales, Rol) VALUES
('0000000001', 'PRY001', 20, 'Lider de Proyecto'),
('0000000001', 'PRY003', 15, 'Arquitecto de Software'),
('0000000002', 'PRY002', 25, 'Especialista en Redes'),
('0000000002', 'PRY004', 12, 'Consultor de Infraestructura'),
('0000000003', 'PRY003', 30, 'Cientifico de Datos'),
('0000000003', 'PRY010', 10, 'DBA Senior'),
('0000000004', 'PRY004', 18, 'Desarrollador Backend'),
('0000000005', 'PRY005', 35, 'Administrador de Redes'),
('0000000006', 'PRY006', 22, 'Ingeniero de Datos'),
('0000000007', 'PRY007', 28, 'Lider Tecnico'),
('0000000007', 'PRY001', 10, 'Consultor de Sistemas'),
('0000000008', 'PRY008', 16, 'Ingeniero de Comunicaciones'),
('0000000009', 'PRY009', 32, 'Analista de Datos'),
('0000000010', 'PRY010', 24, 'Desarrollador Fullstack'),
('0000000010', 'PRY005', 15, 'Tester QA');

-- 9. INSERTAR EMPRESAS
INSERT INTO EMPRESA (ID_Empresa, Nombre) VALUES
('EMP001', 'Tech Solutions Corp'),
('EMP002', 'Data Corp Analytics'),
('EMP003', 'Redes Ecuador S.A.'),
('EMP004', 'Software Global Ltd'),
('EMP005', 'Digital Systems EC'),
('EMP006', 'Soluciones Andinas'),
('EMP007', 'Cloud Services EC'),
('EMP008', 'InfoRed Consultores'),
('EMP009', 'Sistemas Integrales'),
('EMP010', 'Innovacion Tecnologica');

-- 10. INSERTAR PROPIETARIOS
INSERT INTO PROPIETARIO (ID_Propietario) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- 11. INSERTAR ES_PROPIETARIO
INSERT INTO ES_PROPIETARIO (ID_Propietario, Tipo_Propietario, CI_Persona, CI_Cliente, ID_Empresa) VALUES
(1, 'Persona', '0000000001', NULL, NULL),
(2, 'Persona', '0000000002', NULL, NULL),
(3, 'Persona', '0000000003', NULL, NULL),
(4, 'Persona', '0000000004', NULL, NULL),
(5, 'Cliente', NULL, '0000000021', NULL),
(6, 'Cliente', NULL, '0000000022', NULL),
(7, 'Cliente', NULL, '0000000023', NULL),
(8, 'Empresa', NULL, NULL, 'EMP001'),
(9, 'Empresa', NULL, NULL, 'EMP002'),
(10, 'Empresa', NULL, NULL, 'EMP003');

-- 12. INSERTAR EQUIPOS COMPUTACIONALES (Con Valor Estimado, Estado y Fecha de Adquisición)
INSERT INTO EQUIPO_COMPUTACIONAL (Codigo_Inventario, Tipo, Marca, Modelo, Valor_Estimado, Estado, Fecha_Adquisicion, ID_Propietario) VALUES
('EQ001', 'Laptop', 'Dell', 'Latitude 5420', 1250.00, 'Operativo', '2022-01-15', 1),
('EQ002', 'Laptop', 'HP', 'EliteBook 840', 1400.00, 'Operativo', '2022-03-20', 2),
('EQ003', 'Desktop', 'Lenovo', 'ThinkCentre M70q', 950.00, 'Operativo', '2021-11-10', 3),
('EQ004', 'Servidor', 'Dell', 'PowerEdge T350', 4500.00, 'Operativo', '2023-02-05', 4),
('EQ005', 'Router', 'Cisco', 'RV340', 650.00, 'En Mantenimiento', '2020-08-14', 5),
('EQ006', 'Switch', 'TP-Link', 'JetStream T1600G', 420.00, 'Operativo', '2021-05-30', 6),
('EQ007', 'Impresora', 'Epson', 'EcoTank L3250', 310.00, 'Operativo', '2022-09-12', 7),
('EQ008', 'Servidor', 'Lenovo', 'ThinkSystem SR250', 3800.00, 'Operativo', '2023-06-18', 8),
('EQ009', 'Laptop', 'Asus', 'ExpertBook B1', 1100.00, 'En Mantenimiento', '2023-01-22', 9),
('EQ010', 'Desktop', 'Acer', 'Veriton X', 780.00, 'Baja', '2019-04-10', 10),
('EQ011', 'Laptop', 'Apple', 'MacBook Pro 14', 2400.00, 'Operativo', '2023-09-01', 1),
('EQ012', 'Servidor', 'HP', 'ProLiant DL380', 5200.00, 'Operativo', '2022-12-05', 8);

SELECT 'Base de Datos INFOTECH Poblada Exitosamente' AS Mensaje;