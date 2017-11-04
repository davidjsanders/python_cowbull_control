function deployK8Scomponents {
    if (( $DRYRUN == 0 ))
    then
        echo ""
        echo "Creating services"
        echo "-----------------"

        echo "Creating configmap:  "
        kubectl create configmap cowbull-config \
          --from-file=cowbull.cfg
        echo

        echo -n "Creating redis service:  "
        kubectl create -f scripts/redis-service.yml
        echo

        echo -n "Creating redis deployment:  "
        kubectl create -f scripts/redis-deploy.yml
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
        echo "kubectl create -f redis-service.yml"
        echo "kubectl create -f redis-deploy.yml"
        echo "kubectl create -f cowbull-service.yml"
        echo "kubectl create -f cowbull-deploy.yml"
        echo "kubectl create -f webapp-deploy.yml"
    fi
}

