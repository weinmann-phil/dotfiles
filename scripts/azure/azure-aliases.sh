#!/bin/bash
#
# Aliases and functions for Azure CLI commands

alias azlog='az login'
alias azkl='az aks list --query "[].[name,resourceGroup]" -o tsv'

function log_to_azure {
  local SUBSCRIPTION_NAME=$1
  local ACCOUNTS=$(az account list --query "[?contains(name, '$SUBSCRIPTION_NAME')]" -o json)
  local COUNT=$(echo $ACCOUNTS | jq '. | length')
  
  if [ $COUNT != 1 ]; then
    echo "The chosen name either does not uniquely identify a subscription or none at all."
  else
    az account set --subscription $(echo $ACCOUNTS | jq -r '.[].id')
    az account show
  fi
}

alias azsub=log_to_azure


function get_aks_cluster {
  local CLUSTERS=$(az aks list --query "[].{name:name,rg:resourceGroup}" -o json)
  local COUNT=$(echo $CLUSTERS | jq '. | length')

  for i in $(seq 1 $COUNT); do
    echo "Setting up the kube config for cluster $(echo $CLUSTERS | jq '.['$i-1'].name')"
    az aks get-credentials --name $(echo $CLUSTERS | jq '.['$i-1'].name' --resource-group $(echo $CLUSTERS | jq '.['$i-1'].rg')
  done
}

alias azkg=get_aks_cluster
alias azls='az resource list -o table'
alias azrgl='az group list -o table'

