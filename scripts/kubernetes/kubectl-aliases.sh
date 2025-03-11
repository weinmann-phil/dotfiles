# GENERAL
complete -o default -F __start_kubectl k

# Kubernetes Aliases
alias k='kubectl'
alias knsg='kubectl get namespaces'
alias kcrd='kubectl get customresourcedefinition'

function get_nodes_overview {
  kubectl get nodes
  kubectl get pods -A \
    -o jsonpath='{range .items[?(@.spec.nodeName)]}{.spec.nodeName}{"\n"}{end}' | sort | uniq -c | awk 'BEGIN {print "NAME\t\t\t\t\tCOUNT"} {print $2 "\t" $1}'
}

alias kN=get_nodes_overview

function get_context_information {
  echo "Current context: "
  echo "    $(kubectl config current-context)"
  echo ""
  echo "----------------------------------------"
  echo "Available contexts:"
  kubectl config get-contexts
}

alias kctx=get_context_information

#################################################
# Function to search and set kubernetes namespace
#
# This function takes a string, searches for the
# best match within the namespaces and sets the
# matching namespace as work environment.
#
# Args:
#   NAME: A string representing a namespace or
#     part of it.
#################################################
function define_kubernetes_namespace {
  local NAME="${1:=default}"

  NAMESPACE=$(kubectl get namespaces -o name | grep -i $NAME | cut -d '/' -f 2)
  #export NAMESPACE=$NAMESPACE
  echo $NAMESPACE
}

alias ksn=define_kubernetes_namespace

function get_kubernetes_pods {
  local NAMESPACE=$1
  local NAME=$2

  if [[ -z "$NAMESPACE" ]]; then
    kubectl get pods -A 
  elif [[ -z "$NAME" ]]; then
    kubectl get pods -n $NAMESPACE
  else
    kubectl get pods -n $NAMESPACE | grep -i $NAME
  fi
}

function get_kubernetes_deployment {
  local NAMESPACE=$1
  local NAME=$2

  if [[ -z "$NAMESPACE" ]]; then
    kubectl get deployment -A
  elif [[ -z "$NAME" ]]; then
    kubectl get deployment -n $NAMESPACE
  else
    kubectl get deployment -n $NAMESPACE | grep -i $NAME
  fi
}

function get_stateful_sets {
  local NAMESPACE=$1
  local NAME=$2

  if [[ -z "$NAMESPACE" ]]; then
    kubectl get sts -A
  elif [[ -z "$NAME" ]]; then
    kubectl get sts -n $NAMESPACE
  else
    kubectl get sts -n $NAMESPACE | grep -i $NAME
  fi
}

function get_kubernetes_services {
  local NAMESPACE
  local NAME

  if [[ -z "$NAMESPACE" ]]; then
    kubectl get service -A
  elif [[ -z "$NAME" ]]; then
    kubectl get service -n $NAMESPACE
  else
    kubectl get service -n $NAMESPACE | grep -i $NAME
  fi
}

alias kpog=get_kubernetes_pods
alias kdplg=get_kubernetes_deployment
alias kstsg=get_stateful_sets
alias ksvcg=get_kubernetes_services


function get_pods_within_namespace {
  local NAME=$1
  local NAMESPACE="${2:=default}"
  local OUTPUT="${3:=-a}"

  if [[ -z $NAME && "$OUTPUT" == "-a" ]]; then
    kubectl get pods -n $NAMESPACE
  elif [[ -n $NAME && "$OUTPUT" == "-a" ]]; then
    kubectl get pod -n $NAMESPACE | grep -i $NAME
  elif [[ -z $NAME && "$OUTPUT" == "-n" ]]; then
    kubectl get pods -n $NAMESPACE -o name | cut -d '/' -f 2
  else
    kubectl get pods -n $NAMESPACE -o name | grep -i $NAME | cut -d '/' -f 2 
  fi
}

alias kpA=get_pods_within_namespace


