# 1. Base image
FROM python:3.10-slim

# 2. Set working directory
WORKDIR /app

# 3. Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# 4. Copy dependency list first to use Docker layer caching
COPY requirements.txt .

# 5. Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy the entire Django project
COPY . .

# 7. Expose Django's default port (optional)
EXPOSE 8000

# 8. Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
