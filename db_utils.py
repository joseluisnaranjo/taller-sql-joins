# -*- coding: utf-8 -*-
"""
Módulo de Utilidades de Base de Datos para MySQL en Jupyter Notebooks.
Proporciona funciones para conexión interactiva, ejecución de scripts .sql,
ejecución de consultas SQL y formateo de resultados como DataFrames de Pandas.
"""

import getpass
import re
import os
import sys

# Intentar importar controladores de MySQL
DRIVER = None
try:
    import mysql.connector
    from mysql.connector import Error as DBError
    DRIVER = 'mysql.connector'
except ImportError:
    try:
        import pymysql
        DRIVER = 'pymysql'
        DBError = pymysql.MySQLError
    except ImportError:
        DRIVER = None

# Variable de conexión global
_connection = None

def connect_db():
    """
    Establece una conexión interactiva a la base de datos MySQL,
    solicitando credenciales al usuario de forma segura.
    """
    global _connection
    
    if DRIVER is None:
        print("ERROR: No se encontró ningún controlador de MySQL instalado.")
        print("Por favor instale mysql-connector-python o pymysql en una celda de Jupyter ejecutando:")
        print("!pip install mysql-connector-python pymysql pandas")
        return None
        
    print("--- CONEXIÓN A BASE DE DATOS MYSQL ---")
    host = input("Host de MySQL [localhost]: ").strip() or "localhost"
    port_in = input("Puerto de MySQL [3306]: ").strip() or "3306"
    try:
        port = int(port_in)
    except ValueError:
        print("Puerto inválido, usando 3306.")
        port = 3306
        
    user = input("Usuario de MySQL [root]: ").strip() or "root"
    password = getpass.getpass("Contraseña de MySQL: ")
    
    try:
        if DRIVER == 'mysql.connector':
            conn = mysql.connector.connect(
                host=host,
                port=port,
                user=user,
                password=password,
                autocommit=True
            )
        else: # pymysql
            conn = pymysql.connect(
                host=host,
                port=port,
                user=user,
                password=password,
                autocommit=True
            )
            
        print("¡Conexión al servidor MySQL establecida con éxito!")
        
        # Intentar seleccionar la base de datos INFOTECH si ya existe
        try:
            if DRIVER == 'mysql.connector':
                conn.database = 'INFOTECH'
            else:
                conn.select_db('INFOTECH')
            print("Connected to database 'INFOTECH'.")
        except Exception:
            print("Nota: La base de datos 'INFOTECH' no existe o no está seleccionada. Puedes crearla en el siguiente paso.")
            
        _connection = conn
        return conn
    except Exception as e:
        print(f"Error al conectar a MySQL: {e}")
        return None

def set_global_connection(conn):
    """Establece la conexión global manualmente."""
    global _connection
    _connection = conn

def get_global_connection():
    """Retorna la conexión global."""
    return _connection

def split_sql_statements(sql_text):
    """
    Separa un script SQL largo en sentencias individuales respetando
    comentarios, comillas y secuencias de escape.
    """
    # Eliminar comentarios de bloque /* ... */
    sql_text = re.sub(r'/\*.*?\*/', '', sql_text, flags=re.DOTALL)
    # Eliminar comentarios de línea que empiezan con --
    sql_text = re.sub(r'--.*$', '', sql_text, flags=re.MULTILINE)
    
    statements = []
    current_stmt = []
    in_single_quote = False
    in_double_quote = False
    escape = False
    
    for char in sql_text:
        if escape:
            current_stmt.append(char)
            escape = False
            continue
            
        if char == '\\':
            current_stmt.append(char)
            escape = True
            continue
            
        if char == "'" and not in_double_quote:
            in_single_quote = not in_single_quote
        elif char == '"' and not in_single_quote:
            in_double_quote = not in_double_quote
            
        if char == ';' and not in_single_quote and not in_double_quote:
            stmt_str = "".join(current_stmt).strip()
            if stmt_str:
                statements.append(stmt_str)
            current_stmt = []
        else:
            current_stmt.append(char)
            
    stmt_str = "".join(current_stmt).strip()
    if stmt_str:
        statements.append(stmt_str)
        
    return statements

def execute_sql_file(connection, file_path):
    """
    Lee y ejecuta un archivo .sql sentencia por sentencia usando la conexión dada.
    """
    if not os.path.exists(file_path):
        print(f"Error: El archivo '{file_path}' no existe en el directorio actual.")
        return False
        
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            sql_content = f.read()
    except UnicodeDecodeError:
        with open(file_path, 'r', encoding='latin-1') as f:
            sql_content = f.read()
            
    statements = split_sql_statements(sql_content)
    
    cursor = connection.cursor()
    success_count = 0
    error_count = 0
    
    for stmt in statements:
        if not stmt:
            continue
        try:
            # Monitorear si hay un USE para cambiar la base de datos activa
            if stmt.upper().startswith("USE "):
                db_name = stmt.split()[1].rstrip(';').replace('`', '').strip()
                try:
                    connection.select_db(db_name)
                except AttributeError:
                    connection.database = db_name
            
            cursor.execute(stmt)
            success_count += 1
        except Exception as e:
            # Mostrar solo los primeros 120 caracteres del error para no saturar la salida
            print(f"Error en sentencia: {stmt[:120]}...\nDetalle: {e}\n")
            error_count += 1
            
    cursor.close()
    if error_count == 0:
        print(f"Base de datos configurada exitosamente con {os.path.basename(file_path)}.")
    else:
        print(f"Script {os.path.basename(file_path)} ejecutado con {error_count} errores.")
    return error_count == 0

