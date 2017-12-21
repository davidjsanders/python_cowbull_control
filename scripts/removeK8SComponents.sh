function removeK8Scomponents {
    if [[ $VENDOR_PATH"X" == "X" ]]
    then
        showError "Error" 5 "The vendor path is not set. Unable to continue."
        exit 5
    fi

    if (( $EXEDOCKER == 1 ))
    then
        echo "" >&2
        echo "Applying docker configuration" >&2
        echo "-----------------------------" >&2
        echo >&2
        echo "Repo:  ${REPO}" >&2
        echo "Tags:  ${TAGS}" >&2
        echo >&2
        envsubst < conf/docker/compose-redis.yml > /tmp/tempo.yml
        docker-compose -p cowctl -f /tmp/tempo.yml down
        return $?
    fi

    if [[ ${config_array[@]}"X" == "X" ]]; then return 0; fi

    echo >&2
    echo "Clearing configuration" >&2
    echo "----------------------" >&2
    echo >&2

    for config_imperative in ${config_array[@]}
    do
        if (( DRYRUN == 1 ))
        then
            echo "kubectl delete -f $config_imperative --ignore-not-found" >&2
        else
            echo -n "Removing configuration in: $config_imperative ... "
            envsubst < $config_imperative | kubectl delete -f - --ignore-not-found &> /tmp/ignore.me
            return_status=$?
            if (( $return_status != 0 ))
            then
                echo "failed" >&2
                showError "Error" 6 "The kubectl command reported an error $return_status. Exiting."
                exit 6
            else
                echo "done" >&2
            fi
        fi
    done
}

