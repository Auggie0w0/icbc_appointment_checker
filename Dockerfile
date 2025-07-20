FROM python:3.9-slim

WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Create a directory for the config file
RUN mkdir -p /config

# Set environment variable for config location
ENV CONFIG_PATH=/config/config.yml

# Run the script with the config file
CMD ["python", "icbc_roadtest_checker.py", "/config/config.yml"] 