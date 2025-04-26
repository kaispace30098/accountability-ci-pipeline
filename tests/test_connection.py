import os
import pyodbc
import pytest

def test_sql_connection():
    server = os.getenv("DB_SERVER")
    database = os.getenv("DB_NAME")
    username = os.getenv("DB_USERNAME")
    password = os.getenv("DB_PASSWORD")

    assert all([server, database, username, password]), "Database credentials are not fully set."

    connection_string = (
        f"DRIVER={{ODBC Driver 18 for SQL Server}};"
        f"SERVER={server},1433;"
        f"DATABASE={database};"
        f"UID={username};"
        f"PWD={password};"
        "Encrypt=no;"
    )

    try:
        with pyodbc.connect(connection_string, timeout=5) as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT 1")
            result = cursor.fetchone()
            assert result[0] == 1, "Unexpected result from test query."
    except Exception as e:
        pytest.fail(f"Database connection failed: {e}")
