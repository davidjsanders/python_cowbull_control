function setVendor {
    if (( $EXEAZURE==1 ))
    then
        VENDOR_PATH=vendor/Azure
    elif (( $EXEGOOGLE==1 ))
    then
        VENDOR_PATH=vendor/Google
    else
        VENDOR_PAT=vendor/minikube
    fi
}
