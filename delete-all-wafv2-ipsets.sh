#!/bin/bash

# Deletes all the IPSets under WAFv2 (default region us-east-1)

ipsets=`aws wafv2 list-ip-sets --scope REGIONAL | jq -r '.IPSets[] | [.Name, .Id, .LockToken] | @tsv'`

while IFS= read -r line; do
    name=$(echo $line | awk -F " " '{print $1}')
    id=$(echo $line | awk -F " " '{print $2}')
    locktoken=$(echo $line | awk -F " " '{print $3}')
    aws wafv2 delete-ip-set --name $name --scope REGIONAL --id $id --lock-token $locktoken
done <<< "$ipsets"