def run_query(query, connection=None):
    """
    Ejecuta una consulta SQL o múltiples consultas secuenciales en la conexión activa.
    Retorna un DataFrame de Pandas para el último SELECT ejecutado, o formatea en texto si Pandas no está.
    """
    if connection is None:
        connection = _connection
        
    if connection is None:
        print("Error: No hay una conexión activa a la base de datos. Ejecuta la celda de conexión primero.")
        return None
        
    query = query.strip()
    if not query:
        return None
        
    statements = split_sql_statements(query)
    if not statements:
        return None
        
    cursor = connection.cursor()
    last_df = None
    
    try:
        for stmt in statements:
            stmt = stmt.strip()
            if not stmt:
                continue
                
            # Detectar y procesar sentencia USE para cambiar de base de datos activa
            if stmt.upper().startswith("USE "):
                db_name = stmt.split()[1].rstrip(';').replace('`', '').strip()
                try:
                    connection.select_db(db_name)
                except AttributeError:
                    connection.database = db_name
            
            is_select = stmt.upper().lstrip().startswith(('SELECT', 'SHOW', 'DESCRIBE', 'EXPLAIN', 'WITH'))
            
            if is_select:
                try:
                    import pandas as pd
                    import warnings
                    # pd.read_sql_query ejecutará la consulta en un cursor interno y retornará el DataFrame
                    with warnings.catch_warnings():
                        warnings.simplefilter("ignore", UserWarning)
                        last_df = pd.read_sql_query(stmt, connection)
                except ImportError:
                    cursor.execute(stmt)
                    columns = [col[0] for col in cursor.description]
                    rows = cursor.fetchall()
                    
                    if not rows:
                        print("(Resultado vacío)")
                    else:
                        widths = [len(col) for col in columns]
                        for row in rows:
                            for idx, val in enumerate(row):
                                val_str = str(val) if val is not None else 'NULL'
                                widths[idx] = max(widths[idx], len(val_str))
                                
                        header_line = " | ".join(col.ljust(widths[i]) for i, col in enumerate(columns))
                        separator_line = "-+-".join("-" * widths[i] for i in range(len(columns)))
                        print(header_line)
                        print(separator_line)
                        
                        for row in rows:
                            row_line = " | ".join((str(val) if val is not None else 'NULL').ljust(widths[i]) for i, val in enumerate(row))
                            print(row_line)
                            
                        print(f"\n({len(rows)} filas devueltas)")
            else:
                cursor.execute(stmt)
                if cursor.rowcount >= 0:
                    print(f"Sentencia ejecutada con éxito. Filas afectadas: {cursor.rowcount}")
                else:
                    print("Sentencia ejecutada con éxito.")
                    
        cursor.close()
        if last_df is not None:
            return last_df
            
    except Exception as e:
        try:
            cursor.close()
        except Exception:
            pass
        print(f"Error al ejecutar consulta:\nDetalle: {e}")
        return None

def setup_database_flow(connection):
    """
    Flujo interactivo para crear y poblar la base de datos INFOTECH.
    """
    if connection is None:
        print("No hay conexión activa. No se puede configurar la base de datos.")
        return
        
    print("\n--- Configuración de la base de datos INFOTECH ---")
    create_db = input("¿Desea crear/restablecer la base de datos 'INFOTECH' usando 'Creacion_infotech.sql'? (s/n): ").strip().lower()
    if create_db == 's':
        execute_sql_file(connection, "Creacion_infotech.sql")
    else:
        print("Se omitió la creación de la base de datos.")
        
    populate_db = input("¿Desea poblar la base de datos con los datos de prueba usando 'Poblacion_infotech.sql'? (s/n): ").strip().lower()
    if populate_db == 's':
        execute_sql_file(connection, "Poblacion_infotech.sql")
    else:
        print("Se omitió la población de datos.")

try:
    from IPython.core.magic import Magics, magics_class, cell_magic
    
    @magics_class
    class SQLMagics(Magics):
        @cell_magic
        def sql(self, line, cell):
            res = run_query(cell)
            if res is not None:
                return res
except ImportError:
    SQLMagics = None

def register_cell_magic_safe():
    """
    Registra el comando mágico %%sql de forma segura en el entorno IPython de Jupyter.
    """
    if SQLMagics is None:
        return
    try:
        from IPython import get_ipython
        ipy = get_ipython()
        if ipy is not None:
            ipy.register_magics(SQLMagics)
            print("Registrado comando mágico %%sql para ejecutar consultas directamente.")
    except Exception as e:
        print(f"Error al registrar el comando mágico %%sql: {e}")

def initialize_database():
    """
    Realiza la conexión a MySQL y el flujo de configuración de manera integrada.
    """
    register_cell_magic_safe()
    conn = connect_db()
    if conn is not None:
        setup_database_flow(conn)

# Registro automático al importar el módulo
register_cell_magic_safe()
