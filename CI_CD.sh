#!/bin/bash
# This script is used to deploy the application on the server

# Stop the script if any command fails
set -e

# Variables
APP_NAME="FlaskApp"
DOCKER_IMAGE_NAME="flaskapp-image"
DOCKER_CONTAINER_NAME="flaskapp"
DEV_BRANCH="dev"
STAGING_BRANCH="staging"
export PYTHONPATH=$(pwd)

# Get the code from the repository and checkout to dev branch
git clone git@github.com:devops-ecole89/Killian_DevOps.git $APP_NAME
git checkout $DEV_BRANCH

# Execute the tests
echo "Execute the tests..."
pytest tests/
TEST_STATUS=$?

# Push the code to the staging branch
if [ $TEST_STATUS -eq 0 ]; then
    echo "Tests passed successfully"
    git checkout $STAGING_BRANCH
    git merge $DEV_BRANCH
    git push origin $STAGING_BRANCH
    rm -rf $APP_NAME
    exit 0
else
    echo "Tests failed"
    rm -rf $APP_NAME
    exit 1
fi

