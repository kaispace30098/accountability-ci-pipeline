FROM python:3.12.6-slim-bookworm

# Install necessary packages and tools for network testing and database connectivity
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    bash \
    inetutils-ping \
    gnupg2 \
    apt-transport-https \
    unixodbc-dev && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for Python
ENV PYTHONDONTWRITEBYTECODE=1
ENV LANG=C.UTF-8

# Set the working directory
WORKDIR /app

# Add Microsoft repository and install ODBC Driver for SQL Server
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17 && \
    apt-get clean

# Copy requirements and install Python dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && \
    pip install --trusted-host pypi.org \
                --trusted-host pypi.python.org \
                --trusted-host files.pythonhosted.org \
                -r requirements.txt

# Copy the application code
COPY . /app/

# Set the Python path for imports
ENV PYTHONPATH="/app/src"

# Set the entrypoint to pytest (optional if you want pytest as default command)
CMD ["pytest"]&#8203;:contentReference[oaicite:4]{index=4}

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
