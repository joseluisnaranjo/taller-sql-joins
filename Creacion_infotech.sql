/*
 Estudiante:
 Fecha: 06/07/2026
 Descripcion: Script SQL para crear la base de datos INFOTECH,
 correspondiente al modelo relacional normalizado hasta 3FN
 de la empresa TechSolutions.
 */
DROP DATABASE IF EXISTS INFOTECH;
CREATE DATABASE INFOTECH;
USE INFOTECH;
CREATE TABLE PERSONA (
    CI VARCHAR(10) NOT NULL,
    Primer_Nombre VARCHAR(15) NOT NULL,
    Segundo_Nombre VARCHAR(15) NOT NULL,
    Primer_Apellido VARCHAR(15) NOT NULL,
    Segundo_Apellido VARCHAR(15) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Correo VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_persona PRIMARY KEY (CI)
);
CREATE TABLE TELEFONO (
    Numero VARCHAR(10) NOT NULL,
    CI VARCHAR(10) NOT NULL,
    CONSTRAINT pk_telefono PRIMARY KEY (CI, Numero),
    CONSTRAINT fk_telefono_persona FOREIGN KEY (CI) REFERENCES PERSONA(CI) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE EMPLEADO (
    CI VARCHAR(10) NOT NULL,
    Salario_Base DECIMAL(10, 2) NOT NULL,
    Fecha_Contratacion DATE NOT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY (CI),
    CONSTRAINT fk_empleado_persona FOREIGN KEY (CI) REFERENCES PERSONA(CI) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE CLIENTE (
    CI VARCHAR(10) NOT NULL,
    Cupo_Credito DECIMAL(10, 2) NULL,
    CI_Representante VARCHAR(10) NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (CI),
    CONSTRAINT fk_cliente_persona FOREIGN KEY (CI) REFERENCES PERSONA(CI) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cliente_representante FOREIGN KEY (CI_Representante) REFERENCES EMPLEADO(CI) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE PROYECTO (
    Codigo VARCHAR(20) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Presupuesto DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    Estado ENUM(
        'Planificado',
        'En Proceso',
        'Completado',
        'Suspendido'
    ) NOT NULL DEFAULT 'En Proceso',
    Departamento VARCHAR(50) NOT NULL DEFAULT 'Tecnología',
    Fecha_Inicio DATE NOT NULL,
    Fecha_Termino DATE NULL,
    CONSTRAINT pk_proyecto PRIMARY KEY (Codigo)
);
CREATE TABLE INGENIERO (
    CI VARCHAR(10) NOT NULL,
    Especialidad ENUM('Software', 'Redes', 'Datos') NOT NULL,
    CONSTRAINT pk_ingeniero PRIMARY KEY (CI),
    CONSTRAINT fk_ingeniero_empleado FOREIGN KEY (CI) REFERENCES EMPLEADO(CI) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE ADMINISTRATIVO (
    CI VARCHAR(10) NOT NULL,
    Area ENUM('Finanzas', 'RRHH', 'Ventas') NOT NULL,
    CONSTRAINT pk_administrativo PRIMARY KEY (CI),
    CONSTRAINT fk_administrativo_empleado FOREIGN KEY (CI) REFERENCES EMPLEADO(CI) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE TRABAJO_EN (
    CI_Empleado VARCHAR(10) NOT NULL,
    Codigo_Proyecto VARCHAR(20) NOT NULL,
    Horas_Semanales INT NOT NULL,
    Rol VARCHAR(50) NOT NULL DEFAULT 'Desarrollador',
    CONSTRAINT pk_trabajo_en PRIMARY KEY (CI_Empleado, Codigo_Proyecto),
    CONSTRAINT chk_horas_semanales CHECK (
        Horas_Semanales > 0
        AND Horas_Semanales <= 40
    ),
    CONSTRAINT fk_trabajo_empleado FOREIGN KEY (CI_Empleado) REFERENCES EMPLEADO(CI) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_trabajo_proyecto FOREIGN KEY (Codigo_Proyecto) REFERENCES PROYECTO(Codigo) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE EMPRESA (
    ID_Empresa VARCHAR(12) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    CONSTRAINT pk_empresa PRIMARY KEY (ID_Empresa)
);
CREATE TABLE PROPIETARIO (
    ID_Propietario INT NOT NULL AUTO_INCREMENT,
    CONSTRAINT pk_propietario PRIMARY KEY (ID_Propietario)
);
CREATE TABLE ES_PROPIETARIO (
    ID_Propietario INT NOT NULL,
    Tipo_Propietario ENUM('Persona', 'Cliente', 'Empresa') NOT NULL,
    CI_Persona VARCHAR(10) NULL,
    CI_Cliente VARCHAR(10) NULL,
    ID_Empresa VARCHAR(12) NULL,
    CONSTRAINT pk_es_propietario PRIMARY KEY (ID_Propietario),
    CONSTRAINT fk_es_propietario_propietario FOREIGN KEY (ID_Propietario) REFERENCES PROPIETARIO(ID_Propietario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_es_propietario_persona FOREIGN KEY (CI_Persona) REFERENCES PERSONA(CI) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_es_propietario_cliente FOREIGN KEY (CI_Cliente) REFERENCES CLIENTE(CI) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_es_propietario_empresa FOREIGN KEY (ID_Empresa) REFERENCES EMPRESA(ID_Empresa) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE EQUIPO_COMPUTACIONAL (
    Codigo_Inventario VARCHAR(20) NOT NULL,
    Tipo VARCHAR(50) NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Valor_Estimado DECIMAL(10, 2) NULL,
    Estado ENUM('Operativo', 'En Mantenimiento', 'Baja') NOT NULL DEFAULT 'Operativo',
    Fecha_Adquisicion DATE NULL,
    ID_Propietario INT NULL,
    CONSTRAINT pk_equipo_computacional PRIMARY KEY (Codigo_Inventario),
    CONSTRAINT fk_equipo_propietario FOREIGN KEY (ID_Propietario) REFERENCES PROPIETARIO(ID_Propietario) ON DELETE CASCADE ON UPDATE CASCADE
);
SHOW DATABASES;
SELECT DATABASE();
SHOW TABLES;