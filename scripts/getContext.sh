function getContext {
    echo "" >&2
    if (( $EXEAZURE==1 ))
    then
        echo "Fetching kubectl credentials from Azure" >&2
        if (( $DRYRUN==0 ))
        then
            az aks get-credentials --resource-group $GROUP --name $CLUSTER
        else
            echo "az aks get-credentials --resource-group $GROUP --name $CLUSTER ...dry run" >&2
        fi
    elif (( $EXEGOOGLE==1 ))
    then
        echo "Fetching kubectl credentials from GKE" >&2
        if (( $DRYRUN==0 ))
        then
            gcloud container clusters get-credentials $CLUSTER --zone $LOCATION
        else
            echo "gcloud container clusters get-credentials $CLUSTER --zone $LOCATION ...dry run" >&2
        fi
    elif (( $EXEMINIKUBE==1 ))
    then
        echo "Fetching kubectl credentials from minikube" >&2
        if (( $DRYRUN==0 ))
        then
            kubectl config use-context minikube
        else
            echo "kubectl config use-context minikube ...dry run" >&2
        fi
    else
        echo "Please specify one of the deployment targets, e.g. --google or --azure" >&2
    fi
    echo "" >&2
    echo "Done" >&2
}
