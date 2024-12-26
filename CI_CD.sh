#!/bin/bash
# CI/CD Script for Flask Application Deployment

set -e

# Variables
APP_NAME="FlaskApp"
REPO="git@github.com:devops-ecole89/Killian_FlaskApp.git"
DEV_BRANCH="dev"
STAGING_BRANCH="staging"
COMPOSE_FILE="docker-compose.yml"
TEST_SERVICE="flask"
LOG_DIR="logs"
LOG_FILE="$LOG_DIR/ci_cd_$(date +'%Y%d%m_%H%M%S').log"

# Functions
setup_logs() {
    mkdir -p "$LOG_DIR"
    echo "Starting CI/CD pipeline..." | tee -a "$LOG_FILE"
}

clone_or_pull_repo() {
    if [ -d "$APP_NAME" ]; then
        echo "Repository already exists. Pulling latest changes..." | tee -a "$LOG_FILE"
        cd "$APP_NAME"
        git pull origin "$DEV_BRANCH"
    else
        echo "Cloning the repository..." | tee -a "$LOG_FILE"
        git clone "$REPO" "$APP_NAME"
        cd "$APP_NAME"
        git checkout "$DEV_BRANCH"
    fi
}

run_tests() {
    echo "Running tests with Docker Compose..." | tee -a "../$LOG_FILE"
    sudo docker compose up --build -d "$TEST_SERVICE"
    sudo docker compose run "$TEST_SERVICE" pytest
    if [ $? -ne 0 ]; then
        echo "Tests failed. Exiting pipeline." | tee -a "../$LOG_FILE"
        sudo docker compose down
        exit 1
    fi
}

merge_branches() {
    echo "Merging $DEV_BRANCH into $STAGING_BRANCH..." | tee -a "../$LOG_FILE"
    git checkout "$STAGING_BRANCH"
    git merge "$DEV_BRANCH"
    git push origin "$STAGING_BRANCH"
}

cleanup() {
    cd ..
    echo "Cleaning up workspace..." | tee -a "$LOG_FILE"
    rm -rf "$APP_NAME"
}

# Main execution
setup_logs
clone_or_pull_repo
run_tests
merge_branches
cleanup

echo "Pipeline completed successfully." | tee -a "$LOG_FILE"
exit 0
