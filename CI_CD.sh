#!/bin/bash
# This script is used to deploy the application on the server

# Stop the script if any command fails
set -e

# Variables
APP_NAME="Killian_FlaskApp"
DEV_BRANCH="dev"
STAGING_BRANCH="staging"
REPO="git@github.com:devops-ecole89/Killian_FlaskApp.git"

function cleanup {
  echo "Cleaning up..."
  cd ..
  rm -rf $APP_NAME
}

# Clone the repository
echo "Cloning the repository..."
git clone $REPO
cd $APP_NAME
git checkout $DEV_BRANCH

# Execute the tests
echo "Execute the tests..."
export PYTHONPATH=$(pwd)
# use venv to install the dependencies
python3 -m venv venv
source venv/bin/activate
pip install --no-cache-dir -r requirements.txt
pytest tests/
TEST_STATUS=$?

# Push the code to the staging branch
if [ $TEST_STATUS -eq 0 ]; then
    echo "Tests passed successfully"
    git checkout $STAGING_BRANCH
    git merge $DEV_BRANCH
    git push origin $STAGING_BRANCH
    cleanup
    exit 0
else
    echo "Tests failed"
    cleanup
    exit 1
fi

