function svs_Azure0 {
    :
}

function svs_Google0 {
    :
}

function svs_Minikube0 {
    :
}

function svs_Azure1 {
    AUTOGROUP="MC_"${GROUP}"_"${CLUSTER}"_"${LOCATION}
    if [[ $LOCATION == "**notset**" ]]
    then
        LOCATION="westus2"
    fi
    if [[ $MACHINE_TYPE == "**notset**" ]]
    then
        MACHINE_TYPE="Standard_A2"
    fi
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
}

function svs_Minikube1 {
    :
}

function setVendorSpecifics {
    svs_Azure$EXEAZURE
    svs_Google$EXEGOOGLE
    svs_Minikube$EXEMINIKUBE

    CLUSTER=${GROUP}"cluster"
}
