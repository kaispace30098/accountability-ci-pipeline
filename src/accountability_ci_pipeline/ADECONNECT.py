from accountability_ci_pipeline.database import fetch_student_data
from accountability_ci_pipeline.calculation import calcuate_average
from accountability_ci_pipeline.source import FiscalYear
import pyodbc
import pandas as pd
fy=FiscalYear
def generate_summary():
    
    data=fetch_student_data(fiscalyear=fy)
    avg = calcuate_average(data)
    return avg