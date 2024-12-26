# CI/CD Repository for Flask Application

This repository contains all the necessary files to automate the Continuous Integration (CI) and Continuous Deployment (CD) 
pipeline for the Flask application. It is designed to ensure efficient testing, building, and deployment processes using Docker 
and Docker Compose.

---

## Contents
### 1. Files
- `CI_CD.sh`: A Bash script that automates the following tasks:
    - Pulls the latest code from the `dev` branch.
    - Builds and tests the application using Docker Compose.
    - Merges the `dev` branch into the `staging` branch if the tests pass.
    - Cleans up temporary files and containers after execution.
- `Dockerfile`: Defines a Docker image for the Flask application, including dependencies and setup for testing or deployment.
- `docker-compose.yaml`: Orchestrates the Flask application in a containerized environment. It is used for building, running, and testing the application.

## Usage
### 1. Prerequisites

Ensure the following tools are installed on your system:
- Docker
- Docker Compose
- Bash (for running the `CI_CD.sh` script)

### 2. Running the CI/CD Pipeline
__Step 1: Clone the repository__
```shell
    git clone <repository-url>
    cd <repository-name>
```


__Step 2: Execute the script__

Run the `CI_CD.sh` script to initiate the CI/CD pipeline:
```shell
    chmod +x CI_CD.sh
    ./CI_CD.sh
```

__Step 3: Check logs__

Logs are stored in the `logs` directory with a timestamped filename (e.g., `ci_cd_20242512_155613.log`). Check the logs for details:
```shell
    cat logs/ci_cd_<timestamp>.log
```

### 3. File Descriptions
__CI_CD.sh__

Automates the CI/CD pipeline for the Flask application.

Tasks include:
- Cloning or updating the Flask application from the dev branch.
- Building and running tests in a Docker Compose environment.
- Merging the dev branch into staging if tests pass.
- Cleaning up temporary files and stopping containers.


__Dockerfile__

Builds a Docker image for the Flask application.

Key features:
- Installs Python and system dependencies.
- Installs the Python packages listed in requirements.txt.
- Configures the container for testing or running the application.

__docker-compose.yaml__

Automates the deployment and testing of the Flask application in a containerized environment.
Key features:
- Builds the Docker image defined in the Dockerfile.
- Exposes the application on port 5000.
- Runs tests if configured.

__CI/CD Pipeline Workflow__

Clone or Update Code:

    The repository is cloned or updated from the dev branch.
Run Tests:

    The Flask application is built and tested using Docker Compose.
Merge Branches:

    If the tests pass, the dev branch is merged into staging.
Clean Up:

    Temporary files and containers are removed to maintain a clean environment.

__Repository Structure__
```shell
    /
    ├── CI_CD.sh               # CI/CD automation script
    ├── Dockerfile             # Defines the Docker image
    ├── docker-compose.yaml    # Orchestrates Docker containers
    ├── logs/                  # Directory for storing logs
    └── README.md              # Documentation file
```

### Notes
Ensure the Flask application repository includes a requirements.txt file and functional test cases (pytest recommended).
This repository is manually executed for now; automation with GitHub Actions is planned in later steps.

### Contributors
Killian: Developer and maintainer of the repository.