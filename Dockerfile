ARG PORT=443

FROM cypress/browsers:latest

# Install Python and pip
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Create a virtual environment
RUN python3 -m venv /opt/venv

# Use the virtual environment's pip and python
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip and install dependencies
COPY requirements.txt .
RUN  pip install -r requirements.txt

# Copy the application code
COPY . .

# Run the app with the virtual environment's Python
CMD uvicorn main:app --host 0.0.0.0 --port $PORT