ARG PORT=443

FROM cypress/browsers:latest

# Combined package management in single RUN layer
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Set correct Python user install path
ENV PATH /root/.local/bin:${PATH}

COPY requirements.txt .

# Install Python dependencies with explicit pip3
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

CMD uvicorn main:app --host 0.0.0.0 --port $PORT