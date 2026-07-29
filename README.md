<table style="width: 100%; border: none; border-collapse: collapse; background-color: transparent;">
  <tr style="border: none; background-color: transparent;">
    <td style="width: 120px; border: none; padding: 10px; vertical-align: middle; background-color: transparent;">
      <img src="logo-puce-manabi.png" alt="Logo PUCE Manabi" style="width: 100px; height: auto;" />
    </td>
    <td style="border: none; padding: 10px; vertical-align: middle; line-height: 1.5; background-color: transparent;">
      <h2 style="margin: 0; color: #1e3a8a; font-family: Arial, sans-serif; font-weight: bold;">
        Pontificia Universidad Católica del Ecuador Sede Manabí
      </h2>
      <h3 style="margin: 5px 0 0 0; color: #475569; font-family: Arial, sans-serif; font-weight: normal;">
        Carrera de Ingeniería de Software
      </h3>
    </td>
  </tr>
</table>

---

# Actividad Práctica: SQL Joins y Consultas Multi-tabla (INFOTECH)

* **Asignatura:** Bases de Datos
* **Docente:** Ing. José Naranjo, M.Eng.
* **Período:** 2026-1 | Parcial 3

Esta actividad práctica tiene como objetivo principal comprender y aplicar los diferentes tipos de uniones de tablas (Joins) en SQL para realizar consultas multi-tabla complejas sobre la base de datos `INFOTECH`.

---

## Objetivo de la Actividad

El estudiante deberá comprender la teoría y aplicar de forma práctica los conceptos de combinaciones en SQL (`INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, etc.). Para ello, trabajará de manera interactiva ejecutando y completando un cuaderno de Jupyter Notebook.

---

## Estructura y Desarrollo de la Actividad

La práctica consta de los siguientes componentes y pasos a seguir por el estudiante:

### 1. Inicialización de la Base de Datos
El entorno cuenta con el script `db_utils.py` que se encarga de crear y poblar la base de datos `INFOTECH` en MySQL automáticamente al iniciar el cuaderno. Para esto se utilizan los archivos:
* **`Creacion_infotech.sql`**: Define la estructura de tablas y relaciones de la empresa *TechSolutions*.
* **`Poblacion_infotech.sql`**: Inserta datos iniciales de prueba para realizar las consultas.

### 2. Ejecución y Resolución del Cuaderno de Trabajo
Los estudiantes trabajarán **únicamente** en el cuaderno interactivo de desarrollo:
* **[SQL_Infotech_Join.ipynb](./SQL_Infotech_Join.ipynb)**: Cuaderno para el estudiante. Contiene la explicación teórica, ejemplos prácticos autoejecutables y secciones con **Desafíos de Aprendizaje** vacíos.
  
**Tarea del estudiante:**
1. Abrir el cuaderno `SQL_Infotech_Join.ipynb` en su entorno Jupyter.
2. Ejecutar la celda de inicialización de base de datos.
3. Leer los conceptos teóricos y ejecutar las consultas de ejemplo para ver su funcionamiento en tiempo real.
4. Resolver individualmente los **Desafíos de Aprendizaje** de cada sección, escribiendo y ejecutando la consulta SQL correspondiente bajo la celda indicada con `-- ESCRIBA SU CONSULTA AQUÍ`.

---

## Contenido del Repositorio

* **`SQL_Infotech_Join.ipynb`**: Cuaderno de trabajo interactivo para el estudiante (con desafíos por resolver).
* **`db_utils.py`**: Módulo auxiliar de Python para automatizar la conexión a la base de datos y la visualización de resultados.
* **`Creacion_infotech.sql`**: Script SQL para la creación del esquema y las tablas de `INFOTECH`.
* **`Poblacion_infotech.sql`**: Script SQL para poblar la base de datos con los registros de prueba.
* **`logo-puce-manabi.png`**: Imagen del logotipo de la universidad utilizado en el encabezado de los cuadernos.

