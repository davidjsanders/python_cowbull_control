function removeK8Scomponents {
    if (( $DRYRUN == 0 ))
    then
        echo ""
        echo "Dry run - remove services"
        echo "-------------------------"

        echo -n "Deleting configmap:  "
        kubectl delete configmap cowbull-config --ignore-not-found
        echo

        echo -n "Deleting redis deployment:  "
        kubectl delete \
            -f "scripts/redis-deploy.yml" \
            --ignore-not-found
        echo

        echo -n "Deleting redis service:  "
        kubectl delete \
            -f "scripts/redis-service.yml" \
            --ignore-not-found
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
        kubectl delete svc webapp --ignore-not-found
        echo
    else
        echo ""
        echo "Dry run - remove services"
        echo "-------------------------"
        echo "kubectl delete configmap cowbull-config --ignore-not-found"
        echo "kubectl delete -f redis-deploy.yml --ignore-not-found"
        echo "kubectl delete -f redis-service.yml --ignore-not-found"
        echo "kubectl delete -f cowbull-deploy.yml --ignore-not-found"
        echo "kubectl delete -f cowbull-service.yml --ignore-not-found"
        echo "kubectl delete -f webapp-deploy.yml --ignore-not-found"
        echo "kubectl delete -f webapp-service.yml --ignore-not-found"
        echo "kubectl delete svc webapp --ignore-not-found"
    fi
}

