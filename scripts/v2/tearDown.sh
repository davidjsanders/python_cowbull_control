function tearDown {
    echo ""
    echo "Tearing down Python CowBull game infrastructure"
    echo "==============================================="
    echo ""

    echo >&2
    echo "Stop and remove configuration maps, pods, and services" >&2
    echo >&2

    source scripts/v2/removeK8SComponents.sh

    echo >&2
    echo "Sleep for 30 seconds to give pods time to clear." >&2
    echo >&2
    sleep 30

    echo >&2
    echo "Tear down infrastructure" >&2
    echo >&2

    if [[ $EXEAZURE == 1  ]];
    then
        source vendor/Azure/spindown-cluster
        if [ $? != 0  ]; then exit 1; fi
    fi

    if [[ $EXEGOOGLE == 1 ]];
    then
        source vendor/Google/spindown-cluster
        if [ $? != 0  ]; then exit 1; fi
    fi

    if [[ $EXEMINIKUBE == 1 ]];
    then
        source vendor/minikube/spindown-cluster
        if [ $? != 0  ]; then exit 1; fi
    fi

    echo >&2
    echo "-------------------------------------------------------------------------" >&2
    echo "Cluster torn down." >&2
    echo "-------------------------------------------------------------------------" >&2
    echo >&2
}
