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
    CLUSTER=${GROUP}"cluster"

    svs_Acs$EXEACS
    svs_Azure$EXEAZURE
    svs_Google$EXEGOOGLE
    svs_Minikube$EXEMINIKUBE
}
