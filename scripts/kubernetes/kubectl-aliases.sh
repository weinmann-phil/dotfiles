# GENERAL
complete -o default -F __start_kubectl k

# Kubernetes Aliases
alias k='kubectl'
alias kns='kubectl get namespaces'

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


