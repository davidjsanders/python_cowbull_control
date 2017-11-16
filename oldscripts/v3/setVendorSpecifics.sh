function svs_Acs0 {
    :
}

function svs_Azure0 {
    :
}

function svs_Google0 {
    :
}

function svs_Minikube0 {
    :
}

function svs_Acs1 {
    if [[ $LOCATION == "**notset**" ]]
    then
        LOCATION="canadacentral"
    fi
    if [[ $MACHINE_TYPE == "**notset**" ]]
    then
        MACHINE_TYPE="Standard_A2"
    fi
    AUTOGROUP=${GROUP}"_"${CLUSTER}"_"${LOCATION}
    VENDOR_PATH=vendor/Azure
}

function svs_Azure1 {
    if [[ $LOCATION == "**notset**" ]]
    then
        LOCATION="westus2"
    fi
    if [[ $MACHINE_TYPE == "**notset**" ]]
    then
        MACHINE_TYPE="Standard_A2"
    fi
    AUTOGROUP="MC_"${GROUP}"_"${CLUSTER}"_"${LOCATION}
    VENDOR_PATH=vendor/Azure
}

function svs_Google1 {
    if [[ $LOCATION == "**notset**" ]]
    then
        LOCATION="us-east1-b"
    fi
    if [[ $MACHINE_TYPE == "**notset**" ]]
    then
        MACHINE_TYPE="n1-standard-2"
    fi
    VENDOR_PATH=vendor/Google
}

function svs_Minikube1 {
    VENDOR_PATH=vendor/minikube
}

function setVendorSpecifics {
    if (( $EXEACS == 0 )) && \
       (( $EXEAZURE == 0 )) && \
       (( $EXEGOOGLE == 0 )) && \
       (( $EXEMINIKUBE == 0 ))
    then
        showError "Error" 2 "No vendor selected" "A vendor needs to be specified in the command; e.g.: deploy minikube | deploy acs | deploy azure | deploy google."
        exit 2
    fi

    CLUSTER=${GROUP}"cluster"

    svs_Acs$EXEACS
    svs_Azure$EXEAZURE
    svs_Google$EXEGOOGLE
    svs_Minikube$EXEMINIKUBE
}
