#!/bin/bash

# create the ecr repo
aws ecr create-repository --repository-name poc/sample-python-app 

# log in to ecr 

aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <aws-account-id>.dkr.ecr.<region>.amazonaws.com

# builds the docker image
docker build -t poc/sample-python-app .

# tag the image appropriately
docker tag poc/sample-python-app:latest <aws-account-id>.dkr.ecr.<region>.amazonaws.com/poc/sample-python-app:latest

# push the image to the ecr repo
docker push <aws-account-id>.dkr.ecr.<region>.amazonaws.com/poc/sample-python-app:latest




