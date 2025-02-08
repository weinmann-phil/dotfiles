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

  for i in $(seq 1 ${COUNT}); do
    local NAME=$(echo "$CLUSTERS" | jq -r '.['$i-1'].name')
    local RG=$(echo "$CLUSTERS" | jq -r '.['$i-1'].rg')
    echo "Setting up the kube config for cluster $NAME"
    az aks get-credentials --name $NAME --resource-group $RG
  done
}

alias azkg=get_aks_cluster
alias azls='az resource list -o table'
alias azrgl='az group list -o table'

function get_aks_overview {
  local CLUSTERS=$(az aks list --query "[].{name:name,rg:resourceGroup}" -o json)
  local COUNT=$(echo $CLUSTERS | jq '. | length')

  for i in $(seq 1 ${COUNT}); do
    local NAME=$(echo "$CLUSTERS" | jq -r '.['$i-1'].name')
    local RG=$(echo "$CLUSTERS" | jq -r '.['$i-1'].rg')
    az aks show -n $NAME -g $RG -o table
  done
}

alias azks=get_aks_overview

function update_aks_clusters {
  local CLUSTERS=$(az aks list --query "[].{name:name,rg:resourceGroup}" -o json)
  local COUNT=$(echo $CLUSTERS | jq '. | length')

  for i in $(seq 1 ${COUNT}); do
    local NAME=$(echo "$CLUSTERS" | jq -r '.['$i-1'].name')
    local RG=$(echo "$CLUSTERS" | jq -r '.['$i-1'].rg')
    az aks update -n $NAME -g $RG
  done
}

alias azkup=update_aks_clusters

function upgrade_kubernetes_version {
  local CLUSTERS=$(az aks list --query "[].{name:name,rg:resourceGroup}" -o json)
  local COUNT=$(echo $CLUSTERS | jq '. | length')

  for i in $(seq 1 ${COUNT}); do
    local NAME=$(echo $CLUSTERS | jq -r '.['$i-1'].name')
    local RG=$(echo $CLUSTERS | jq -r '.['$i-1'].rg')
    local VERSIONS=$(az aks get-upgrades -n $NAME -g $RG --query "controlPlaneProfile.upgrades[].kubernetesVersion")
    echo "Available upgrades: "
    echo $VERSIONS | jq
    local HIGHEST=$(echo $VERSIONS | jq 'sort_by(split(".")|map(tonumber))' | jq -r '.[-1]')
    echo "Upgrading to version: $HIGHEST"
    az aks upgrade --kubernetes-version $HIGHEST --name $NAME --resource-group $RG --no-wait
  done
}

alias azkU=upgrade_kubernetes_version
