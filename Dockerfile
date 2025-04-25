FROM python:3.12.6-slim-bookworm

# Set environment variables to accept the EULA and disable interactive prompts
ENV ACCEPT_EULA=Y
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    ca-certificates \
    unixodbc \
    unixodbc-dev \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Add Microsoft's GPG key and repository for ODBC Driver 17
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update

# Install ODBC Driver 17 for SQL Server
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17 && \
    rm -rf /var/lib/apt/lists/*

# Install pyodbc
RUN pip install --no-cache-dir pyodbc

# Copy application code and install Python dependencies
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

# Set the default command to run tests
CMD ["pytest"]
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
