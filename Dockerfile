ARG PORT=443

FROM cypress/browsers:latest

# Update package lists and install Python 3 and pip in a single RUN step
RUN apt-get update && apt-get install -y python3 python3-pip

# Verify the installations (optional)
RUN python3 --version && pip3 --version

# Adjust the PATH – note that the root user's home is /root, not /home/root
ENV PATH /root/.local/bin:${PATH}

# Copy requirements and install Python dependencies using pip3
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy the rest of your application code
COPY . .

# Start the app using uvicorn with the given PORT
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "${PORT}"]
