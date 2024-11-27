#!/bin/bash
# This script is used to deploy the application on the server

# Stop the script if any command fails
set -e

# Variables
APP_NAME="Killian_FlaskApp"
DOCKER_IMAGE_NAME="flaskapp-image"
DOCKER_CONTAINER_NAME="flaskapp"
DEV_BRANCH="dev"
STAGING_BRANCH="staging"
export PYTHONPATH=$(pwd)

# Get the code from the repository and checkout to dev branch
git clone git@github.com:devops-ecole89/Killian_FlaskApp.git
cd $APP_NAME/
git checkout $DEV_BRANCH


# Build and run the docker container
echo "Build the docker image..."
docker build -t $DOCKER_IMAGE_NAME .
docker run -d -p 5000:5000 --name $DOCKER_CONTAINER_NAME $DOCKER_IMAGE_NAME

# Check if the application is running
echo "Check if the application is running..."
curl -s http://localhost:5000/ | grep -q "<h1>Flask App</h1>"
APP_STATUS=$?

echo "APP_STATUS:"
echo $APP_STATUS

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

