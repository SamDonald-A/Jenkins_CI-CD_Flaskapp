# Stage: build & test
FROM python:3.10-slim AS builder
WORKDIR /app
RUN apt-get update && apt-get install -y gcc
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt
COPY . .
# Tests will be executed by the Jenkins pipeline (we won't run them automatically here)
# Stage: production
FROM python:3.10-slim AS final
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python3", "app.py"]
