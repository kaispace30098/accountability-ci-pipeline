# syntax=docker/dockerfile:1.4
FROM python:3.12.6-slim-bookworm

WORKDIR /app

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    unixodbc \
    unixodbc-dev \
    gnupg && \
    rm -rf /var/lib/apt/lists/*

# Install ODBC Driver for SQL Server
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/12/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy application code
COPY . .

ENV PYTHONPATH="/app/src"

# Default command
CMD ["pytest"]

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
