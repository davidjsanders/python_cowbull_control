function tearDown {
    echo ""
    echo "Tearing down Python CowBull game infrastructure"
    echo "==============================================="
    echo ""

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