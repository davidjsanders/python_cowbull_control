function deployK8Scomponents {
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
        echo "Creating services"
        echo "-----------------"

        echo "Creating configmap:  "
        kubectl create configmap cowbull-config \
          --from-file=cowbull.cfg
        echo

        if (( $MONGODB==1 ))
        then
            echo -n "Creating mongodb persistent storage:  "
            kubectl create -f $vendor_path/mongo-storage.yml
            echo
        fi

        echo -n "Creating "$persister" service:  "
        kubectl create -f $persister_script"service.yml"
        echo

        echo -n "Creating "$persister" deployment:  "
        kubectl create -f "$persister_script"deploy.yml
        echo

        echo -n "Creating cowbull service:  "
        kubectl create -f scripts/cowbull-service.yml
        echo

        echo -n "Creating cowbull deployment:  "
        kubectl create -f scripts/cowbull-deploy.yml
        echo

        echo -n "Creating webapp deployment:  "
        kubectl create -f scripts/webapp-deploy.yml
        echo
    else
        echo ""
        echo "Dry run - Create services"
        echo "-------------------------"
        echo "kubectl create configmap cowbull-config --from-file=cowbull.cfg"
        if (( $MONGODB==1 ))
        then
            echo "kubectl create -f "$vendor_path"/mongo-storage.yml"
        fi
        echo "kubectl create -f "$persister"-service.yml"
        echo "kubectl create -f "$persister"-deploy.yml"
        echo "kubectl create -f cowbull-service.yml"
        echo "kubectl create -f cowbull-deploy.yml"
        echo "kubectl create -f webapp-deploy.yml"
    fi
}

