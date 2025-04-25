# Use an official Python runtime as a parent image
FROM python:3.8-slim-buster

# Set environment variables to prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies and Microsoft ODBC Driver 17
RUN apt-get update && \
    apt-get install -y \
    curl \
    gnupg2 \
    unixodbc-dev \
    gcc && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17 && \
    apt-get clean

# Install Python dependencies
RUN pip install --no-cache-dir pyodbc

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Set environment variables for database connection
ENV DB_SERVER=your_db_server
ENV DB_NAME=your_db_name
ENV DB_USERNAME=your_db_username
ENV DB_PASSWORD=your_db_password

# Run your application
CMD ["python", "your_app.py"]

#==========================================================================================#
# FROM python:3.12.6-slim-bookworm

# WORKDIR /app

# # Install necessary packages and update CA certificates
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     build-essential \
#     curl \
#     ca-certificates \
#     gnupg \
#     unixodbc \
#     unixodbc-dev && \
#     rm -rf /var/lib/apt/lists/* && \
#     update-ca-certificates

# # Import Microsoft's GPG key and configure the repository
# RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | \
#     gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg && \
#     echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-prod.gpg] \
#     https://packages.microsoft.com/debian/12/prod bookworm main" > \
#     /etc/apt/sources.list.d/microsoft-prod.list

# # Install the Microsoft ODBC Driver 18 for SQL Server
# RUN apt-get update && \
#     ACCEPT_EULA=Y apt-get install -y msodbcsql18 && \
#     rm -rf /var/lib/apt/lists/*

# # Copy requirements and install Python dependencies
# COPY requirements.txt .
# RUN pip install --upgrade pip && \
#     pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org -r requirements.txt

# # Copy application code
# COPY . .

# ENV PYTHONPATH="/app/src"

# # Default command
# CMD ["pytest"]


#=========================================================================================#
# FROM python:3.12.6-slim-bookworm

# # Set working directory
# WORKDIR /app


# # Install necessary packages
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     build-essential \
#     curl \
#     ca-certificates && \
#     rm -rf /var/lib/apt/lists/*

# # Copy requirements.txt
# COPY requirements.txt .

# # Install Python dependencies with trusted hosts
# RUN pip install --upgrade pip && \
#     pip install --trusted-host pypi.org \
#                 --trusted-host pypi.python.org \
#                 --trusted-host files.pythonhosted.org \
#                 -r requirements.txt

# # Copy the rest of your application code
# COPY . .

# ENV PYTHONPATH="/app/src"

# # Run tests
# CMD ["pytest"]&#8203;:contentReference[oaicite:4]{index=4}
