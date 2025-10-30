# Use an official lightweight Python image
FROM python:3.10-slim

# Set a working directory
WORKDIR /app

# Copy requirement file first (for caching layer)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose port (matches the one in Jenkinsfile)
EXPOSE 9001

# Set environment variable for Flask
ENV FLASK_APP=app.py
ENV FLASK_RUN_PORT=9001
ENV FLASK_RUN_HOST=0.0.0.0

# Run Flask app
CMD ["flask", "run"]
