import os
import pyodbc
import pytest

def test_sql_connection():
    # Retrieve database credentials from environment variables
    server = os.getenv('DB_SERVER')
    database = os.getenv('DB_NAME')
    username = os.getenv('DB_USERNAME')
    password = os.getenv('DB_PASSWORD')

    # Ensure all credentials are set
    assert all([server, database, username, password]), "Database credentials are not fully set."

    # Construct the connection string
    connection_string = f"DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server},1433;DATABASE={database};UID={username};PWD={password};Encrypt=no;"

    try:
        # Establish the database connection
        with pyodbc.connect(connection_string, timeout=5) as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT TOP 1 SAISID FROM AccountabilityArchive.static.FinalStaticFile2024")
            result = cursor.fetchone()
            if result:
                print(f"SAISID: {result[0]}")
                assert result[0] == 69967256, "Unexpected result from test query."
            else:
                pytest.fail("No data returned from the query.")
    except Exception as e:
        pytest.fail(f"Database connection failed: {e}")
