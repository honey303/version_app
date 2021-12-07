#!/bin/bash

# create the ecr repo
aws ecr create-repository --repository-name app/python-version-app 

# log in to ecr 

aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <aws-account-id>.dkr.ecr.<region>.amazonaws.com

# builds the docker image
docker build -t app/python-version-app .

# tag the image appropriately
docker tag app/python-version-app:latest <aws-account-id>.dkr.ecr.<region>.amazonaws.com/app/python-version-app:latest

# push the image to the ecr repo
docker push <aws-account-id>.dkr.ecr.<region>.amazonaws.com/app/python-version-app:latest




