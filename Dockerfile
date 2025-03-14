ARG PORT=443

FROM cypress/browsers:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    build-essential \          # For C/C++ compiler
    python3-dev \              # Python development headers
    libssl-dev \               # SSL/TLS support
    libffi-dev                 # For cryptography

# Create and activate virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip and install wheel (for binary packages)
RUN pip install --upgrade pip setuptools wheel

# Install requirements
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy app code
COPY . .

CMD uvicorn main:app --host 0.0.0.0 --port $PORT