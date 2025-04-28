# Base image with Python 3.12
FROM python:3.12.6-slim-bookworm

WORKDIR /app

# Install system dependencies and ODBC driver for SQL Server
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      curl \
      ca-certificates \
      gnupg \
      unixodbc \
      unixodbc-dev && \
    rm -rf /var/lib/apt/lists/* && \
    update-ca-certificates \
  && curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
     | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg \
  && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-prod.gpg] \
       https://packages.microsoft.com/debian/12/prod bookworm main" \
     > /etc/apt/sources.list.d/microsoft-prod.list \
  && apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18 \
  && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --trusted-host pypi.org \
                --trusted-host pypi.python.org \
                --trusted-host files.pythonhosted.org \
                -r requirements.txt

# Copy application code
COPY . .

# Ensure our application code is importable
ENV PYTHONPATH="/app/src"

# ───────────────────────────────────────────────────────────────────────────────
# Default DB connection settings for **local development**:
#  • Containers use host.docker.internal to reach your machine’s SQL Server :contentReference[oaicite:5]{index=5}
#  • You can override these in CI via `-e` flags.
ENV DB_SERVER=host.docker.internal \
    DB_NAME=YourActualDatabase \
    DB_USERNAME=sa \
    DB_PASSWORD="YourRealPassword"
# ───────────────────────────────────────────────────────────────────────────────

# Run pytest by default
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
