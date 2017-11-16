function deployK8Scomponents {
    if [[ $VENDOR_PATH"X" == "X" ]]
    then
        showError "Error" 5 "The vendor path is not set. Unable to continue."
        exit 5
    fi

    if [[ ${config_array[@]}"X" == "X" ]]; then return 0; fi

    echo >&2
    echo "Applying configuration" >&2
    echo "----------------------" >&2
    echo >&2


    for config_imperative in ${config_array[@]}
    do
        if (( DRYRUN == 1 ))
        then
            echo "kubectl apply -f $config_imperative" >&2
        else
            echo -n "Applying configuration in: $config_imperative ... "
            kubectl apply -f $config_imperative &> /tmp/ignore.me
            return_status=$?
            if (( $return_status != 0 ))
            then
                echo "failed" >&2
                showError "Error" 6 "The kubectl command reported an error $return_status. Exiting."
                exit 7
            else
                echo "done" >&2
            fi
        fi
    done
}
