# Find the individual readme files within the directories

## Deployments

* Run ecr.sh file to push the docker image to the ECR repo
* terraform init
* terraform apply


## Improvements

* Ideally, I would have set up a Jenkins job and configure the Jenkinsfile to include build and deployment stages.

*Build Stage*

```

sh ecr.sh

```

*Deploy Stage*

```

Get all the task definitions

aws ecs describe-task-definition — task-definition ${task-definition-name} — region=${aws-region}"

Update the task definition with the new image

echo ${TASK_DEFINITION} | jq ‘.containerDefinitions[0].image=’\”${NEW_ECR_IMAGE }\” \ > <task-defintion file>

Register the task definition

aws ecs register-task-definition — family ${task-definition-name} — region=${aws-region} — cli-input-json <task-definition file path>

Update the AWS Service with the new task definition which would automatically trigger a rolling deployment

aws ecs update-service --service <service-name> --task-definition <new-task-defintion>

```


 







