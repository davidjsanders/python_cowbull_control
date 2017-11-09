function tearDownCluster {
    echo ""
    echo "Tearing down Python CowBull game infrastructure"
    echo "==============================================="
    echo ""

    echo >&2
    echo "Tear down infrastructure" >&2
    echo >&2

    if [[ $EXEACS == 1  ]];
    then
        source vendor/Azure/spindown-cluster
        if [ $? != 0  ]; then exit 1; fi
    fi

    if [[ $EXEAZURE == 1  ]];
    then
        source vendor/AKS/spindown-cluster
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
