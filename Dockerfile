FROM python:3.10-slim

# Install the necessary system dependencies
RUN apt-get update && apt-get install -y git build-essential libssl-dev libffi-dev --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Define the working directory
WORKDIR /home/python/app

# Clone the Git repository and checkout the dev branch
RUN git clone https://github.com/devops-ecole89/Killian_FlaskApp.git
WORKDIR /home/python/app/Killian_FlaskApp
RUN git checkout dev

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Define the PYTHONPATH environment variable to include the code directory
ENV PYTHONPATH=/home/python/app/Killian_FlaskApp

# Expose the port (optional)
EXPOSE 5000

# Exécuter l'application
CMD ["python", "main.py"]