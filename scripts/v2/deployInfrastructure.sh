function deployInfrastructure {
    echo ""
    echo "Deploying Python CowBull game infrastructure"
    echo "============================================"
    echo ""

    if [[ $EXEAZURE"x" == "x" ]]
    then
        echo "ERROR: This script may ONLY be executed using deploy" >&2
        return 1
    fi

    if [[ $EXEAZURE == 1  ]];
    then
        source vendor/Azure/spinup-cluster
        if [ $? != 0  ]; then exit 1; fi
    fi

    if [[ $EXEGOOGLE == 1 ]];
    then
        source vendor/Google/spinup-cluster
        if [ $? != 0  ]; then exit 1; fi
    fi

    if [[ $EXEMINIKUBE == 1 ]];
    then
        source vendor/minikube/spinup-cluster
        if [ $? != 0  ]; then exit 1; fi
    fi

    echo >&2
    echo "-------------------------------------------------------------------------" >&2
    echo "Cluster ready." >&2
    echo "-------------------------------------------------------------------------" >&2
    echo >&2
}