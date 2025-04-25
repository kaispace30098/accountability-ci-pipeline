import os
import pyodbc
import pandas as pd
import numpy as np

def fetch_student_data(fiscalyear):
    server = os.getenv("DB_SERVER", "AACTASTPDDBVM02")
    database = os.getenv("DB_NAME", "AccountabilityArchive")
    username = os.getenv("DB_USERNAME")
    password = os.getenv("DB_PASSWORD")

    if not all([username, password]):
        raise ValueError("Database credentials are not set in environment variables.")

    cnxn_str = (
        f"Driver={{ODBC Driver 17 for SQL Server}};"
        f"Server={server};"
        f"Database={database};"
        f"UID={username};"
        f"PWD={password};"
    )

    sql = f"""
    SELECT Performance
    FROM AccountabilityArchive.static.FinalStaticFile2024
    WHERE SchoolCode = 79445 AND Subject='ELA' AND Fiscalyear={fiscalyear}
    """

    cnxn = pyodbc.connect(cnxn_str)
    df = pd.read_sql_query(sql, cnxn)
    data = np.array(df['Performance'])
    return data

# import pyodbc
# import pandas as pd
# import numpy as np

# def fetch_student_data(fiscalyear):
#     cnxn_str = (
#         "Driver={ODBC Driver 17 for SQL Server};"
#         "Server=AACTASTPDDBVM02;"
#         "Trusted_Connection=yes;"
#     )
#     sql=f"""
#     SELECT Performance
#     FROM AccountabilityArchive.static.FinalStaticFile2024 
#     WHERE SchoolCode = 79445 and Subject='ELA' and Fiscalyear={fiscalyear}
#     """
#     cnxn=pyodbc.connect(cnxn_str)
#     df = pd.read_sql_query(sql, cnxn)
#     data=np.array(df['Performance'])
#     return data