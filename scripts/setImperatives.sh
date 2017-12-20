function setImperatives {
    if [[ $VENDOR_PATH"X" == "X" ]]
    then
        showError "Error" 5 "The vendor path is not set. Unable to continue."
        exit 5
    fi

    config_array=()

    #
    # Set configuration and persistence
    #

    if (( $MONGODB == 1 ))
    then
        if [[ ${TAGS}"X" != "X" ]]
        then
            showError "Error" 10 "MongoDB Persistence Engine is NOT supported on the ARM platform"
            exit 10
        fi
        # Using MongoDB
        config_array+=(conf/mongodb/cowbull-config.yaml)
        config_array+=($VENDOR_PATH/mongo-storage.yaml)
        config_array+=(conf/mongodb/deploy.yaml)
        config_array+=(conf/mongodb/service.yaml)
    elif (( $GCPSTORAGE == 1 ))
    then
        config_array+=(conf/gcpstorage/cowbull-config.yaml)
    else
        # Using Redis
        config_array+=(conf/redis/cowbull-config.yaml)
        config_array+=(conf/redis/redis-config.yaml)
        config_array+=(conf/redis/deploy.yaml)
        config_array+=(conf/redis/service.yaml)
    fi

    #
    # Add cowbull-server
    #
    config_array+=(conf/cowbull-server/deploy.yaml)
    config_array+=(conf/cowbull-server/service.yaml)


    #
    # Add cowbull webapp
    #
    config_array+=(conf/webapp/deploy.yaml)
    config_array+=(conf/webapp/service.yaml)

}

