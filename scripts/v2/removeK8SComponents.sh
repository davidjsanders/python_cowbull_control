function removeK8Scomponents {
    if (( $EXEAZURE==1 ))
    then
        vendor_path=vendor/Azure
    elif (( $EXEGOOGLE==1 ))
    then
        vendor_path=vendor/Google
    else
        vendor_path=vendor/minikube
    fi

    if (( $MONGODB==0 ))
    then
        persister="redis"
        persister_script=scripts/redis-
    else
        persister="mongodb"
        persister_script=scripts/mongo-
    fi

    if (( $DRYRUN == 0 ))
    then
        echo ""
        echo "Remove services"
        echo "---------------"

        echo -n "Deleting configmap:  "
        kubectl delete configmap cowbull-config --ignore-not-found
        echo

        if (( $MONGODB==1 ))
        then
            echo -n "Deleting mongo persistent storage:  "
            kubectl delete -f $vendor_path/mongo-storage.yml --ignore-not-found
            echo
        fi

        echo -n "Deleting "$persister" service:  "
        kubectl delete -f $persister_script"service.yml" --ignore-not-found
        echo

        echo -n "Deleting "$persister" deployment:  "
        kubectl delete -f "$persister_script"deploy.yml --ignore-not-found
        echo

        echo -n "Deleting cowbull deployment:  "
        kubectl delete \
            -f "scripts/cowbull-deploy.yml" \
            --ignore-not-found
        echo

        echo -n "Deleting cowbull service:  "
        kubectl delete \
            -f "scripts/cowbull-service.yml" \
            --ignore-not-found
        echo

        echo -n "Deleting webapp deployment:  "
        kubectl delete \
            -f "scripts/webapp-deploy.yml" \
            --ignore-not-found
        echo

        echo -n "Deleting webapp service:  "
        kubectl delete svc webapp-ingress --ignore-not-found
        echo

        echo -n "Deleting webapp ingress: "
        kubectl delete -f scripts/ingress.yml
    else
        echo ""
        echo "Dry run - remove services"
        echo "-------------------------"
        echo "kubectl delete configmap cowbull-config --ignore-not-found"
        if (( $MONGODB==1 ))
        then
            echo "kubectl delete -f "$vendor_path"/mongo-storage.yml --ignore-not-found"
        fi
        echo "kubectl delete -f "$persister"-service.yml --ignore-not-found"
        echo "kubectl delete -f "$persister"-deploy.yml --ignore-not-found"
        echo "kubectl delete -f cowbull-deploy.yml --ignore-not-found"
        echo "kubectl delete -f cowbull-service.yml --ignore-not-found"
        echo "kubectl delete -f webapp-deploy.yml --ignore-not-found"
        echo "kubectl delete -f webapp-service.yml --ignore-not-found"
        echo "kubectl delete svc webapp --ignore-not-found"
    fi
}

