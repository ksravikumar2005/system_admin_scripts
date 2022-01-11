#!/bin/bash
# Author: Ravikumar K Solaimalai [ ksravikumar2005 at gmail dot com ]
# Date: 01/10/2022
# Description: Script for getting image scan summary across all registries and repsitories for a given AWS Account 
# This script needs aws cli version 2 and necessary permissions to access ECR
# This script comes with no warranties of any kind and you cannot hold me liable for anything that might happen when you use this script. Use it at your own Risk.
##################

for registry_id in $(aws ecr describe-repositories --query 'repositories[*].registryId'  | grep -vE "\[|\]" | cut  -f2 -d\" | uniq)
do
for repository in $(aws ecr describe-repositories --query 'repositories[*].repositoryName'  | grep -vE "\[|\]" | cut  -f2 -d\" | uniq)
do
for image_id in $(aws ecr describe-images --registry-id $registry_id --repository-name test --query 'imageDetails[*].imageDigest' |  grep -vE "\[|\]" | cut -f2 -d\")
do
echo "Checking Registry: $registry_id for Repository: $repository for the image: $image_id"
echo "aws ecr describe-image-scan-findings --registry-id $registry_id --repository-name $repository --image-id imageDigest=$image_id"
aws ecr describe-image-scan-findings --registry-id $registry_id --repository-name $repository --image-id imageDigest=$image_id
echo "================================================================================"
done
done
done
