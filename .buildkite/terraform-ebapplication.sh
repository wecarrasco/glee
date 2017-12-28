#!/bin/bash

set -eo pipefail
echo "--- Init Terraform Backend"
export TF_VAR_APPNAME=$APPNAME
cd terraform/aws/elasticbeanstalk/application
terraform init -input=false
echo "--- Create Workspace for $ENVIRONMENT"
chmod +x ../../../../.buildkite/terraform-create-workspace.sh
../../../../.buildkite/terraform-create-workspace.sh
echo "--- Select Workspace for $ENVIRONMENT"
terraform workspace select $ENVIRONMENT
echo "--- Plan for $ENVIRONMENT"
terraform plan -out=tfplan -input=false
echo "--- Apply for $ENVIRONMENT"
terraform apply -input=false tfplan