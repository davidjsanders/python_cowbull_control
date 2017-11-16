function showConfig {
    echo "" >&2
    echo "Configuration to be deployed / torn-down" >&2
    echo "----------------------------------------" >&2
    echo >&2
    echo -n "Platforms selected : " >&2
    if (( $EXEAZURE == 1 )) 
    then
        echo "Azure Kubernetes Service (AKS)" >&2
    elif (( $EXEACS == 1 ))
    then
        echo "Azure Container Service (ACS)" >&2
    elif (( $EXEGOOGLE == 1 ))
    then
        echo "Google Container Engine (GKE)" >&2
    elif (( $EXEMINIKUBE == 1 ))
    then
        echo "Minikube" >&2
    fi
    echo >&2

    showConfigAzure$EXEAZURE
    showConfigAcs$EXEACS
    showConfigGoogle$EXEGOOGLE
    showConfigMinikube$EXEMINIKUBE

    echo >&2
    echo "General Parameters" >&2
    echo "------------------" >&2
    echo "SSH Key file                   : "${KEYFILE} >&2

    echo -n "Dry run?                       : " >&2
    if [[ $DRYRUN == 1  ]]; then echo "yes" >&2; else echo "no" >&2; fi

    echo >&2
}

function showConfigAcs0 {
    :
}

function showConfigAzure0 {
    :
}

function showConfigAcs1 {
    echo
    echo "Deploy to Azure Container Services Parameters" >&2
    echo "---------------------------------------------" >&2
    echo "Group name                     : "${GROUP} >&2
    echo "Cluster name                   : "${CLUSTER} >&2
    echo "Resource group location        : "${LOCATION} >&2
    echo "Number of agents               : "${AGENT_COUNT} >&2
    echo "Number of masters              : 1" >&2
    echo "Machine type for agents        : "${MACHINE_TYPE} >&2
    echo "DNS Prefix (Azure only)        : "${DNS_PREFIX} >&2
    echo "PIP Name (Azure only)          : "${PIP_NAME} >&2
}

function showConfigAzure1 {
    echo
    echo "Deploy to Azure Parameters" >&2
    echo "--------------------------" >&2
    echo "Group name                     : "${GROUP} >&2
    echo "Cluster name                   : "${CLUSTER} >&2
    echo "Auto group name                : "${AUTOGROUP} >&2
    echo "Resource group location        : "${LOCATION} >&2
    echo "Number of agents               : "${AGENT_COUNT} >&2
    echo "Machine type for agents        : "${MACHINE_TYPE} >&2
    echo "DNS Prefix (Azure only)        : "${DNS_PREFIX} >&2
    echo "PIP Name (Azure only)          : "${PIP_NAME} >&2
}

function showConfigGoogle0 {
    :
}

function showConfigGoogle1 {
    echo
    echo "Deploy to Google Parameters" >&2
    echo "---------------------------" >&2
    echo "Cluster name                   : "${CLUSTER} >&2
    echo "Google zone (location)         : "${LOCATION} >&2
    echo "Agent disk size                : "${DISK_SIZE} >&2
    echo "Number of agents               : "${AGENT_COUNT} >&2
    echo "Machine type for agents        : "${MACHINE_TYPE} >&2
}

function showConfigMinikube0 {
    :
}

function showConfigMinikube1 {
    echo
    echo "Deploy to Minikube Parameters" >&2
    echo "-----------------------------" >&2
    echo "Minikube CPU allocation        : "${MINICPU} >&2
    echo "Minikube RAM allocation        : "${MINIRAM} >&2
}
